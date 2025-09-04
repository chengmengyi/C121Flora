import 'package:flora121_base/flora121_base/flora121_base_con.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_local_info.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_package_a/flora121_hep/flora121_routers.dart';
import 'package:flutter/material.dart';

StorageData<bool> launchShowLoading=StorageData<bool>(key: "launchShowLoading", defaultValue: false);

class Flora121LaunchCon extends Flora121BaseCon with GetSingleTickerProviderStateMixin{
  var selected=false;
  late AnimationController animationController;

  @override
  void onInit() {
    super.onInit();
    _initAnimator();
  }

  @override
  void onReady() {
    super.onReady();
    if(launchShowLoading.getData()){
      animationController.forward();
    }
  }

  clickSelect(){
    selected=!selected;
    update(["selected"]);
  }

  clickStart(){
    if(!selected){
      "Please read and check the privacy agreement".showToast();
      return;
    }
    toHome();
  }

  toHome(){
    launchShowLoading.saveData(true);
    Flora121RoutersHep.offAllNamed(routerName: Flora121RouterNameA.home);
  }

  _initAnimator(){
    animationController=AnimationController(duration: const Duration(seconds: 10),vsync: this);
    animationController.addListener(() {
      update(["pro_view"]);
    });
    animationController.addStatusListener((status) {
        if(status==AnimationStatus.completed){
          toHome();
        }
    });
  }

  clickPrivacy(){
    toWebActivity("Privacy Policy", Flora121LocalInfo.privacy);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}