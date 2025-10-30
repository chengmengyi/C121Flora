import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flutter/material.dart';

class Flora121RoutersHep{
  static toNamed({
    required String routerName,
    Map<String, dynamic>? params,
}){
    Get.toNamed(routerName,arguments: params);
  }

  static offNamed({
    required String routerName,
    Map<String, dynamic>? params,
  }){
    Get.offNamed(routerName,arguments: params);
  }

  static offAllNamed({
    required String routerName,
    Map<String, dynamic>? params,
  }){
    Get.offAllNamed(routerName,arguments: params);
  }

  static dialog({
    required Widget child,
}){
    Get.dialog(
      child,
      barrierColor: Colors.black.withOpacity(0.8),
      barrierDismissible: false,
    );
  }

  static back(){
    Get.back();
  }

  static toHome({required String str}){
    Get.until((route)=>route.settings.name==str);
  }

  static Map<String, dynamic> getParams(){
    try {
      return Get.arguments as Map<String, dynamic>;
    } catch (e) {
      return {};
    }
  }
}