import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wan_android_flutter/common/WebViewPage.dart';
import 'package:wan_android_flutter/main/home/HomeBannerSlivers.dart';
import 'package:wan_android_flutter/main/home/HomeHeadSlivers.dart';
import 'package:wan_android_flutter/main/model/BannerModel.dart';
import 'package:wan_android_flutter/main/model/CategoryModel.dart';
import 'package:wan_android_flutter/main/model/CommonArticle.dart';
import 'package:wan_android_flutter/network/Api.dart';
import 'package:wan_android_flutter/search/SearchPage.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  int page = 0;
  List<BannerItem> banners = [];
  List<CommonArticle> articles = [];
  List<CategoryItem> categorys=[];

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> _tabs = ['Tab 1', 'Tab 2'];
    /*return NotificationListener(
        onNotification: (ScrollNotification scrollInfo) =>
            _onScrollNotification(scrollInfo),
        child: RefreshIndicator(
            child: DefaultTabController(
              length: _tabs.length,
              child: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  // These are the slivers that show up in the "outer" scroll view.
                  return <Widget>[
                    SliverAppBar(
                      title: _topTitle(),
                      expandedHeight: 0,
                      forceElevated: innerBoxIsScrolled,
                    ),
                    SliverAppBar(
                      title: _search(),
                      titleSpacing: 0,
                      pinned: true,
                      expandedHeight: 0,
                      forceElevated: innerBoxIsScrolled,
                    ),
                    SliverAppBar(
                      title: _banner(),
                      expandedHeight: 0,
                      forceElevated: innerBoxIsScrolled,
                    ),
                    SliverOverlapAbsorber(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context),
                      sliver: SliverAppBar(
                        toolbarHeight: 0,
                        collapsedHeight: 1,
                        pinned: true,
                        expandedHeight: 1,
                        forceElevated: innerBoxIsScrolled,
                        bottom: TabBar(
                          tabs: _tabs
                              .map((String name) => Tab(text: name))
                              .toList(),
                        ),
                      ),
                    ),
                  ];
                },
                body: ConstrainedBox(
                  constraints: BoxConstraints.expand(),
                  child: _article(),
                ),
              ),
            ),
            onRefresh: () {
              _refreshData();
            }));*/

    return NotificationListener(
        child: RefreshIndicator(
      child: CustomScrollView(
        slivers: [
          HomeHeadSlivers(),
          HomeBannerSlivers(banners:banners,categorys:categorys),
        ],
      ),
      onRefresh: () {
        _refreshData();
      },
    ));
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


  void _refreshData() {
    banners.clear();
    articles.clear();
    _getBanner();
    _getArticle();
    _getCategory();
  }

  _onScrollNotification(ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
      //滑到了底部
      page++;
      _getArticle();
    }
  }

  _article() {
    return ListView.builder(
        itemCount: articles.length,
        itemExtent: 50,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Text(
                articles[index].title == null ? "为空" : articles[index].title),
            onTap: () {
              WebViewPage.toWeb(
                  context, articles[index].link, articles[index].title);
            },
          );
        });
  }

  void _getArticle() {
    Api.getHomeArticle(page).then((value) {
      setState(() {
        articles.addAll(value.data.datas);
      });
    });
  }

  void _getBanner() {
    Api.getHomeBanner().then((value) {
      setState(() {
        banners = value.data;
      });
    });
  }

  void _getCategory() {
    Api.getHomeCategory().then((value){

    });
  }
}
