import 'dart:convert';

import 'package:wan_android_flutter/main/model/ArticleModel.dart';
import 'package:wan_android_flutter/main/model/BannerModel.dart';
import 'package:wan_android_flutter/main/model/CategoryModel.dart';
import 'package:wan_android_flutter/main/model/FriendModel.dart';
import 'package:wan_android_flutter/network/HttpUtils.dart';
import 'package:wan_android_flutter/user/LoginModel.dart';

class Api {
  /// 首页轮播
  static Future<BannerModel> getHomeBanner() async {
    var response = await HttpUtils.getInstance().get("banner/json");
    var data = BannerModel.fromJson(Map<String, dynamic>.from(response.data));
    return data;
  }

  ///首页文章
  static Future<ArticleModel> getHomeArticle(int page) async {
   return getArticle("article/list/${page}/json");
  }

  //通用文章列表
  static Future<ArticleModel> getArticle(String url) async{
    var response =
        await HttpUtils.getInstance().get(url);
    return ArticleModel.fromJson(response.data);
  }

  //置顶文章
  static Future<ArticleModel> getTopArticle() async{
    return getArticle("/article/top/json");
  }

  //广场文章
  static Future<ArticleModel> getUserList(int page)async{
    return getArticle('/user_article/list/$page/json');
  }

  ///项目分类
  static Future<CategoryModel> getHomeCategory() async {
    var response = await HttpUtils.getInstance().get("project/tree/json");
    return CategoryModel.fromJson(response.data);
  }

  //知识体系分类
  static Future<CategoryModel> getKnowledgeCategory() async {
    var response = await HttpUtils.getInstance().get("/tree/json");
    return CategoryModel.fromJson(response.data);
  }

  //知识体系文章
  static Future<ArticleModel> getKnowledgeArticle(int page, int cid) async {
   return getArticle("article/list/$page/json?cid=$cid");
  }

  //常用网站
  static Future<FriendModel> getFriendUrl() async {
    var response = await HttpUtils.getInstance().get("friend/json");
    return FriendModel.fromJson(response.data);
  }

  //登陆
  static Future<LoginModel> login(String username, String passwd) async {
    var response = await HttpUtils.getInstance()
        .post('/user/login', data: {"username": username, "password": passwd});
    return LoginModel.fromJson(response.data);
  }
}
