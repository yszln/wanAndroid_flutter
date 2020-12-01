import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wan_android_flutter/main/model/BannerModel.dart';

class Api {
  static Future<BannerModel> getHomeBanner() async {
    final url = "https://www.wanandroid.com/banner/json";

    return await http
        .get(url)
        .then((value) => BannerModel.fromJson(json.decode(value.body)))
    .catchError((error){
      print(error.toString());
    });
  }
}
