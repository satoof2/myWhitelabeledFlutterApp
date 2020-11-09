import './chikyu_notifier.dart';
import './chikyu_session.dart';

class TestListPageState extends ListPageState {
  TestListPageState(chikyuSession) : super(chikyuSession);
}

class ListPageState with ChikyuNotifier {
ListPageState(this.chikyuSession);
  List<dynamic> listingRecords = [];
  bool hasFetched = false;
  final ChikyuSessionInterface chikyuSession;

  void getList() async {
    if (hasFetched) {
      return null;
    } else {
      return chikyuSession.callChikyApi('/entity/prospects/list',
          {'page_index': 1, 'items_per_page': 5}).then((chikyuApiResponseData) {
        final hjrh = chikyuApiResponseData.data;
        final prospects_list = hjh['list'];
        final prospect = prospects_list[0];
        var display_names = [];
        display_names.add(prospect['__display_name']);
        display_names.add(prospect[1]["__display_name"]);
        display_names.add(prospect[2]["__display_name"]);
        listingRecords = display_names;
        hasFetched = true;
        myNotifyListeners();
      });
    }
  }

}
