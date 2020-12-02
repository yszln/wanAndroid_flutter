import 'package:flutter/material.dart';
import 'package:wan_android_flutter/common/WebViewPage.dart';
import 'package:wan_android_flutter/main/home/HomeBannerSlivers.dart';
import 'package:wan_android_flutter/main/home/HomeCategorySlivers.dart';
import 'package:wan_android_flutter/main/home/HomeHeadSlivers.dart';
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

  List<CommonArticle> articles = [];

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> _tabs = ['Tab 1', 'Tab 2'];
    return NotificationListener(
        child: RefreshIndicator(
          child: CustomScrollView(
            slivers: [
              HomeHeadSlivers(),
              HomeBannerSlivers(),
              HomeCategorySlivers(),
              SliverList(
                delegate: SliverChildListDelegate(
                  //返回组件集合
                    List.generate(articles.length, (int index) {
                      //返回 组件
                      return GestureDetector(
                        onTap: () {
                          print("点击$index");
                        },
                        child: Card(
                          child: _articleItem(index),
                        ),
                      );
                    }),
                    semanticIndexCallback: (Widget widget, int localIndex) {
                      if (localIndex == articles.length) {
                        page++;
                        _getArticle();
                      }
                    }
                ),
              ),
            ],
          ),
          onRefresh: () {
            _refreshData();
          },

        ));
  }


  void _refreshData() {
    articles.clear();
    _getArticle();
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
          return _articleItem(index);
        });
  }

  void _getArticle() {
    Api.getHomeArticle(page).then((value) {
      setState(() {
        articles.addAll(value.data.datas);
      });
    });
  }

  _articleItem(int index) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.all(10), child: Text(articles[index].title == null
          ? "为空"
          : articles[index].title),),
      onTap: () {
        WebViewPage.toWeb(
            context, articles[index].link, articles[index].title);
      },
    );
  }
}
