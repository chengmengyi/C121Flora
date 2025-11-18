import 'package:flora121_base/flora121_base/flora121_base_con.dart';
import 'dart:math';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_local_info.dart';
import 'package:flora121_base/flora121_hep/flora121_music_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_ad_enum.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_point_enum.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_ttt.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_common_get_dialog/flora121_common_get_dialog.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_get_water_dialog/flora121_get_water_dialog.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_no_wheel_dialog/flora121_no_wheel_dialog.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_wheel_get_dialog/flora121_wheel_get_dialog.dart';
import 'package:flora121_package_b/flora121_hep/flora121_cash_task_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_event_code.dart';
import 'package:flora121_package_b/flora121_hep/flora121_storage/flora121_storage.dart';
import 'package:flora121_package_b/flora121_hep/flora121_task_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_user_info_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_value_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_wheel_utils.dart';
import 'package:flora121_package_b/flora_enum/flora121_cash_task_type.dart';
import 'package:flutter/material.dart';

class Flora121WheelChildCon extends Flora121BaseCon with GetSingleTickerProviderStateMixin{
  var wheelReward=0.0,canClick=true;
  List<double> wheelList=[];
  late AnimationController _wheelAnimationController;
  Animation<double>? wheelAnimation;
  late AnimationStatusListener _statusListener;
  late WebViewController controller;

  @override
  void onInit() {
    super.onInit();
    _initAnimator();
    controller=WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(Flora121LocalInfo.moreFun));
  }

  clickStart(){
    if(!canClick){
      return;
    }
    Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.wheel_c);
    if(Flora121WheelUtils.instance.wheelNum<=0){
      Flora121RoutersHep.dialog(child: Flora121NoWheelDialog());
      return;
    }
    canClick=false;
    _initAnimation();
    Flora121MusicHep.instance.playOtherAudio(AudioName.wheel);
    _wheelAnimationController..reset()..forward();
  }

  clickBox(){
    if(bWheelGiftNum.getData()<5){
      return;
    }
    Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.wheel_page_gift);
    Flora121RoutersHep.dialog(
      child: Flora121CommonGetDialog(
        addNum: Flora121ValueUtils.instance.getWaterAddNum(),
        rvAdEnum: Flora121AdEnum.frfcn_gift_rv,
        intAdEnum: Flora121AdEnum.frfcn_gift_int,
        dismissCallback: (r){
          Flora121WheelUtils.instance.resetGiftNum();
          update(["gift"]);
        },
      ),
    );
  }

  int _getWeightedRandom() {
    final rand = Random().nextDouble(); // 0.0 ~ 1.0
    if (rand < 0.5) {
      return 0; // 50%
    } else if (rand < 0.5 + 0.4) {
      return 1; // 40%
    } else {
      return 2; // 10%
    }
  }

  _initAnimator(){
    _wheelAnimationController=AnimationController(vsync: this,duration: const Duration(milliseconds: 2000));
    _statusListener=(status){
      if(status==AnimationStatus.completed){
        _wheelAnimatorFinish();
      }
    };
    _wheelAnimationController.addStatusListener(_statusListener);
    _initAnimation();
  }

  _wheelAnimatorFinish()async{
    await Future.delayed(Duration(milliseconds: 1000));
    Flora121CashTaskUtils.instance.updateCashTaskProgress(Flora121CashTaskType.wheel);
    Flora121WheelUtils.instance.updateWheelNum(-1);
    Flora121WheelUtils.instance.updateWheelGiftNum();
    update(["wheel_num","gift"]);
    canClick=true;
    if(wheelReward>0){
      Flora121RoutersHep.dialog(
        child: Flora121WheelGetDialog(
          addNum: wheelReward.toDouble(),
          dismissCallback: (received){

          },
        ),
      );
    }
  }

  _initAnimation(){
    wheelList.clear();
    wheelReward=Flora121ValueUtils.instance.getWheelAddNum();
    wheelList.add(wheelReward);
    wheelList.add(100.0);
    while(wheelList.length<8){
      wheelList.add(_randomWithVariance(wheelReward));
    }
    wheelList.shuffle();

    var indexWhere = wheelList.indexWhere((value)=>value==wheelReward);
    if(indexWhere<0){
      canClick=true;
      return;
    }
    var angle = 720-indexWhere*45;
    wheelAnimation=Tween<double>(begin: 0,end: (720+angle)*(pi/180)).animate(_wheelAnimationController);
  }

  double _randomWithVariance(double value) {
    if (value == 0) return value;

    final random = Random();
    final factor = (random.nextDouble() * 0.4) - 0.2;
    final result = value * (1 + factor);
    final fixed = double.parse(result.toStringAsFixed(2));
    return fixed <= 0 ? value : fixed;
  }

  String getToday(){
    var dateTime = DateTime.now();
    return "${dateTime.month}.${dateTime.day}";
  }

  @override
  void onClose() {
    _wheelAnimationController.removeStatusListener(_statusListener);
    _wheelAnimationController.dispose();
    super.onClose();
  }

  @override
  bool initFlora121Event() => true;

  @override
  receivedFlora121EventMsg(int flora121Code, int? flora121IntValue, String? flora121StringValue, Map? flora121Map) {
    switch(flora121Code){
      case Flora121EventCode.updateWheelNum:
        update(["wheel_num"]);
        break;
      case Flora121EventCode.changeToGoldMode:
        update(["wheel"]);
        break;
      case Flora121EventCode.autoPlayWheel:
        clickStart();
        break;
    }
  }
}