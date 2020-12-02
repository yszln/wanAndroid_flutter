import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wan_android_flutter/main/model/BannerModel.dart';
import 'package:wan_android_flutter/main/model/CategoryModel.dart';

class HomeBannerSlivers extends StatefulWidget {
  List<BannerItem> banners;
  List<CategoryItem> categorys;

  HomeBannerSlivers({Key key, this.banners, this.categorys});

  @override
  State<StatefulWidget> createState() {
    return _HomeBannersState();
  }
}

class _HomeBannersState extends State<HomeBannerSlivers> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 182,
      flexibleSpace: Column(
        children: [
          _banner(),
          _cates(),
        ],
      ),
    );
  }

  _banner() {
    return Container(
      height: 200,
      margin: EdgeInsets.only(top: 6),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return new Image.network(
            widget.banners[index].imagePath,
            fit: BoxFit.fill,
          );
        },
        itemCount: widget.banners.length,
        pagination: new SwiperPagination(),
        // control: new SwiperControl(),
      ),
    );
  }

  _cates() {
    List<List<CategoryItem>> _list = [];
    int key = 0;
    List<CategoryItem> tempList = [];
    widget.categorys.forEach((element) {
      if (key == 9) {
        _list.add(tempList);
        tempList = [];
      } else {
        tempList.add(element);
      }
      key++;
    });
    return PageView(
      children: _categoryPage(_list),
    );
  }

  _categoryPage(List<List<CategoryItem>> list) {
    List<ListView> pages = [];
    list.forEach((element) {
      pages.add(_listPage(element));
    });
  }

  ListView _listPage(List<CategoryItem> list) {
    List<Widget> items = [];
    list.forEach((element) {
      items.add(Center(
        child: Column(
          children: [Icon(Icons.category), Text(element.name)],
        ),
      ));
    });
    return ListView(
      children: items,
    );
  }
}
