import 'package:flora121_base/flora121_base/flora121_base_con.dart';
import 'package:flora121_base/flora121_hep/flora121_applife_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_music_hep.dart';
import 'package:flora121_package_b/flora121_activty/flora121_home_activity/flora121_home_child/flora121_home_child.dart';
import 'package:flora121_package_b/flora121_activty/flora121_home_activity/flora121_me_child/flora121_me_child.dart';
import 'package:flora121_package_b/flora121_activty/flora121_home_activity/flora121_wheel_child/flora121_wheel_child.dart';
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
    Flora121MusicHep.instance.init();
    Flora121ApplifeHep.instance.init();
  }

  clickBottom(int index){
    if(tabIndex==index){
      return;
    }
    tabIndex=index;
    update(["page"]);
  }
}