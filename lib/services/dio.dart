// import 'package:flutter/foundation.dart';
// import 'package:dio/dio.dart';
// import 'package:my_blog/services/apiInterceptor.dart';
//
// class DioSingleton {
//   static final DioSingleton _singleton = DioSingleton._internal();
//
//   factory DioSingleton() => _singleton;
//
//   static late Dio _dio;
//
//   DioSingleton._internal() {
//     if (_dio == null) {
//       _dio = Dio(BaseOptions(
//         baseUrl: 'https://jsonplaceholder.typicode.com',
//         connectTimeout: Duration(seconds: 5),
//         receiveTimeout: Duration(seconds: 5),
//         headers: {
//           'Accept': 'application/json',
//           'Content-Type': 'application/json',
//         },
//       ))
//         //..interceptors.add(DioCacheManager(CacheConfig(baseUrl: 'https://jsonplaceholder.typicode.com')).interceptor)
//         //..interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
//         ..interceptors.add(ApiInterceptor());
//     }
//   }
//
//   Dio get dio => _dio;
// }

import 'package:dio/dio.dart';

import '../common/constants.dart';
import 'apiInterceptor.dart';

/*
dio网络请求封装（单例模式）
 */
final Dio dio = Dio(BaseOptions(
  baseUrl: '${Constants.apiBaseUrl}',
  connectTimeout: Duration(seconds: 15),
  receiveTimeout: Duration(seconds: 15),
  headers: {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  },
))
  ..interceptors.add(ApiInterceptor())
  ..interceptors.add(LogInterceptor(responseBody: false));
