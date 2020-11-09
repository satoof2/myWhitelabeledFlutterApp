// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:myfl/main.dart';
import '../lib/list_page.dart';
import '../lib/chikyu_session.dart';
import '../lib/chikyu.dart';


void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.

    final session = ChikyuSignLessSession();
    await session.login("", "");
    var state = ListPageState(session);
    await state.getList();
    var api_res = await ooo.callChikyApi("/entity/prospects/list", {"page_index":1, "items_per_page": 5});
    final list_prospect_res_data = api_res.data;
    await tester.pumpWidget(MyApp());



    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
    */
  });
}
