import 'package:flutter/material.dart';
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
    return SliverAppBar(
      expandedHeight: 90,
      snap: true,
      floating: true,
      pinned: false,
      flexibleSpace: Container(
        child: _cates(),
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
    return Padding(
      padding: EdgeInsets.only(left: 5,right: 5,top: 10),
      child: GridView.builder(
          scrollDirection: Axis.horizontal,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 20.0, childAspectRatio: 1),
          itemCount: categorys.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                Icon(
                  Icons.ac_unit_rounded,
                  color: Colors.grey[250],
                ),
                Text(
                  categorys[index].name,
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 9, color: Colors.grey[250]),
                )
              ],
            );
          }),
    );
  }
}
