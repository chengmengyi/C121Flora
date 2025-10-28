import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flutter/material.dart';
import 'package:flora121_base/flora121_base/flora121_base_con.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';

class UserGuideStep3Con extends Flora121BaseCon with GetSingleTickerProviderStateMixin{
  late AnimationController animationController;
  Function() dismissCallback;
  UserGuideStep3Con(this.dismissCallback);

  @override
  void onInit() {
    super.onInit();
    animationController=AnimationController(duration: const Duration(milliseconds: 4000),vsync: this)
      ..addListener(() {
        update(["pro"]);
      })
      ..addStatusListener((status) {
        if(status==AnimationStatus.completed){
          _animatorEnd();
        }
      })..forward();
  }

  _animatorEnd()async{
    await Future.delayed(Duration(milliseconds: 1000));
    Flora121RoutersHep.back();
    dismissCallback.call();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}