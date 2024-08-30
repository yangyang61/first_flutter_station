import 'package:flutter/foundation.dart';
import 'package:flutter_first_station/constants.dart';
import 'package:flutter_first_station/utils/sp_utils.dart';

import '../repository/api.dart';

class MyViewModal with ChangeNotifier {
   String? username;
   bool? isLogin;

  Future initData() async {
    var value = await SpUtils.getString(Constants.SP_User_Name);
    if(value != null && value.isNotEmpty ==true){
      username = value;
      isLogin = true;
    }else {
      username = '未登录';
      isLogin = false;
    }
    notifyListeners();
  }
  
  Future logout(ValueChanged<bool> callback) async {
    bool? success = await  Api.instance.logout();
    if(success == true)  {
      await SpUtils.removeAll();
      callback.call(true);
    }else {
      callback.call(false);
    }
  }
}