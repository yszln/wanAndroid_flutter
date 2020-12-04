
import 'package:flutter/material.dart';
import 'package:wan_android_flutter/main/found/FoundPage.dart';
import 'package:wan_android_flutter/main/home/HomedPage.dart';
import 'package:wan_android_flutter/main/knowledge/KnowledgePage.dart';
import 'package:wan_android_flutter/main/mine/MinePage.dart';

///选中的页面
int _currentIndex = 0;
///pageView的控制器
var mPageViewController = PageController();

class MainPage extends StatefulWidget {

  List<Widget> pages = [HomePage(),KnowledgePage(),FoundPage(),MinePage()];

  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage>  with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        ///设置状态栏边距
        // padding:EdgeInsets.only(top: MediaQueryData.fromWindow(window).padding.top),
        ///可滑动切换的页面
        child:widget.pages[_currentIndex],
      ),
      ///底部菜单
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomNavItems(),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        ///固定显示文字
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          _onNavTab(index);
        },
      ),
    );
  }

  ///底部菜单的切换
  void _onNavTab(int index) {
    setState(() {
      _currentIndex = index;
      // mPageViewController.jumpToPage(index);
    });
  }

  ///页面的切换
  void _onPageChange(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  /// 底部菜单
  _bottomNavItems() {
    List<BottomNavigationBarItem> navs = [];
    navs.add(BottomNavigationBarItem(
      label: '首页',
      icon: Icon(Icons.home),
    ));
    navs.add(BottomNavigationBarItem(
      label: '知识体系',
      icon: Icon(Icons.menu_book),
    ));
    navs.add(BottomNavigationBarItem(
      label: '发现',
      icon: Icon(Icons.ac_unit_sharp),
    ));
    navs.add(BottomNavigationBarItem(
      label: '我的',
      icon: Icon(Icons.person),
    ));
    return navs;
  }

  ///可切换的页面
  _navigatorPages() {

  }

  @override
  void dispose() {
    super.dispose();
    ///销毁控制器
    mPageViewController.dispose();
  }

  @override
  bool get wantKeepAlive => true;

}
