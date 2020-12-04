import 'package:flutter/material.dart';
import 'package:wan_android_flutter/user/LoginPage.dart';

class MinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MinePageState();
  }
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.only(top: 100),
        child: Text('登陆'),
      ),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return LoginPage();
        }));
      },
    );
  }
}
