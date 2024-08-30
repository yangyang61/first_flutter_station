import 'package:flutter/cupertino.dart';
import 'package:flutter_first_station/constants.dart';
import 'package:flutter_first_station/repository/datas/auth_data.dart';
import 'package:flutter_first_station/utils/sp_utils.dart';
import 'package:oktoast/oktoast.dart';

import '../repository/api.dart';

class AuthViewModal with ChangeNotifier {
  RegisterInfo registerInfo = RegisterInfo();
  LoginInfo loginInfo = LoginInfo();

  Future<bool?> register() async {
   if(registerInfo.username !=null && registerInfo.password != null && registerInfo.repassword!=null && registerInfo.password == registerInfo.repassword){
      if(registerInfo.password?.length ==6){
       dynamic callback =  await Api.instance.register(username: registerInfo.username,password: registerInfo.password,repassword: registerInfo.repassword);
        if(callback is bool){
          return callback;
        }else {
          return true;
        }
      }
      showToast('密码长度必须超过6位');
      return false ;
   }
   showToast('输入不能为空或者密码必须一致');
   return false;
  }

  Future<bool?> login() async {
    if(loginInfo.username !=null && loginInfo.password != null){
      AuthData authData =  await Api.instance.login(username: loginInfo.username,password: loginInfo.password,);
     if(authData.username != null && authData.username?.isNotEmpty == true){
       showToast('登录成功');
       SpUtils.saveString(Constants.SP_User_Name, authData.username??"");
       return true;
     }
     showToast('登录失败');
     return false;
    }
    showToast('输入不能为空！');
    return false ;
  }
}

class RegisterInfo {
  String? username;
  String? password;
  String? repassword;
}
class LoginInfo {
  String? username;
  String? password;
}