import 'dart:convert';
import 'dart:math';

import 'package:flora121_base/flora121_hep/flora121_base_router_name.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

extension StColor on String{
  Color toColor(){
    var hexStr = replaceAll("#", "");
    return Color(int.parse(hexStr, radix: 16)).withAlpha(255);
  }
}

extension FloraToast on String{
  showToast(){
    if(isEmpty){
      return;
    }
    Fluttertoast.showToast(
      msg: this,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black45,
      textColor: Colors.white,
      fontSize: 16,
    );
  }
}

extension RandomList on List{
  random()=> this[Random().nextInt(length)];
}

String getTodayTimeStr(){
  var dateTime = DateTime.now();
  return "${dateTime.year}-${dateTime.month}-${dateTime.day}";
}

String formatDuration(int seconds) {
  final minutes = seconds ~/ 60;
  final secs = seconds % 60;
  final minutesStr = minutes.toString().padLeft(2, '0');
  final secondsStr = secs.toString().padLeft(2, '0');
  return "$minutesStr:$secondsStr";
}

extension StringBase64 on String{
  String base64(){
    if(isEmpty){
      return "";
    }
    return const Utf8Decoder().convert(base64Decode(this));
  }
}

toWebActivity(String title,String url){
  Flora121RoutersHep.toNamed(routerName: Flora121BaseRouterName.web,params: {"title":title,"url":url});
}

//加密：“data”：原始字符串；“code”：需求文档标题前的项目编号
String encrypt(String data, int code) {
  final dataBytes = utf8.encode(data);
  List<int> xorList = [];
  for (int i = 0; i < dataBytes.length; i++) {
    xorList.add(dataBytes[i] ^ code);
  }
  return base64.encode(xorList);
}

//解密：“data”：加密字符串；“code”：需求文档标题前的项目编号
String decrypt(String data, int code) {
  final decode = base64.decode(data);
  final decode2 = decode.toList();
  List<int> xorList = [];
  for (int i = 0; i < decode2.length; i++) {
    xorList.add(decode2[i] ^ code);
  }
  return utf8.decode(xorList);
}


extension Strint2Double on String{
  double toDouble(){
    try{
      return double.parse(this);
    }catch(e){
      return 0.0;
    }
  }
}