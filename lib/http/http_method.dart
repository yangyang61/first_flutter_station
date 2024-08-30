import 'package:dio/dio.dart';
import 'package:flutter_first_station/http/cookie_interceptor.dart';
import 'package:flutter_first_station/http/dio_instance.dart';
import 'package:flutter_first_station/http/print_log_interceptor.dart';
import 'package:flutter_first_station/http/rep_interceptor.dart';

class DioInstance {
  static DioInstance?  _instance;
  DioInstance._();

  static DioInstance instance() {
    return _instance ??= DioInstance._();
  }

  final Dio _dio =  Dio();
  final _defaultTime =const Duration(seconds: 30);
  void initDio({
    required String baseUrl,
    String? method = HttpMethod.GET,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    ResponseType? responseType = ResponseType.json,
    String? contentType
  }) {
    _dio.options = BaseOptions(
    method: method,
    baseUrl: baseUrl,
    connectTimeout: connectTimeout ?? _defaultTime,
    receiveTimeout:  receiveTimeout ?? _defaultTime,
    sendTimeout:  sendTimeout ?? _defaultTime,
        responseType:responseType,
        contentType: contentType
    );
    _dio.interceptors.add(CookieInterceptor());
    _dio.interceptors.add(PrintLogInterceptor());
    _dio.interceptors.add(ResponseInterceptor());
  }

  Future<Response> get({
    required String path,
    Map<String, dynamic>? param,
    Options? options,
    CancelToken? cancelToken
  }) async{
    return await _dio.get(path,queryParameters: param,options: options ?? Options(method: HttpMethod.GET,receiveTimeout:_defaultTime,sendTimeout: _defaultTime),cancelToken: cancelToken);
  }

  Future<Response> post({
    required String path,
    Object? data,
    Map<String, dynamic>? param,
    Options? options,
    CancelToken? cancelToken
  }) async{
    return await _dio.post(path,queryParameters: param,data:data,options: options ?? Options(method: HttpMethod.GET,receiveTimeout:_defaultTime,sendTimeout: _defaultTime),cancelToken: cancelToken);
  }
}

