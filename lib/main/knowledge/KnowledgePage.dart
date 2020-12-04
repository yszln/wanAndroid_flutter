import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wan_android_flutter/common/WebViewPage.dart';
import 'package:wan_android_flutter/main/model/CategoryModel.dart';
import 'package:wan_android_flutter/main/model/CommonArticle.dart';
import 'package:wan_android_flutter/network/Api.dart';

class KnowledgePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _KnowledgePageState();
  }
}

class _KnowledgePageState extends State<KnowledgePage> {
  List<CommonArticle> articles = [];
  int page = 0;
  int cid = 60;
  List<CategoryItem> categories;
  bool isShow = true;

  @override
  void initState() {
    super.initState();
    _initScroll();
    _refreshData();
  }

  Future<void> _getArticle() {
    return Api.getKnowledgeArticle(page, cid).then((value) {
      setState(() {
        page++;
        articles.addAll(value.data.datas);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('知识体系'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: _content(),
      ),
    );
  }


  var scrollController = ScrollController();

  _content() {
     if (isShow&&null!=categories) {
      return Stack(children: [_article(), _categorys()],);
    } else {
      return _article();
    }
  }

  _categorys() {
    return Expanded(child: Row(
      children: [
        ListView(children: _categories(),),
        ListView(children: _categories(),)
      ],
    ));
  }

  _categories() {
    List<Widget> items = [];
    categories.forEach((element) {
      items.add(Text(element.name));
    });

    return items;
  }

  _article() {
    return ListView.builder(
        controller: scrollController,
        itemCount: articles.length,
        itemBuilder: (BuildContext context, int index) {
          return _articleItem(index);
        });
  }

  _articleItem(int index) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.all(10),
        child:
        Text(articles[index].title == null ? "为空" : articles[index].title),
      ),
      onTap: () {
        WebViewPage.toWeb(context, articles[index].link, articles[index].title);
      },
    );
  }

  Future<void> _refreshData() async {
    page = 0;
    articles.clear();
    _getArticle();
    _getCategory();
  }

  void _initScroll() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        //滑到了底部
        page++;
        _getArticle();
      }
    });
  }

  void _getCategory() {
    Api.getKnowledgeCategory().then((value) {
      categories.clear();
      setState(() {
        categories.addAll(value.data);
      });
    });
  }


}
