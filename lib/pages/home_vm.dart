import 'package:flutter/cupertino.dart';
import 'package:flutter_first_station/repository/api.dart';

import '../repository/datas/home_banner_data.dart';
import '../repository/datas/home_list_data.dart';


class HomeViewModel with ChangeNotifier {
  int pageCount =1;
  List<HomeBannerData?>? bannerList = [];
  List<HomeListItemData?>? listData= [];

   Future getBanner() async {

     List<HomeBannerData?>? list = await Api.instance.getBanner();
      bannerList = list ?? [];
    notifyListeners();
  }

  Future getHomeList(bool loadMore) async {
    if(loadMore){
      pageCount++;
    }else {
      pageCount=1;
      listData?.clear();
    }
    List<HomeListItemData?>? list = await Api.instance.getHomeList();
    if(loadMore){
      listData = list ?? [];
    }else {
      listData?.addAll(list??[]);
    }
    notifyListeners();
  }

  Future collectedOrNo(bool isCollected, String id,int index) async {
    bool success;
    if(isCollected == true){
      success = await Api.instance.collected(id);
    }else {
      success = await Api.instance.unCollected(id);
    }
    if(success ==true){
      listData?[index]?.collect = isCollected;
       notifyListeners();
    }
     return true;
  }
}