import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './chikyu_session.dart';
import 'change_notifier.dart';
import 'chikyu_notifier.dart';

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

class NeedLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginstate = Provider.of<LoggedInStateChangeNotifier>(context);

    if (loginstate.isLoggedIn) {
      return Scaffold(
          appBar: AppBar(
            title: const Text('わかりみ'),
          ),
          body: Center(
              child: Column(
            children: <Widget>[
              RaisedButton(
                onPressed: loginstate.logout,
                child: const Text('ログアウト'),
              )
            ],
          )));
    } else {
      return Scaffold(
          appBar: AppBar(
            title: const Text('わかりみ'),
          ),
          body: Center(
              child: Column(
            children: <Widget>[
              RaisedButton(
                onPressed: loginstate.login,
                child: const Text('ログイン'),
              )
            ],
          )));
    }
  }
}

class LoggedOutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('logout tyuu'),
        ),
        body: Center(
            child: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: () => Provider.of<LoggedInState>(context).login(),
              child: const Text('ログイン'),
            )
          ],
        )));
  }
}

class LoggedInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('login tyuu'),
        ),
        body: Center(
            child: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: () => Provider.of<LoggedInState>(context).logout(),
              child: const Text('ログアウト'),
            )
          ],
        )));
  }
}
