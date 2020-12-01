import 'package:flutter/material.dart';
import 'package:wan_android_flutter/search/SearchPage.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}


class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: Column(
        children: [
          _topTitle(),
          _search(),
        ],
      ),
    );
  }

  _topTitle() {
    return Row(
      children: [
        Expanded(
            child: Container(
                child: Text('玩安卓'), padding: EdgeInsets.only(left: 18))),
        Container(
            child: Icon(Icons.cloud_queue_sharp),
            padding: EdgeInsets.only(right: 18)),
        Container(
            child: Icon(Icons.message), padding: EdgeInsets.only(right: 18)),
      ],
    );
  }

  _search() {
    return Container(
      height: 40,
      margin: EdgeInsets.only(left: 9, right: 9, top: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Colors.grey[300],
      ),
      child: TextField(
        onTap: (){
          _toSearch();
        },
        decoration: InputDecoration(
            hintText: '请输入关键字',
            prefixIcon: Icon(
              Icons.search,
              color: Colors.greenAccent,
            ),
            border: InputBorder.none),
      ),
    );
  }
  void _toSearch() {
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return SearchPage();
    }));
  }

}


