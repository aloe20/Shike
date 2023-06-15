import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flu/bean/http_result.dart';
import 'package:flutter/foundation.dart';

import 'http_interface.dart';

class HttpImpl implements IHttp {
  final Dio _dio = Dio();

  @override
  Future<List<BannerBean>> getBanner() async {
    final result = await _getHttp('http://192.168.1.10:8080/banner/json');
    if (result == null) {
      return [];
    } else {
      return HttpResult<List<BannerBean>>.fromJson(
          result,
          (json) => (json as List<dynamic>)
              .map((e) => BannerBean.fromJson(e))
              .toList()).data;
    }
  }

  Future<dynamic> _getHttp(String url) async {
    try{
      final response = await _dio.get(url);
      if (response.data == null) {
        debugPrint(jsonEncode(
            {'code': response.statusCode, 'msg': response.statusMessage}));
      } else {
        debugPrint(jsonEncode(response.data));
      }
      return response.data;
    } catch(e){
      debugPrint(e.toString());
      return null;
    }
  }
}
