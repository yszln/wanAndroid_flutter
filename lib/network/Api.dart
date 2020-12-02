import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wan_android_flutter/main/model/ArticleModel.dart';
import 'package:wan_android_flutter/main/model/BannerModel.dart';
import 'package:wan_android_flutter/main/model/CategoryModel.dart';

class Api {
  static final baseUrl = 'https://www.wanandroid.com/';

  /// 首页轮播
  static Future<BannerModel> getHomeBanner() async {
    final url = baseUrl + "banner/json";

    return await http
        .get(url)
        .then((value) => BannerModel.fromJson(json.decode(value.body)))
        .catchError((error) {
      print(error.toString());
    });
  }

  ///首页文章
  static Future<ArticleModel> getHomeArticle(int page) async {
    final url = baseUrl + 'article/list/${page}/json';
    return await http.get(url).then((value) {
      print("请求成功" + value.body);
      return ArticleModel.fromJson(json.decode(value.body));
    }).catchError((error) {
      print("请求失败" + error.toString());
    });
  }

  ///项目分类
  static Future<CategoryModel> getHomeCategory() async {
    final url = baseUrl + 'project/tree/json';
    return await http.get(url).then((value) {
      print("请求成功" + value.body);
      return CategoryModel.fromJson(json.decode(value.body));
    }).catchError((error) {
      print("请求失败" + error.toString());
    });
  }
}
