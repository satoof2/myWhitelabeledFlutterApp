import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'change_notifier.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginstate = Provider.of<ChikyuSessionChangeNotifier>(context);

    return Scaffold(
        appBar: AppBar(),
        drawer: Drawer(
            child: const Placeholder() // Populate the Drawer in the next step.
            ),
        body: Center(
            child: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: () => loginstate
                      .login('myuseremail', 'mypassword')
                      .then((f) {
                    var aa = 0;
                    Navigator.of(context).pushNamed('/second');
                  }),
              child: const Text('ログイン'),
            )
          ],
        )));
  }
}
