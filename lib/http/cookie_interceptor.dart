import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_first_station/constants.dart';
import 'package:flutter_first_station/utils/sp_utils.dart';

class CookieInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: implement onRequest
   SpUtils.getStringList(Constants.SP_COOKIE_LIST).then((value) {
     options.headers[HttpHeaders.cookieHeader] = value;
     handler.next(options);
   });

  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    if(response.requestOptions.path.contains('/user/login')){
      dynamic list = response.headers[HttpHeaders.setCookieHeader];
      List<String> cookieList = [];
     if(list is List){
       for(String? cookie in list){
         cookieList.add(cookie ?? "");
       }
       SpUtils.saveStringList(Constants.SP_COOKIE_LIST, cookieList);
     }
    }
    super.onResponse(response, handler);
  }
}