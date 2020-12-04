import 'dart:convert';

import 'package:wan_android_flutter/main/model/ArticleModel.dart';
import 'package:wan_android_flutter/main/model/BannerModel.dart';
import 'package:wan_android_flutter/main/model/CategoryModel.dart';
import 'package:wan_android_flutter/main/model/FriendModel.dart';
import 'package:wan_android_flutter/network/HttpUtils.dart';

class Api {
  /// 首页轮播
  static Future<BannerModel> getHomeBanner() async {
    var response = await HttpUtils.getInstance().get("banner/json");
    var data=BannerModel.fromJson(Map<String,dynamic>.from(response.data));
    return data;
  }

  ///首页文章
  static Future<ArticleModel> getHomeArticle(int page) async {
    var response =
        await HttpUtils.getInstance().get("article/list/${page}/json");
    return ArticleModel.fromJson(response.data);
  }

  ///项目分类
  static Future<CategoryModel> getHomeCategory() async {
    var response =await HttpUtils.getInstance().get("project/tree/json");
    return CategoryModel.fromJson(response.data);
  }

  //知识体系分类
  static Future<CategoryModel> getKnowledgeCategory() async{
    var response =await HttpUtils.getInstance().get("/tree/json");
    return CategoryModel.fromJson(response.data);
  }

  //知识体系文章
  static Future<ArticleModel> getKnowledgeArticle(int page,int cid) async {
    var response =
    await HttpUtils.getInstance().get("article/list/$page/json?cid=$cid");
    return ArticleModel.fromJson(response.data);
  }

  static Future<FriendModel> getFriendUrl() async{
    var response =
        await HttpUtils.getInstance().get("friend/json");
    return FriendModel.fromJson(response.data);
  }
}
