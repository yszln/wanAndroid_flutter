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


}
