
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class ToastUtils{
  static toast(BuildContext context,String content){
    Toast.show(content, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
  }
}