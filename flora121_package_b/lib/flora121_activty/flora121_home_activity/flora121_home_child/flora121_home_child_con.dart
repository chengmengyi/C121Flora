import 'dart:async';
import 'dart:math';
import 'package:flora121_base/flora121_base/flora121_base_con.dart';
import 'package:flora121_base/flora121_dialog/flora121_open_notification_dialog/flora121_open_notification_dialog.dart';
import 'package:flora121_base/flora121_hep/flora121_android_local_notification_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_event/flora121_event_utils.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_fengkong_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_local_info.dart';
import 'package:flora121_base/flora121_hep/flora121_music_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_ad_enum.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_point_enum.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_ttt.dart';
import 'package:flora121_package_b/flora121_bean/flora121_energy_bean.dart';
import 'package:flora121_package_b/flora121_bean/flora121_sign_bean.dart';
import 'package:flora121_package_b/flora121_bean/flora121_store_bean.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_common_get_dialog/flora121_common_get_dialog.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_get_water_dialog/flora121_get_water_dialog.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_has_money_tips_dialog/flora121_has_money_tips_dialog.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_old_user_dialog/flora121_old_user_dialog.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_set_dialog/flora121_set_dialog.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_store_detail_dialog/flora121_store_detail_dialog.dart';
import 'package:flora121_package_b/flora121_hep/flora121_cash_task_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_energy_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_event_code.dart';
import 'package:flora121_package_b/flora121_hep/flora121_guide/flora121_user_guide_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_sign_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_storage/flora121_storage.dart';
import 'package:flora121_package_b/flora121_hep/flora121_store_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_task_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_user_info_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_value_utils.dart';
import 'package:flora121_package_b/flora_enum/flora121_cash_task_type.dart';
import 'package:flora121_package_b/flora_enum/flora121_energy_type.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Flora121HomeChildCon extends Flora121BaseCon{
  GlobalKey treeGlobalKey=GlobalKey();
  GlobalKey rewardGlobalKey=GlobalKey();
  List<Flora121EnergyBean> energyList=[];
  List<Flora121SignBean> signList=[];
  List<Flora121StoreBean> storeList=[];
  Timer? _energyTimer;
  Offset? rewardTipsOffset;
  var canClick=true,showLevelMoneyAnimator=false;

  var flowerHeight=200.h;
  var flowerWidth=100.w;
  final Random random = Random();
  final double boxSize = 66.w;

  @override
  void onInit() {
    super.onInit();
    Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.home_page);
    _startEnergyTimer();
  }

  @override
  void onReady() {
    super.onReady();
    _getEnergyList();
    _getSignList();
    _getStoreList();
    _checkShowReward();
    _checkShowLevelMoneyAnimator();
  }

  clickEnergy(Flora121EnergyType type)async{
    Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.home_bubble_c,params: {"type":type.name});
    Flora121EnergyUtils.instance.updateCollectEnergyNum();
    update(["level","flower"]);
    _checkShowReward();
    _checkShowLevelMoneyAnimator();
  }

  clickSignItem(int index,Flora121SignBean bean)async{
    var indexWhere = signList.indexWhere((value)=>value.signedTimer?.isEmpty==true);
    if(indexWhere!=index){
      return;
    }
    var canSign = await Flora121SignUtils.instance.checkCanSign(bean);
    if(!canSign){
      return;
    }
    Flora121RoutersHep.dialog(
      child: Flora121CommonGetDialog(
        addNum: bean.addNum?.toDouble()??0.0,
        rvAdEnum: Flora121AdEnum.frfcn_signin_rv,
        intAdEnum: Flora121AdEnum.frfcn_signin_int,
        dismissCallback: (received)async{
          if(received){
            var result = await Flora121SignUtils.instance.sign(bean);
            if(result){
              Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.home_signin_c,params: {"days":bean.day});
              Flora121CashTaskUtils.instance.updateCashTaskProgress(Flora121CashTaskType.sign);
              update(["level"]);
            }
          }
        },
      ),
    );
  }

  _getEnergyList()async{
    energyList.clear();
    var list = await Flora121EnergyUtils.instance.getEnergyList();
    energyList.addAll(list);
    for (var value in energyList) {
      value.show=true;
      value.globalKey=GlobalKey();
    }
    _generatePositions();
  }

  _generatePositions() async{
    final screenWidth = MediaQuery.of(context).size.width-70.w;
    double areaHeight = 260.h;

// 花的位置
    final Offset flowerCenter = Offset(screenWidth / 2, areaHeight - 100);

    // 预设5个环绕点（相对于花中心）
    final List<Offset> baseOffsets = [
      const Offset(0, -120), // 上
      const Offset(-90, -60), // 左上
      const Offset(90, -60), // 右上
      const Offset(-70, 40), // 左下
      const Offset(70, 40), // 右下
    ];

    for(var index = 0; index<baseOffsets.length;index++){
      var value = baseOffsets[index];
      final dx = value.dx + (random.nextInt(61) - 30).toDouble();
      final dy = value.dy + (random.nextInt(61) - 30).toDouble();
      var offset = flowerCenter + Offset(dx, dy);
      energyList[index].offset=offset;
      energyList[index].baseOffset=value;
      energyList[index].flowerCenter=flowerCenter;
    }
    update(["flower"]);
    await Future.delayed(Duration(milliseconds: 1000));
    Flora121UserGuideUtils.instance.checkShowNewUserGuide();
  }

  _getSignList()async{
    var list = await Flora121SignUtils.instance.getSignList();
    signList.clear();
    signList.addAll(list);
    update(["level"]);
  }

  _getStoreList(){
    var list = Flora121StoreUtils.instance.getList();
    storeList.clear();
    storeList.addAll(list);
    update(["store"]);
  }

  _checkShowReward(){
    if(Flora121EnergyUtils.instance.getLevelNum()>=5){
      rewardTipsOffset=null;
      update(["reward_tips"]);
      return;
    }
    var renderBox = rewardGlobalKey.currentContext?.findRenderObject() as RenderBox;
    rewardTipsOffset = renderBox.localToGlobal(Offset.zero);
    update(["reward_tips"]);
  }

  _checkShowLevelMoneyAnimator(){
    if(bHasReceivedLevelMoney.getData().contains("${Flora121EnergyUtils.instance.getLevelNum()}")){
      showLevelMoneyAnimator=false;
      update(["level_money"]);
      return;
    }
    if(Flora121EnergyUtils.instance.getLevelNum()==1){
      return;
    }
    var levelQuantity = Flora121ValueUtils.instance.getUpLevelQuantity();
    var isUpLevel = bCollectEnergyNum.getData()%levelQuantity==0;
    showLevelMoneyAnimator=isUpLevel;
    update(["level_money"]);
  }

  clickLevelMoney(){
    Flora121RoutersHep.dialog(
      child: Flora121CommonGetDialog(
        addNum: Flora121ValueUtils.instance.getUpLevelAddNum(),
        rvAdEnum: Flora121AdEnum.frfcn_level_rv,
        intAdEnum: Flora121AdEnum.frfcn_level_int,
        dismissCallback: (received){
          if(received){
            var data = bHasReceivedLevelMoney.getData();
            data+="${Flora121EnergyUtils.instance.getLevelNum()}";
            bHasReceivedLevelMoney.saveData(data);
            showLevelMoneyAnimator=false;
            update(["level_money"]);
          }
        },
      ),
    );
  }

  _startEnergyTimer(){
    _stopEnergyTimer();
    _energyTimer=Timer.periodic(Duration(seconds: 1), (t)async{
      for (var value in energyList) {
        var currentTime = value.currentTime??0;
        if(currentTime>0){
          value.currentTime=currentTime-1;
          await Flora121EnergyUtils.instance.updateEnergy(value);
          update(["flower"]);
        }
      }
    });
  }

  _stopEnergyTimer(){
    _energyTimer?.cancel();
    _energyTimer=null;
  }

  String getFlowerImage(){
    switch(Flora121EnergyUtils.instance.getLevelNum()){
      case 1: return "flower1";
      case 2: return "flower2";
      case 3: return "flower3";
      case 4: return "flower4";
      default: return "flower5";
    }
  }

  clickStore(Flora121StoreBean bean){
    Flora121RoutersHep.dialog(child: Flora121StoreDetailDialog(bean: bean));
  }

  clickMoreFun(){
    toWebActivity("More Fun", Flora121LocalInfo.moreFun);
  }

  @override
  bool initFlora121Event() => true;

  @override
  receivedFlora121EventMsg(int flora121Code, int? flora121IntValue, String? flora121StringValue, Map? flora121Map) {
    switch(flora121Code){
      case Flora121EventCode.repeatAnimatorStop:
        canClick=true;
        break;
    }
  }

  @override
  void onClose() {
    _stopEnergyTimer();
    super.onClose();
  }

  test()async{
    if(!kDebugMode){
      return;
    }
    // Flora121EnergyUtils.instance.updateCollectEnergyNum();
    // Flora121ValueUtils.instance.initValue();

    // Flora121Ttt.instance.uploadSessionEvent();


    Flora121CashTaskUtils.instance.updateCashTaskProgress(Flora121CashTaskType.sign);
    // Flora121FengkongHep.instance.initFengkong();
    // Flora121AndroidLocalNotificationHep.instance.init();
    // Flora121RoutersHep.dialog(
    //   child: Flora121HasMoneyTipsDialog(),
    // );
    // Flora121AndroidLocalNotificationHep.instance.init(false);
    // Flora121UserInfoUtils.instance.updateMyMoney(20);
    // Flora121AndroidLocalNotificationHep.instance.init(true);

    // Flora121UserGuideUtils.instance.test();
  }
}