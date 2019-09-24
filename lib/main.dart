import 'package:flutter/material.dart';
import './sec_page.dart';
import 'package:provider/provider.dart';
import 'change_notifier.dart';
import 'chikyu_session.dart';
import 'login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChikyuSessionChangeNotifier>(
        builder: (context) {
          final chikyuSession = ChikyuSignLessSession();
          return ChikyuSessionChangeNotifier(chikyuSession);
        },
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            // This is the theme of your application.
            //
            primarySwatch: Colors.blue,
          ),
          home: LoginPage(),
          routes: {
            '/second': (BuildContext context) => ListPage(),
          },
        ));
  }
}

class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var loginstate = Provider.of<ChikyuSessionChangeNotifier>(context);
    return ChangeNotifierProvider<ListPageChangeNotifier>(
      builder: (context) {
        return ListPageChangeNotifier(loginstate);
      },
      child: ListPageStatelessWidget(),
    );
  }
}

class ListPageStatelessWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final listState = Provider.of<ListPageChangeNotifier>(context);
    final listItem = listState.listingRecords;
    listState.getList();

    final listLen = listItem.length;

    return Scaffold(
        body: Container(
          color: Color(0xff82bedc),
          child: SafeArea(
            child: Container(
              color: Colors.white,
              child: Column(
      children: <Widget>[
              Container(
                height: 90,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      width: 80,
                      child: Image.asset('assets/menu_button_72.png'),
                    ),
                    const Expanded(
                      child: Placeholder(),
                    )
                  ],
                ),
              ),
              Container(
                height: 50,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      width: 40,
                      child: Image.asset('assets/ios_filter_button.png'),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text('見込客一覧${listLen.toString()}'),
                      ),
                    ),
                    Container(
                      width: 40,
                      child: Image.asset('assets/ios_add_button.png'),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                      child: Container(
                          color: const Color(0xFFD7E9F1),
                          child: const Text('全見込客一覧'),
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(
                              top: 8.0, right: 16.0, left: 16.0)),
                    ),
                    Expanded(
                        child: Container(
                      padding: const EdgeInsets.only(),
                      color: const Color(0xFFD7E9F1),
                      child: ListView.builder(
                          padding: const EdgeInsets.only(right: 16, left: 16),
                          itemBuilder: (BuildContext content, int index) {
                            return SizedBox(
                              height: 50,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 50,
                                    color: const Color(0xFFFFFFFF),
                                    child:
                                        Image.asset('assets/ios_prospect_blue.png'),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            color: const Color(0xFFFFFFFF),
                                            child: Text(listItem[index]),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            color: const Color(0xFFFFFFFF),
                                            child: const Text('mikomikyaku'),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    color: const Color(0xFFFFFFFF),
                                    width: 50,
                                    child: Image.asset(
                                        'assets/ios_command_button_with_frame.png'),
                                  ),
                                ],
                              ),
                            );
                          },
                          itemCount: listItem.length),
                    )),
                  ],
                ),
              )
      ],
    ),
            ),
          ),
        ));
  }
}
