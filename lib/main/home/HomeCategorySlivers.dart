import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wan_android_flutter/main/model/BannerModel.dart';
import 'package:wan_android_flutter/main/model/CategoryModel.dart';
import 'package:wan_android_flutter/network/Api.dart';

class HomeCategorySlivers extends StatefulWidget {
  HomeCategorySlivers({Key key});

  @override
  State<StatefulWidget> createState() {
    return _HomeCategoryState();
  }
}

class _HomeCategoryState extends State<HomeCategorySlivers> {
  List<CategoryItem> categorys = [];

  @override
  void initState() {
    super.initState();
    _getCategory();
  }

  @override
  Widget build(BuildContext context) {
  /*  return SliverAppBar(
      expandedHeight: 160,
      flexibleSpace: _cates(),
    );*/
    return  SliverGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 100.0,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: 1.3,//子控件宽高比
      ),
      delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: Column(
              children: [
                Icon(
                  Icons.ac_unit_rounded,
                  color: Colors.grey[250],
                ),
                Text(
                  categorys[index].name,
                  style: TextStyle(fontSize: 11, color: Colors.grey[250]),
                )
              ],
            ),
          );
        },
        childCount: categorys.length,
      ),
    );
  }


  void _getCategory() {
    Api.getHomeCategory().then((value) {
      setState(() {
        categorys = value.data;
      });
    });
  }


  _cates() {
    List<List<CategoryItem>> _list = [];
    int key = 0;
    List<CategoryItem> tempList = [];
    categorys.forEach((element) {
      if (key == 10) {
        _list.add(tempList);
        tempList = [];
      } else {
        tempList.add(element);
      }
      key++;
    });
    return Container(
      height: 150,
      child: PageView(
        children: _categoryPage(_list),
      ),
    );
  }

  _categoryPage(List<List<CategoryItem>> list) {
    List<Widget> pages = [];
    list.forEach((element) {
      pages.add(_listPage(element));
    });
    return pages;
  }

  Widget _listPage(List<CategoryItem> list) {
    List<Widget> items = [];
    list.forEach((element) {
      items.add(Padding(
        padding: EdgeInsets.only(left: 5, right: 5),
        child: Column(
          children: [
            Icon(
              Icons.ac_unit_rounded,
              color: Colors.grey[250],
            ),
            Text(
              element.name,
              style: TextStyle(fontSize: 11, color: Colors.grey[250]),
            )
          ],
        ),
      ));
    });
    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5, //横轴三个子widget
          childAspectRatio: 1.0 //宽高比为1时，子widget
          ),
      children: items,
    );

  }
}
