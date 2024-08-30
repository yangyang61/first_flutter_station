import 'package:flutter/cupertino.dart';
import 'package:flutter_first_station/repository/datas/hot_friend_data.dart';
import 'package:flutter_first_station/repository/datas/hot_key_data.dart';
import 'package:flutter_first_station/repository/datas/knowledge_detail_data.dart';
import 'package:flutter_first_station/repository/datas/knowledge_list_data.dart';
import 'package:flutter_first_station/repository/datas/search_data.dart';

import '../http/http_method.dart';
import 'datas/auth_data.dart';
import 'datas/home_banner_data.dart';
import 'package:dio/dio.dart';

import 'datas/home_list_data.dart';

class Api {
  static Api instance =  Api._();

  Api._();

  Future<List<HomeBannerData?>?>  getBanner() async {

    Response response =  await DioInstance.instance().get(path: "/banner/json");
    HomeBannerListData homeBannerData = HomeBannerListData.fromJson(response.data);

    return homeBannerData.bannerList;
  }

  Future<List<HomeListItemData?>?> getHomeList() async {
    Response response =  await DioInstance.instance().get(path: "/article/list/1/json");
    HomeListData homeData = HomeListData.fromJson(response.data);

    return homeData.datas;
  }

  Future<List<HotFriendData?>?>  getFriend() async {

    Response response =  await DioInstance.instance().get(path: "/friend/json");
    HotFriendListData friendListData = HotFriendListData.fromJson(response.data);

    return friendListData.listData;
  }

  Future<List<HotKeyData?>?>  getHotkey() async {
    Response response =  await DioInstance.instance().get(path: "/hotkey/json");
    HotKeyListData hotkeyData = HotKeyListData.fromJson(response.data);
    return hotkeyData.listData;
  }

  Future<dynamic> register({String? username,String? password,String? repassword}) async {
    Response response =  await DioInstance.instance().post(path: "/user/register",param: {"username":username,"password":password,"repassword":repassword});
    return response.data;
  }

  Future<AuthData> login({String? username,String? password}) async {
    Response response =  await DioInstance.instance().post(path: "/user/login",param: {"username":username,"password":password,});
    return AuthData.fromJson(response.data) ;
  }

  Future<List<KnowledgeListData?>?> getKnowledge() async {
    Response response =  await DioInstance.instance().get(path: "/tree/json",);
    KnowledgeData listData =   KnowledgeData.fromJson(response.data) ;
    return listData.list;
  }

  Future<bool> collected( String id) async {
    Response response =  await DioInstance.instance().post(path: "/lg/collect/$id/json",);
    if(response.data != null && response.data is bool) {
      return response.data;
    }
    return true;
  }

  Future<bool> unCollected( String id) async {
    Response response =  await DioInstance.instance().post(path: "/lg/uncollect_originId/$id/json",);
    if(response.data != null && response.data is bool) {
      return response.data;
    }
    return true;
  }

  Future<bool?> logout() async {
    Response response =  await DioInstance.instance().get(path: "/user/logout/json",);
    if(response.data != null && response.data is bool) {
      return response.data;
    }
    return true;
  }

  Future<List<KnowledgeListItemData>?> getArticleList(String? pageCount, String? cid) async {
    Response response =  await DioInstance.instance().get(path: "/article/list/$pageCount/json",param: {"cid":cid});
   var knowledgeDetailListData = KnowledgeDetailListData.fromJson(response.data);
    return knowledgeDetailListData.datas;
  }

  Future<List<SearchListItemData>?> searchList(String? pageCount, String? keyword) async {
    Response response =  await DioInstance.instance().post(path: "/article/query/$pageCount/json",param: {"k":keyword});
    var searchList = SearchListData.fromJson(response.data);
    return searchList.datas;
  }
}

