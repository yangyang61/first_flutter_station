import 'package:flutter/cupertino.dart';
import 'package:flutter_first_station/repository/api.dart';
import 'package:flutter_first_station/repository/datas/hot_friend_data.dart';
import 'package:flutter_first_station/repository/datas/hot_key_data.dart';

class HotViedModal with ChangeNotifier {

  List<HotFriendData?>? friendData;
  List<HotKeyData?>? hotKeyData;


  Future getFriend() async {
    List<HotFriendData?>? list = await Api.instance.getFriend();
    friendData = list ?? [];
  }

  Future getHotkey() async {
    List<HotKeyData?>? list = await Api.instance.getHotkey();
    hotKeyData = list ?? [];
  }
}