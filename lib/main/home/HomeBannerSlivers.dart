import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wan_android_flutter/main/model/BannerModel.dart';
import 'package:wan_android_flutter/main/model/CategoryModel.dart';
import 'package:wan_android_flutter/network/Api.dart';

class HomeBannerSlivers extends StatefulWidget {
  HomeBannerSlivers({Key key});

  @override
  State<StatefulWidget> createState() {
    return _HomeBannersState();
  }
}

class _HomeBannersState extends State<HomeBannerSlivers> {
  List<BannerItem> banners = [];
  List<CategoryItem> categorys = [];

  @override
  void initState() {
    super.initState();
    _getBanner();
    _getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 160,
      flexibleSpace: _banner(),
    );
  }

  void _getBanner() {
    Api.getHomeBanner().then((value) {
      setState(() {
        banners = value.data;
      });
    });
  }

  void _getCategory() {
    Api.getHomeCategory().then((value) {
      setState(() {
        categorys = value.data;
      });
    });
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
