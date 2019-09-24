import 'package:http/http.dart' as http;
import 'dart:convert';
import './chikyu_notifier.dart';

class ChikyuSession {
  static ChikyuSessionInterface getChikyuSessionInstance() {
    return MockSession();
  }
}

abstract class ChikyuSessionInterface {
  Future<void> login(String mail, String password);

  Future<void> logout();

  Future<ChikyuApiResponseData> callChikyApi(String path, Map params);

  bool needLogin();

  Function() logoutCallback;
}

class MockSession extends ChikyuSessionInterface {
  bool isLoggedIn;

  @override
  Future<void> login(String mail, String password) async {
    isLoggedIn = true;
  }

  @override
  Future<void> logout() async {
    isLoggedIn = false;
    logoutCallback();
  }

  @override
  Future<ChikyuApiResponseData> callChikyApi(String path, Map params) async {
    return ChikyuApiResponseData(false, '', {});
  }

  @override
  bool needLogin() {
    return isLoggedIn;
  }
}

class EntityListRequestData {
  EntityListRequestData(this.collectionName);

  final String collectionName;
}

class EntityResponseData {
  EntityResponseData(this.text1, this.text2);

  final String text1;
  final String text2;
}

class ChikyuApiResponseData {
  ChikyuApiResponseData(this.hasError, this.message, this.data);

  final bool hasError;
  final String message;
  final Map data;
}

class ChikyuSignLessSession extends ChikyuSessionInterface {
  final String chikyuApiGatewayBaseUrl =
      'https://gateway.chikyu.mobi/dev/api/v2';

  String loginToken;
  String loginTokenSecret;
  String sessionId;
  String cognitoIdentityId;
  String apiKey;
  Function() logoutCallback;

  @override
  Future<void> login(String mail, String password) async {
    final createLoginTokenUrl =
        '$chikyuApiGatewayBaseUrl/open/session/token/create';

    final themap = {
      'data': {
        'token_name': 'dart',
        'email': mail,
        'password': password,
        'duration': 900000000
      }
    };

    final createLoginTokenResponse = await http.post(createLoginTokenUrl,
        body: json.encode(themap),
        headers: {'Content-Type': 'application/json'});

    final resBody = json.decode(createLoginTokenResponse.body);
    final createTokenCallHasError = resBody['has_error'];
    final createTokenResponseData = resBody['data'];

    loginToken = createTokenResponseData['login_token'];
    loginTokenSecret = createTokenResponseData['login_secret_token'];

    final endpoint_url = '$chikyuApiGatewayBaseUrl/open/session/login';

    final request = {
      'data': {
        'token_name': 'dart',
        'login_token': loginToken,
        'login_secret_token': loginTokenSecret
      }
    };

    final createSessionResponse = await http.post(endpoint_url,
        body: json.encode(request),
        headers: {'Content-Type': 'application/json'});

    final createSessionResBody = json.decode(createSessionResponse.body);
    final createSessionCallHasError = createSessionResBody['has_error'];
    final createSessionResponseData = createSessionResBody['data'];

    cognitoIdentityId = createSessionResponseData['cognito_identity_id'];
    apiKey = createSessionResponseData['api_key'];
    sessionId = createSessionResponseData['session_id'];

  }

  @override
  Future<void> logout() async {
    apiKey = '';
    cognitoIdentityId = '';
    loginToken = '';
    loginTokenSecret = '';
    sessionId = '';
    logoutCallback();
  }

  Future<void> loadAuthInfoFromLocalStorage() async {}

  Future<void> saveAuthInfoToLocalStorage() async {}

  @override
  bool needLogin() {
    return apiKey.isEmpty &&
        cognitoIdentityId.isEmpty &&
        loginToken.isEmpty &&
        loginTokenSecret.isEmpty &&
        sessionId.isEmpty;
  }

  @override
  Future<ChikyuApiResponseData> callChikyApi(String path, Map params) {
    final postUrl = '$chikyuApiGatewayBaseUrl/signless/$path';

    final headers = {
      'Content-Type': 'application/json',
      'X-API-KEY': apiKey,
      // 下は謎　なくてもいけるかもしれないが一応入れておく
      'X-AUTH-KEY': 'a'
    };
    final bodyParams = {
      'data': params,
      'identity_id': cognitoIdentityId,
      // saltは意味がない signlessのサーバー側で無効化されているが、ないとエラー
      'salt': 'aaaa',
      'session_id': sessionId
    };
    return http
        .post(postUrl, headers: headers, body: json.encode(bodyParams))
        .then((chikyuResponse) {
      final statusCode = chikyuResponse.statusCode;
      // todo handle 401 403 logoutする
      final resMap = json.decode(chikyuResponse.body);

      final hasError = resMap['has_error'];
      final message = resMap['message'];
      final data = resMap['data'];
      return ChikyuApiResponseData(hasError, message, data);
    });
  }

  List<int> aa() {
    return [1];
  }
}
