import 'package:flora121_base/flora121_base/flora121_base_con.dart';
import 'dart:math';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_music_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_get_water_dialog/flora121_get_water_dialog.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_no_wheel_dialog/flora121_no_wheel_dialog.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_wheel_get_dialog/flora121_wheel_get_dialog.dart';
import 'package:flora121_package_b/flora121_hep/flora121_storage/flora121_storage.dart';
import 'package:flora121_package_b/flora121_hep/flora121_task_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_user_info_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_value_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_wheel_utils.dart';
import 'package:flutter/material.dart';

class Flora121WheelChildCon extends Flora121BaseCon with GetSingleTickerProviderStateMixin{
  var wheelReward=0,canClick=true;
  List<int> wheelList=[];
  late AnimationController _wheelAnimationController;
  Animation<double>? wheelAnimation;
  late AnimationStatusListener _statusListener;

  @override
  void onInit() {
    super.onInit();
    _initAnimator();
  }

  clickStart(){
    if(!canClick){
      return;
    }
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
    // Flora121RoutersHep.dialog(
    //   child: Flora121GetWaterDialog(
    //     waterNum: 1,
    //     taskType: "",
    //     isHealth: true,
    //     getCallback: (){
    //       Flora121WheelUtils.instance.resetGiftNum();
    //       update(["gift"]);
    //     },
    //   ),
    // );
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
    wheelList.add(100);
    while(wheelList.length<8){
      wheelList.add(_randomWithVariance(wheelReward));
    }

    var indexWhere = wheelList.indexWhere((value)=>value==wheelReward);
    if(indexWhere<0){
      canClick=true;
      return;
    }
    var angle = 720-indexWhere*45;
    wheelAnimation=Tween<double>(begin: 0,end: (720+angle)*(pi/180)).animate(_wheelAnimationController);
  }

  int _randomWithVariance(int base) {
    final random = Random();

    // 计算上下限
    int minVal = (base * 0.8).floor();
    int maxVal = (base * 1.2).ceil();

    // 保证最小值 >= 1
    minVal = max(minVal, 1);

    // 在范围内随机取值
    return minVal + random.nextInt(maxVal - minVal + 1);
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
}