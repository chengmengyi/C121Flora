import 'package:flora121_base/flora121_base/flora121_base_con.dart';
import 'package:flora121_base/flora121_hep/flora121_ad_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_af_utils.dart';
import 'package:flora121_base/flora121_hep/flora121_android_local_notification_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_local_info.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_ad_enum.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_point_enum.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_ttt.dart';
import 'package:flora121_package_b/flora121_hep/flora121_routers.dart';
import 'package:flora121_package_b/flora121_hep/flora121_storage/flora121_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

StorageData<bool> launchShowLoading=StorageData<bool>(key: "launchShowLoading", defaultValue: false);

class Flora121LaunchCon extends Flora121BaseCon with GetSingleTickerProviderStateMixin{
  var selected=true;
  late AnimationController animationController;

  @override
  void onInit() {
    super.onInit();
    Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.launch_page);
    _initAnimator();
  }

  @override
  void onReady() {
    super.onReady();
    Flora121AndroidLocalNotificationHep.instance.initNotification();
    if(launchShowLoading.getData()){
      animationController.forward();
    }
  }

  clickSelect(){
    selected=!selected;
    update(["selected"]);
  }

  clickStart(){
    selected=true;
    update(["selected"]);
    Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.launch_start);
    _checkShowAd();
  }

  _checkShowAd(){
    Flora121AfUtils.instance.check();
    if(bShowOpenAd.getData()){
      Flora121AdHep.instance.showFlora121BBBBBBB(
        adType: AdType.interstitial,
        showAd: true,
        adEnum: Flora121AdEnum.frfcn_launch,
        isOpen: true,
        closeAd: (giveReward){
          toHome();
        },
      );
    }else{
      toHome();
    }
  }

  toHome(){
    bShowOpenAd.saveData(true);
    launchShowLoading.saveData(true);
    Flora121RoutersHep.offAllNamed(routerName: Flora121RouterNameB.home);
  }

  _initAnimator(){
    animationController=AnimationController(duration: const Duration(seconds: 10),vsync: this);
    animationController.addListener(() {
      update(["pro_view"]);
    });
    animationController.addStatusListener((status) {
        if(status==AnimationStatus.completed){
          _checkShowAd();
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