import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelper {
  static Dio? dio;
  static void initial() {
    try {
      dio =
          Dio(
            BaseOptions(
              baseUrl: 'https://newsapi.org/',
              receiveDataWhenStatusError: true,
              connectTimeout: 3,
              receiveTimeout: 3,
            ),
          );
    } on Exception catch(error){
      print('founding error $error');
      throw Exception('error');
    }



  }

  static Future<Response> getData({
    @required url,
    @required Map<String, dynamic>? query,
  }) {
    return dio!.get(
      url,
      queryParameters: query,
    );
  }
}
