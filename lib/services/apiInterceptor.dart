import 'dart:convert';
import 'dart:html';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/**
 * 拦截器
 */
class ApiInterceptor extends Interceptor {

  //请求前校验
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kIsWeb) {
      // web端可以使用localStorage存储
      options.headers['Authorization'] = window.localStorage['Authorization']??null;
    } else {
      // 移动平台和桌面平台可以使用SharedPreferences存储
      SharedPreferences.getInstance().then((prefs) {
        options.headers['Authorization'] = prefs.getString('Authorization')??null;
      });
    }
    print('REQUEST[${options.method}] => PATH: ${options.path}');
    super.onRequest(options, handler);
  }

  //请求后校验
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.headers.map['Authorization'] != null) {
      if (kIsWeb) {
        // web端可以使用localStorage存储
        window.localStorage['Authorization'] = response.headers.map['Authorization']![0];
      } else {
        // 移动平台和桌面平台可以使用SharedPreferences存储
        SharedPreferences.getInstance().then((prefs) {
          prefs.setString('Authorization', response.headers.map['Authorization']![0]);
        });
      }
    }
    print('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  //请求错误校验
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    super.onError(err, handler);
  }
}