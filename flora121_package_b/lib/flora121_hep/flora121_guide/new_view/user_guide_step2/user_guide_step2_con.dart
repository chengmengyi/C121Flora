import 'package:flutter/material.dart';
import 'package:flora121_base/flora121_base/flora121_base_con.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';

class UserGuideStep2Con extends Flora121BaseCon with GetSingleTickerProviderStateMixin{
  late AnimationController animationController;

  @override
  void onInit() {
    super.onInit();
    animationController=AnimationController(duration: const Duration(milliseconds: 1500),vsync: this,value: 0.5)
      ..addListener(() {
        update(["pro"]);
      })
      ..addStatusListener((status) {

      })..forward();
  }

  clickNext(Function() dismissCallback){
    Flora121RoutersHep.back();
    dismissCallback.call();
  }


  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}