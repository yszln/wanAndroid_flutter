import 'CommonArticle.dart';

class ArticleModel {
  PageModel data;
  int errorCode;
  String errorMsg;

  ArticleModel({this.data, this.errorCode, this.errorMsg});

  ArticleModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new PageModel.fromJson(json['data']) : null;
    errorCode = json['errorCode'];
    errorMsg = json['errorMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['errorCode'] = this.errorCode;
    data['errorMsg'] = this.errorMsg;
    return data;
  }
}

class PageModel {
  int curPage;
  List<CommonArticle> datas;
  int offset;
  bool over;
  int pageCount;
  int size;
  int total;

  PageModel(
      {this.curPage,
        this.datas,
        this.offset,
        this.over,
        this.pageCount,
        this.size,
        this.total});

  PageModel.fromJson(Map<String, dynamic> json) {
    curPage = json['curPage'];
    if (json['datas'] != null) {
      datas = new List<CommonArticle>();
      json['datas'].forEach((v) {
        datas.add(CommonArticle.fromJson(v));
      });
    }
    offset = json['offset'];
    over = json['over'];
    pageCount = json['pageCount'];
    size = json['size'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['curPage'] = this.curPage;
    if (this.datas != null) {
      data['datas'] = this.datas.map((v) => v.toJson()).toList();
    }
    data['offset'] = this.offset;
    data['over'] = this.over;
    data['pageCount'] = this.pageCount;
    data['size'] = this.size;
    data['total'] = this.total;
    return data;
  }
}

