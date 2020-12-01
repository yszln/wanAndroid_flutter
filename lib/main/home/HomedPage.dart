import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wan_android_flutter/main/model/BannerModel.dart';
import 'package:wan_android_flutter/network/Api.dart';
import 'package:wan_android_flutter/search/SearchPage.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  List<BannerItem> banners = [];

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(child: ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: Column(
        children: [
          _topTitle(),
          _search(),
          _banner(),
          // _tab(),
        ],
      ),
    ), onRefresh: (){

    });
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
        onTap: () {
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
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return SearchPage();
    }));
  }

  _banner() {
    return Container(
      height: 200,
      margin: EdgeInsets.only(top: 6),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return new Image.network(
            banners[index].imagePath,
            fit: BoxFit.fill,
          );
        },
        itemCount: banners.length,
        pagination: new SwiperPagination(),
        // control: new SwiperControl(),
      ),
    );
  }

  void _refreshData() {
    Api.getHomeBanner().then((value) {
      setState(() {
        banners = value.data;
      });
    });
  }

  _tab() {
    return ListView();
  }
}
