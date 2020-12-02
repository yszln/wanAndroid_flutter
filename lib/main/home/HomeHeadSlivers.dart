import 'package:flutter/material.dart';
import 'package:wan_android_flutter/search/SearchPage.dart';

class HomeHeadSlivers extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeHeadState();
  }
}

class HomeHeadState extends State<HomeHeadSlivers> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      expandedHeight: 110,
      floating: false,
      pinned: true,
      snap: false,
      actions: [
        ///扫码图标
        Container(
          width: 35,
          child: Center(
            child: IconButton(
              icon: Icon(
                Icons.crop_free,
                color: Colors.grey[250],
              ),
              onPressed: (){

              },
            ),
          ),
        ),
        ///消息图标
        Container(
          width: 35,
          child: Center(
            child: IconButton(
              icon: Icon(
                Icons.message,
                color: Colors.grey[250],
              ),
              onPressed: (){

              },
            ),
          ),
        ),

      ],
      ///标题
      title: Text('玩安卓',style: TextStyle(fontSize: 14),),


      ///搜索
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Container(
          height: 32,
          width: MediaQuery.of(context).size.width * 0.7-35,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
          child: TextField(
            onTap: (){_toSearch();},
            style: TextStyle(fontFamily: "PingFang"),
            decoration: InputDecoration(
              hintText: '请输入商品名称',
              hintStyle: TextStyle(
                fontSize: 12,
              ),
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.search,
                color: Colors.grey,
                size: 15,
              ),
              suffixIcon: Icon(
                Icons.cancel,
                color: Colors.grey,
                size: 15,
              ),
            ),
          ),
        ),
        collapseMode: CollapseMode.parallax,
      ),


    );
  }

  void _toSearch() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return SearchPage();
    }));
  }
}
