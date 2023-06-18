import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flu/bean/http_result.dart';
import 'package:flutter/foundation.dart';

import 'http_interface.dart';

class HttpImpl implements IHttp {
  final Dio _dio = Dio();

  @override
  Future<List<BannerBean>> getBanner() async {
    final result = await _getHttp('banner/json');
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

  @override
  Future<List<ArticleBean>> getTop() async {
    final result = await _getHttp("article/top/json");
    if (result == null) {
      return [];
    } else {
      return HttpResult<List<ArticleBean>>.fromJson(
          result,
          (json) => (json as List<dynamic>)
              .map((e) => ArticleBean.fromJson(e))
              .toList()).data;
    }
  }

  @override
  Future<List<ArticleBean>> getHomeList(int index) async {
    dynamic result = await _getHttp("article/list/$index/json");
    if (result == null) {
      return [];
    } else {
      result = HttpResult<dynamic>.fromJson(result, (json) => (json as Map))
          .data["datas"];
      return (result as List<dynamic>)
          .map((e) => ArticleBean.fromJson(e))
          .toList();
    }
  }

  Future<dynamic> _getHttp(String url) async {
    try {
      final response = await _dio.get(
          url.startsWith("http") ? url : "https://www.wanandroid.com/$url");
      if (response.data == null) {
        debugPrint(jsonEncode(
            {'code': response.statusCode, 'msg': response.statusMessage}));
      } else {
        debugPrint(jsonEncode(response.data));
      }
      return response.data;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
