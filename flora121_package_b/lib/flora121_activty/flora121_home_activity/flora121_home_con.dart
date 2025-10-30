import 'package:flora121_base/flora121_base.dart';
import 'package:flora121_base/flora121_base/flora121_base_con.dart';
import 'package:flora121_base/flora121_hep/flora121_android_local_notification_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_applife_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_event/flora121_event_utils.dart';
import 'package:flora121_base/flora121_hep/flora121_fengkong_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_music_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_network_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_point_enum.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_ttt.dart';
import 'package:flora121_package_b/flora121_activty/flora121_home_activity/flora121_cash_child/flora121_cash_child.dart';
import 'package:flora121_package_b/flora121_activty/flora121_home_activity/flora121_dice_child/flora121_dice_child.dart';
import 'package:flora121_package_b/flora121_activty/flora121_home_activity/flora121_home_child/flora121_home_child.dart';
import 'package:flora121_package_b/flora121_activty/flora121_home_activity/flora121_wheel_child/flora121_wheel_child.dart';
import 'package:flora121_package_b/flora121_bean/flora121_home_tab_bean.dart';
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
  List<Flora121HomeTabBean> tabList=[
    Flora121HomeTabBean(selIcon: "tab_home", unsIcon: "tab_home_uns"),
    Flora121HomeTabBean(selIcon: "tab_dice", unsIcon: "tab_dice_uns"),
    Flora121HomeTabBean(selIcon: "tab_wheel", unsIcon: "tab_wheel_uns"),
    Flora121HomeTabBean(selIcon: "tab_cash", unsIcon: "tab_cash_uns"),
  ];

  @override
  void onInit() {
    super.onInit();
    Flora121ApplifeHep.instance.init();
    Flora121FengkongHep.instance.initFengkong();
    Flora121Base.instance.flora();
    Flora121NetworkHep.instance.init();
    Flora121MusicHep.instance.playBgm();
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
        Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.showBanner,flora121Map: {"title":"Super high winning rate","content":"This will complete your first payout!"});
        break;
      case 2:
        Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.wheel_page);
        Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.wheel_page_c);
        Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.showBanner,flora121Map: {"title":"Easy cash today","content":"200 more people just cashed out."});
        break;
      case 3:
        Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.cash_page);
        Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.cashPageShowNextCaskTaskDialog);
        break;
    }
    update(["page","top_view","bottom_tab"]);
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
        Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.showBanner,flora121Map: {"title":"Super high winning rate","content":"This will complete your first payout!"});
        break;
      case 2:
        Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.wheel_page);
        Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.showBanner,flora121Map: {"title":"Easy cash today","content":"200 more people just cashed out."});
        break;
      case 3:
        Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.cash_page);
        Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.cashPageShowNextCaskTaskDialog);
        break;
    }
    update(["page","top_view","bottom_tab"]);
  }
}