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
  String base64()=>const Utf8Decoder().convert(base64Decode(this));
}

toWebActivity(String title,String url){
  Flora121RoutersHep.toNamed(routerName: Flora121BaseRouterName.web,params: {"title":title,"url":url});
}