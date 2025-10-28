import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flutter/material.dart';
import 'package:flora121_base/flora121_base/flora121_base_con.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';

class Flora121Money1580AnimatorDialogCon extends Flora121BaseCon with GetSingleTickerProviderStateMixin{
  late AnimationController controller;
  late Animation<Offset> leftAnim;
  late Animation<Offset> rightAnim;
  late Function() dismissCallback;

  Flora121Money1580AnimatorDialogCon(this.dismissCallback);

  @override
  void onInit() {
    super.onInit();
    _initAnimator();
  }

  _initAnimator()async{
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    // 左图从屏幕左外到中间
    leftAnim = Tween<Offset>(
      begin: const Offset(-1.2, 0), // 屏幕左边外
      end: const Offset(0, 0),      // 中间
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeOut,
    ));

    // 右图从屏幕右外到中间
    rightAnim = Tween<Offset>(
      begin: const Offset(1.2, 0),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeOut,
    ));

    // 自动开始
    controller.forward();
    await Future.delayed(Duration(milliseconds: 1500));
    Flora121RoutersHep.back();
    dismissCallback.call();
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}