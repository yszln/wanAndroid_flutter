import 'dart:ui';

import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _search(),
    );
  }
}

_search() {
  final double statusHeight=MediaQueryData.fromWindow(window).padding.top;
  return Container(
    height: 40,
    margin: EdgeInsets.only(left: 9, right: 9, top: statusHeight),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      color: Colors.grey[300],
    ),
    child: TextField(
      onChanged: (text) {
        _searchChange(text);
      },
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
          hintText: '请输入关键字',
          prefixIcon: Icon(
            Icons.search,
            color: Colors.greenAccent,
          ),
          suffixIcon: Icon(Icons.cancel),
          border: InputBorder.none),
    ),
  );
}


void _searchChange(String text) {}
