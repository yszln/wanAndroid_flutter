class FriendModel {
  List<FriendItem> data;
  int errorCode;
  String errorMsg;

  FriendModel({this.data, this.errorCode, this.errorMsg});

  FriendModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<FriendItem>();
      json['data'].forEach((v) {
        data.add(new FriendItem.fromJson(v));
      });
    }
    errorCode = json['errorCode'];
    errorMsg = json['errorMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['errorCode'] = this.errorCode;
    data['errorMsg'] = this.errorMsg;
    return data;
  }
}

class FriendItem {
  String category;
  String icon;
  int id;
  String link;
  String name;
  int order;
  int visible;

  FriendItem(
      {this.category,
        this.icon,
        this.id,
        this.link,
        this.name,
        this.order,
        this.visible});

  FriendItem.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    icon = json['icon'];
    id = json['id'];
    link = json['link'];
    name = json['name'];
    order = json['order'];
    visible = json['visible'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['icon'] = this.icon;
    data['id'] = this.id;
    data['link'] = this.link;
    data['name'] = this.name;
    data['order'] = this.order;
    data['visible'] = this.visible;
    return data;
  }
}