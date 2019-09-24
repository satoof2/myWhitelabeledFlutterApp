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
        final hjh = chikyuApiResponseData.data;
        final ddd = hjh['list'];
        final lll = ddd[0];
        var kkkk = [];
        kkkk.add(lll['__display_name']);
        kkkk.add(ddd[1]["__display_name"]);
        kkkk.add(ddd[2]["__display_name"]);
        listingRecords = kkkk;
        hasFetched = true;
        myNotifyListeners();
      });
    }
  }

}
