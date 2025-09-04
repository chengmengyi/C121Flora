import 'package:flora121_base/flora121_base/flora121_base_con.dart';
import 'dart:math';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_music_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_package_a/flora121_dialog/flora121_get_water_dialog/flora121_get_water_dialog.dart';
import 'package:flora121_package_a/flora121_dialog/flora121_no_wheel_dialog/flora121_no_wheel_dialog.dart';
import 'package:flora121_package_a/flora121_hep/flora121_wheel_utils.dart';
import 'package:flutter/material.dart';

class Flora121WheelChildCon extends Flora121BaseCon with GetSingleTickerProviderStateMixin{
  var wheelWaterReward=0,canClick=true;
  late AnimationController _wheelAnimationController;
  Animation<double>? wheelAnimation;
  late AnimationStatusListener _statusListener;
  List<int> rewardList=[0,0,0,2,1,1,1,1];

  @override
  void onInit() {
    super.onInit();
    rewardList.shuffle();
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
    Flora121RoutersHep.dialog(
      child: Flora121GetWaterDialog(
        waterNum: 1,
        getCallback: (){
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
    Flora121WheelUtils.instance.updateWheelNum(-1);
    Flora121WheelUtils.instance.updateWheelGiftNum();
    update(["wheel_num","gift"]);
    canClick=true;
    if(wheelWaterReward>0){
      Flora121RoutersHep.dialog(child: Flora121GetWaterDialog(waterNum: wheelWaterReward,getCallback: (){},));
    }
  }

  _initAnimation(){
    wheelWaterReward = _getWeightedRandom();
    var indexWhere = rewardList.indexWhere((value)=>value==wheelWaterReward);
    if(indexWhere<0){
      canClick=true;
      return;
    }
    var angle = 720-indexWhere*45;
    wheelAnimation=Tween<double>(begin: 0,end: (720+angle)*(pi/180)).animate(_wheelAnimationController);
  }

  @override
  void onClose() {
    _wheelAnimationController.removeStatusListener(_statusListener);
    _wheelAnimationController.dispose();
    super.onClose();
  }
}