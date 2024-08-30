import 'package:dio/dio.dart';
import 'package:flutter_first_station/http/base_modal.dart';
import 'package:flutter_first_station/pages/commom_ui/loading.dart';
import 'package:oktoast/oktoast.dart';

class ResponseInterceptor  extends Interceptor{

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: implement onRequest

    Loading.showLoading();

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
      Loading.dismissAll();
      if(response.statusCode == 200){
        try {
          var rep = BaseModal.fromJson(response.data);
          // 0 请求成功
          if(rep.errorCode==0){
            if(rep.data ==null){
              handler.next(Response(requestOptions: response.requestOptions,data:true));
            }else {
              handler.next(Response(requestOptions: response.requestOptions,data:rep.data));
            }
          // -1001 登录失效
          }else if(rep.errorCode==-1001){
            handler.reject(DioException(requestOptions: response.requestOptions,message:'请重新登录'));
            showToast('请先登录');
          }else if(rep.errorCode==-1){
            showToast(rep.errorMsg??'');
            if(rep.data ==null){
              handler.next(Response(requestOptions: response.requestOptions,data:false));
            }else {
              handler.next(Response(requestOptions: response.requestOptions,data:rep.data));
            }
          }
        }catch(e){
          handler.reject(DioException(requestOptions: response.requestOptions,message: '$e'));
        }
      }else {
        handler.reject(DioException(requestOptions: response.requestOptions,message: '错误！'));
      }
  }
}