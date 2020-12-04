import 'package:flutter/material.dart';
import 'package:wan_android_flutter/common/WebViewPage.dart';
import 'package:wan_android_flutter/main/home/HomeBannerSlivers.dart';
import 'package:wan_android_flutter/main/home/HomeCategorySlivers.dart';
import 'package:wan_android_flutter/main/home/HomeHeadSlivers.dart';
import 'package:wan_android_flutter/main/home/TabArticleSlivers.dart';
import 'package:wan_android_flutter/main/model/CommonArticle.dart';
import 'package:wan_android_flutter/network/Api.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  int page = 0;
  int articleType=0;

  List<CommonArticle> articles = [];

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
        child: RefreshIndicator(
          child: CustomScrollView(
            slivers: [
              HomeHeadSlivers(),
              HomeBannerSlivers(),
              HomeCategorySlivers(),
             TabArticleSlivers(onTap: (index){
               articleType=index;
               setState(() {
                 _refreshData();
               });
             },),
              _articleList(),
            ],
          ),
          onRefresh:_refreshData,

        ));
  }


  Future<void> _refreshData() async {
    articles.clear();
    _getArticle();
  }





  void _getArticle() {
    switch(articleType){
      case 0:
        //首页
        Api.getHomeArticle(page).then((value) {
          setState(() {
            articles.addAll(value.data.datas);
          });
        });
        break;

      case 1:
        //广场
        Api.getUserList(page).then((value) {
          setState(() {
            articles.addAll(value.data.datas);
          });
        });
        break;
    }

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

  _articleList() {
    return SliverList(
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
            print("indexCallback:${localIndex}");
            if (localIndex == (articles.length-1)) {
              page++;
              _getArticle();
            }
          }
      ),
    );
  }
}
