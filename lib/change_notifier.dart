import 'package:flutter/material.dart';
import 'chikyu_session.dart';
import 'chikyu_notifier.dart';
import 'list_page.dart';

class ListPageChangeNotifier extends ListPageState with ChangeNotifier {
  ListPageChangeNotifier(chikyuSession) : super(chikyuSession);

  @override
  void myNotifyListeners() {
    notifyListeners();
  }
}

class LoggedInStateChangeNotifier extends LoggedInState with ChangeNotifier {
  LoggedInStateChangeNotifier(isLoggedIn) : super(isLoggedIn);

  @override
  void myNotifyListeners() {
    notifyListeners();
  }
}

class ChikyuSessionChangeNotifier with ChangeNotifier {
  ChikyuSessionChangeNotifier(this.chikyuSession) {
    chikyuSession.logoutCallback = logoutCallback;
  }

  final ChikyuSessionInterface chikyuSession;
  bool isLoggedIn = false;

  void logoutCallback() {
    isLoggedIn = false;
    notifyListeners();
  }

  Future<void> login(String mail, String password) {
    return chikyuSession.login(mail, password).then((f) {
      isLoggedIn = true;
    });
  }

  Future<void> logout() {
    return chikyuSession.logout();
  }

  Future<ChikyuApiResponseData> callChikyApi(String path, Map params) {
    return chikyuSession.callChikyApi(path, params);
  }
}
