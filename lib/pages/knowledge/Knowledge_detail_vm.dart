import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first_station/repository/api.dart';
import 'package:flutter_first_station/repository/datas/knowledge_detail_data.dart';

import '../../repository/datas/knowledge_list_data.dart';

class KnowledgeDetailViewModal with ChangeNotifier {
  List<Tab> tabs = [];
  List<KnowledgeListItemData> detailListData = [];

  int _pageCount = 0;

  void initTabs(List<KnowledgeChildren>? tabList){
    if(tabList?.isNotEmpty ==true){
      tabList?.forEach((element) {
        tabs.add(Tab(text: element.name??"",));
      });
    }
  }

  Future getArticleList(String? cid,bool loadMore) async{
    if(loadMore==true){
      _pageCount ++;
    }else {
      _pageCount =0;
      detailListData.clear();
    }
    var rep = await Api.instance.getArticleList("$_pageCount", cid);
    if(rep?.isNotEmpty ==true) {
      detailListData.addAll(rep??[]);
      notifyListeners();
    }else {
      if(loadMore&&_pageCount>0 ){
        _pageCount--;
      }
    }
  }

}