import 'package:flutter/material.dart';

class TabArticleSlivers extends StatefulWidget {
  final ValueChanged<int> onTap;

  const TabArticleSlivers({Key key, this.onTap}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TabArticleState();
  }
}

typedef onTabChange = void Function(int type);



class _TabArticleState extends State<TabArticleSlivers>
    with SingleTickerProviderStateMixin {
  TabController _tabController; //需要定义一个Controller
  List tabs = ["首页", "广场"];

  @override
  void initState() {
    super.initState();
    // 创建Controller
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      flexibleSpace: TabBar(

        controller: _tabController,
        tabs: tabs.map((e) => Tab(text: e)).toList(),
        onTap:widget.onTap,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }
}
