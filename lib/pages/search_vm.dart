import 'package:flutter/cupertino.dart';
import 'package:flutter_first_station/repository/api.dart';
import 'package:flutter_first_station/repository/datas/search_data.dart';

class SearchViewModal with ChangeNotifier {
  List<SearchListItemData> searchList = [];
  late int _pageCount = 0;

  Future search(String? keyword,bool loadMore,) async {
    if(loadMore==true){
      _pageCount ++;
    }else {
      _pageCount =0;
      searchList.clear();
    }
    var resp =  await Api.instance.searchList("$_pageCount", keyword);
    if(resp?.isNotEmpty ==true) {
      searchList.addAll(resp??[]);
      notifyListeners();
    }else {
      if( loadMore && _pageCount > 0 ){
        _pageCount--;
      }
    }
  }
}