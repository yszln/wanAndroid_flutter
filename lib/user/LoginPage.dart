import 'package:flutter/material.dart';
import 'package:wan_android_flutter/network/Api.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {

  String username;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('登陆'),
      ),
      body: Center(
       child: Container(
         height: 300,
         margin: EdgeInsets.only(left: 20,right: 30),
         child: Column(
           children: [
             Row(
               children: [
                 Text('账号：'),
                 Expanded(
                   child: TextField(
                     textInputAction: TextInputAction.next,
                     onChanged: (text){username=text;},
                     decoration: InputDecoration(hintText: '账号'),
                   ),
                 )
               ],
             ),
             Row(
               children: [
                 Text('密码：'),
                 Expanded(
                   child: TextField(
                     textInputAction: TextInputAction.next,
                     onChanged: (text){password=text;},
                     decoration: InputDecoration(hintText: '密码'),
                   ),
                 )
               ],
             ),
             GestureDetector(child: Container(
               width: 200,
               margin: EdgeInsets.only(top: 30),
               padding: EdgeInsets.only(left: 30,right: 30,top: 10,bottom: 10),
               decoration: BoxDecoration(
                   borderRadius: BorderRadius.all(Radius.circular(8)),
                   color: Colors.grey[200]
               ),
               child: Center(child: Text('登陆'),),
             ),onTap: (){
               Api.login(username, password);
             },)
           ],
         ),
       ),
      ),
    );
  }
}
