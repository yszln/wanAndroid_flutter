import 'dart:convert';

import 'package:wan_android_flutter/main/model/ArticleModel.dart';
import 'package:wan_android_flutter/main/model/BannerModel.dart';
import 'package:wan_android_flutter/main/model/CategoryModel.dart';
import 'package:wan_android_flutter/network/HttpUtils.dart';

class Api {
  /// 首页轮播
  static Future<BannerModel> getHomeBanner() async {
    // final url = baseUrl + "banner/json";

    /* return await http
        .get(url)
        .then((value) => BannerModel.fromJson(json.decode(value.body)))
        .catchError((error) {
      print(error.toString());
    });*/
    var response=HttpUtils.getInstance()
        .get("banner/json");
    var then = response.then((value) => BannerModel.fromJson(new Map<String,dynamic>.from(value.data)));
    return then;
  }

  ///首页文章
  static Future<ArticleModel> getHomeArticle(int page) async {
    return HttpUtils.getInstance()
        .get("article/list/${page}/json")
        .then((value) => ArticleModel.fromJson(json.decode(value.data)));
  }

  ///项目分类
  static Future<CategoryModel> getHomeCategory() async {
    return HttpUtils.getInstance()
        .get("project/tree/json")
        .then((value) => CategoryModel.fromJson(json.decode(value.data)));
  }
}
