import 'dart:async';
import 'dart:math';
import 'package:flora121_base/flora121_base/flora121_base_con.dart';
import 'package:flora121_base/flora121_hep/flora121_event/flora121_event_utils.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_local_info.dart';
import 'package:flora121_base/flora121_hep/flora121_music_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_package_b/flora121_bean/flora121_energy_bean.dart';
import 'package:flora121_package_b/flora121_bean/flora121_sign_bean.dart';
import 'package:flora121_package_b/flora121_bean/flora121_store_bean.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_get_water_dialog/flora121_get_water_dialog.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_old_user_dialog/flora121_old_user_dialog.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_set_dialog/flora121_set_dialog.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_store_detail_dialog/flora121_store_detail_dialog.dart';
import 'package:flora121_package_b/flora121_hep/flora121_energy_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_event_code.dart';
import 'package:flora121_package_b/flora121_hep/flora121_guide/flora121_user_guide_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_sign_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_storage/flora121_storage.dart';
import 'package:flora121_package_b/flora121_hep/flora121_store_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_task_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_user_info_utils.dart';
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
  var canClick=true;

  var flowerHeight=200.h;
  var flowerWidth=100.w;
  final Random random = Random();
  final double boxSize = 66.w;

  @override
  void onInit() {
    super.onInit();
    _startEnergyTimer();
  }

  @override
  void onReady() {
    super.onReady();
    Flora121UserGuideUtils.instance.checkShowNewUserGuide();
    _getEnergyList();
    _getSignList();
    _getStoreList();
  }

  clickEnergy()async{
    Flora121EnergyUtils.instance.updateCollectEnergyNum();
    update(["level","flower"]);
    _checkShowReward();
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
    if(bean.signType==TaskType.water){
      Flora121RoutersHep.dialog(
        child: Flora121GetWaterDialog(
          waterNum: bean.addNum??0,
          taskType: bean.signType??"",
          isHealth: true,
          getCallback: ()async{
            var result = await Flora121SignUtils.instance.sign(bean);
            if(result){
              Flora121TaskUtils.instance.updateTaskBySign(bean);
              update(["level"]);
            }
          },
        ),
      );
    }else{
      var result = await Flora121SignUtils.instance.sign(bean);
      if(result){
        Flora121TaskUtils.instance.updateTaskBySign(bean);
        update(["level"]);
      }
    }
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

  _generatePositions() {
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
    if(bCollectEnergyNum.getData()!=1){
      rewardTipsOffset=null;
      update(["reward_tips"]);
      return;
    }
    var renderBox = rewardGlobalKey.currentContext?.findRenderObject() as RenderBox;
    rewardTipsOffset = renderBox.localToGlobal(Offset.zero);
    update(["reward_tips"]);
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

  String getSignIcon(Flora121SignBean signBean){
    switch(signBean.signType){
      case TaskType.suns: return "sign_sun";
      case TaskType.fertilizer: return "sign_f";
      case TaskType.water: return "sign_water";
      default: return "sign_sun";
    }
  }

  clickStore(Flora121StoreBean bean){
    Flora121RoutersHep.dialog(child: Flora121StoreDetailDialog(bean: bean));
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

  test(){
    if(!kDebugMode){
      return;
    }
  }
}