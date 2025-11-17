import 'package:flutter/material.dart';
import 'package:flora121_base/flora121_base/flora121_base_con.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';

class Flora121GoldStep3DialogCon extends Flora121BaseCon with GetSingleTickerProviderStateMixin{
  late AnimationController animationController;
  late Function() clickOkCallback;
  Flora121GoldStep3DialogCon(this.clickOkCallback);

  @override
  void onInit() {
    super.onInit();
    animationController=AnimationController(duration: const Duration(seconds: 3),vsync: this);
    animationController.addListener(() {
      update(["pro_view"]);
      if(animationController.value>=0.95){
        animationController.stop();
        Flora121RoutersHep.back();
        clickOkCallback.call();
      }
    });
    animationController.forward();
  }

  clickClose(Function() clickCloseCallback){
    Flora121RoutersHep.back();
    clickCloseCallback.call();
  }

  clickOk(Function() clickOkCallback){
    Flora121RoutersHep.back();
    clickOkCallback.call();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}