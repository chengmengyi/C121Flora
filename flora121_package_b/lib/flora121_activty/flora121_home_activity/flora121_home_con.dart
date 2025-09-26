import 'package:flora121_base/flora121_base.dart';
import 'package:flora121_base/flora121_base/flora121_base_con.dart';
import 'package:flora121_base/flora121_hep/flora121_android_local_notification_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_applife_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_fengkong_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_music_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_network_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_point_enum.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_ttt.dart';
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
    Flora121FengkongHep.instance.initFengkong();
    Flora121Base.instance.flora();
    Flora121NetworkHep.instance.init();
  }

  clickBottom(int index){
    if(tabIndex==index){
      return;
    }
    tabIndex=index;
    switch(index){
      case 0:

        break;
      case 1:
        Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.dice_page);
        Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.dice_page_c);
        break;
      case 2:
        Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.wheel_page);
        Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.wheel_page_c);
        break;
      case 3:
        Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.cash_page);
        break;
    }
    update(["page","top_view"]);
  }

  @override
  bool initFlora121Event() => true;

  @override
  receivedFlora121EventMsg(int flora121Code, int? flora121IntValue, String? flora121StringValue, Map? flora121Map) {
    switch(flora121Code){
      case Flora121EventCode.showHomeTab:
        _updateHomeTab(flora121IntValue??0);
        break;
    }
  }

  _updateHomeTab(int index){
    if(tabIndex==index){
      return;
    }
    tabIndex=index;
    switch(index){
      case 0:

        break;
      case 1:
        Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.dice_page_c);
        break;
      case 2:
        Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.wheel_page);
        break;
      case 3:
        Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.cash_page);
        break;
    }
    update(["page","top_view"]);
  }
}