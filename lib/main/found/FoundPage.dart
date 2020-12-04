import 'package:flutter/material.dart';
import 'package:wan_android_flutter/common/WebViewPage.dart';
import 'package:wan_android_flutter/main/model/FriendModel.dart';
import 'package:wan_android_flutter/network/Api.dart';

class FoundPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FoundPageState();
  }
}

class _FoundPageState extends State<FoundPage> {
  List<FriendItem> items = [];

  @override
  void initState() {
    super.initState();
    _getUrls();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('发现'),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 8),
        child: Wrap(
          children: _Tags(),
        ),
      ),
    );
  }

  void _getUrls() {
    Api.getFriendUrl().then((value) {
      setState(() {
        items.addAll(value.data);
      });
    });
  }

  _Tags() {
    List<Widget> tags = [];
    items.forEach((element) {
      tags.add(GestureDetector(
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3),
          margin: EdgeInsets.only(bottom: 5, left: 3, right: 3, top: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.grey[200]),
          child: Text(element.name),
        ),
        onTap: () {
          WebViewPage.toWeb(context, element.link, element.name);
        },
      ));
    });
    return tags;
  }
}
