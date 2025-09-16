import 'package:flora121_base/flora121_base/flora121_base_con.dart';
import 'package:flora121_base/flora121_hep/flora121_applife_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_music_hep.dart';
import 'package:flora121_package_b/flora121_activty/flora121_home_activity/flora121_cash_child/flora121_cash_child.dart';
import 'package:flora121_package_b/flora121_activty/flora121_home_activity/flora121_dice_child/flora121_dice_child.dart';
import 'package:flora121_package_b/flora121_activty/flora121_home_activity/flora121_home_child/flora121_home_child.dart';
import 'package:flora121_package_b/flora121_activty/flora121_home_activity/flora121_wheel_child/flora121_wheel_child.dart';
import 'package:flora121_package_b/flora121_hep/flora121_event_code.dart';
import 'package:flutter/material.dart';

class Flora121HomeCon extends Flora121BaseCon{
  var tabIndex=0;
  List<Widget> page=[
    Flora121HomeChild(),
    Flora121DiceChild(),
    Flora121WheelChild(),
    Flora121CashChild(),
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
    update(["page","top_view"]);
  }

  @override
  bool initFlora121Event() => true;

  @override
  receivedFlora121EventMsg(int flora121Code, int? flora121IntValue, String? flora121StringValue, Map? flora121Map) {
    switch(flora121Code){
      case Flora121EventCode.showHomeTab:
        clickBottom(flora121IntValue??0);
        break;
    }
  }
}