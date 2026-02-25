import 'package:flora121_base/flora121_base/flora121_base_con.dart';
import 'package:flora121_base/flora121_hep/flora121_af_utils.dart';
import 'package:flora121_base/flora121_hep/flora121_applife_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_music_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_package_a/flora121_activty/flora121_home_activity/flora121_home_child/flora121_home_child.dart';
import 'package:flora121_package_a/flora121_activty/flora121_home_activity/flora121_me_child/flora121_me_child.dart';
import 'package:flora121_package_a/flora121_activty/flora121_home_activity/flora121_wheel_child/flora121_wheel_child.dart';
import 'package:flutter/material.dart';

class Flora121HomeCon extends Flora121BaseCon{
  var tabIndex=0;
  List<Widget> page=[
    Flora121HomeChild(),
    Flora121WheelChild(),
    Flora121MeChild(),
  ];

  @override
  void onInit() {
    super.onInit();
    Flora121ApplifeHep.instance.init();
    Flora121MusicHep.instance.playBgm();
    Flora121AfUtils.instance.aPackageCheckCallback=(){
      Flora121RoutersHep.offAllNamed(routerName: "/packageB/home");
    };
  }

  clickBottom(int index){
    if(tabIndex==index){
      return;
    }
    tabIndex=index;
    update(["page"]);
  }
  @override
  void onClose() {
    Flora121AfUtils.instance.aPackageCheckCallback=null;
    super.onClose();
  }
}