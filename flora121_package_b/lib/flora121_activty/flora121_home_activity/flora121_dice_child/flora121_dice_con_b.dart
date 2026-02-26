import 'dart:async';
import 'dart:math';
import 'package:flora121_base/flora121_base/flora121_base_con.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_music_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_ad_enum.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_point_enum.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_ttt.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_common_get_dialog/flora121_common_get_dialog.dart';
import 'package:flora121_package_b/flora121_hep/flora121_cash_task_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_event_code.dart';
import 'package:flora121_package_b/flora121_hep/flora121_guide/flora121_user_guide_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_storage/flora121_storage.dart';
import 'package:flora121_package_b/flora121_hep/flora121_value_utils.dart';
import 'package:flora121_package_b/flora_enum/flora121_cash_task_type.dart';
import 'package:flutter/material.dart';

class Flora121DiceConB extends Flora121BaseCon with GetTickerProviderStateMixin{
  late AnimationController _moveUpController;   // 上移动画
  late AnimationController _rotateController;   // 旋转动画
  late AnimationController _moveDownController; // 下移动画
  late Animation<double> _moveUpAnim;
  late Animation<double> _rotateAnim;
  late Animation<double> _moveDownAnim;

  Timer? _timer;
  int currentDiceIndex = 1,currentDiceLargeIndex=0,currentDiceSmallIndex=0;
  bool _isAnimating = false;
  final List<String> diceImages = ["dice1","dice2","dice3","dice4","dice5","dice6",];
  final List<int> _diceStepList=[3,4,2,1,4,2,3,1];
  ScrollController scrollController=ScrollController();

  GlobalKey diceGlobalKey = GlobalKey();
  Map<String,double> otherAddNumMap={};

  @override
  void onInit() {
    super.onInit();
    currentDiceLargeIndex=bDiceLargeIndex.getData();
    currentDiceSmallIndex=bDiceSmallIndex.getData();
    _initAnimator();
  }

  @override
  void onReady() {
    super.onReady();
    _scrollList();
  }

  clickStart({bool fromNewUserGuide=false}){
    if (_isAnimating) return;
    Flora121MusicHep.instance.playOtherAudio(AudioName.dice);
    Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.dice_c);
    _isAnimating = true;

    // 重置所有 controller
    _moveUpController.reset();
    _rotateController.reset();
    _moveDownController.reset();

    // 动画流程
    _moveUpController.forward().whenComplete(() {
      _startRolling(fromNewUserGuide);
    });
  }

  _startRolling(bool fromNewUserGuide) {
    // 定时切换点数
    _timer = Timer.periodic(const Duration(milliseconds: 80), (timer) {
      currentDiceIndex = Random().nextInt(6)+1;
      update(["dice_result"]);
    });

    _rotateController.forward().whenComplete(() async {
      // 停止随机，固定结果
      _timer?.cancel();
      currentDiceIndex = _getDiceStep();
      update(["dice_result"]);
      // 停留 2 秒
      await Future.delayed(const Duration(seconds: 1));
      // 下移动画
      _moveDownController.forward().whenComplete(() {
        //开始调步数
        _startJumpDice(fromNewUserGuide);
      });
    });
  }

  _startJumpDice(bool fromNewUserGuide)async{
    if(currentDiceSmallIndex>=19){
      currentDiceSmallIndex=0;
      currentDiceLargeIndex+=1;
      bDiceLargeIndex.saveData(currentDiceLargeIndex);
      bDiceSmallIndex.saveData(currentDiceSmallIndex);
    }
    if(currentDiceSmallIndex==0){
      currentDiceSmallIndex=-1;
    }
    for(var index=0;index<currentDiceIndex;index++){
      await Future.delayed(Duration(milliseconds: 300));
      currentDiceSmallIndex++;
      update(["list"]);
    }
    _scrollList();
    await Future.delayed(Duration(milliseconds: 1000));
    _isAnimating = false;
    bDiceStepIndex.saveData(bDiceStepIndex.getData()+1);
    bDiceLargeIndex.saveData(currentDiceLargeIndex);
    bDiceSmallIndex.saveData(currentDiceSmallIndex);
    Flora121CashTaskUtils.instance.updateCashTaskProgress(Flora121CashTaskType.dice);
    var addNum=0.0;
    var goldMode = bGoldMode.getData();
    if(goldMode.isNotEmpty){
      addNum=goldMode==Flora121GoldMode.gold?await Flora121ValueUtils.instance.getGoldAddReward():await Flora121ValueUtils.instance.getDiamondAddReward();
    }else{
      addNum= Flora121ValueUtils.instance.getDiceAddNum();
    }
    Flora121RoutersHep.dialog(
      child: Flora121CommonGetDialog(
        addNum: addNum,
        rvAdEnum: Flora121AdEnum.frfcn_dice_rv,
        intAdEnum: Flora121AdEnum.frfcn_dice_int,
        fromNewUser: fromNewUserGuide,
        fromDice: true,
        dismissCallback: (received){
          // if(fromNewUserGuide){
          //   Flora121UserGuideUtils.instance.showStep9Guide(context);
          // }
        },
      ),
    );
  }

  int _getDiceStep(){
    var data = bDiceStepIndex.getData();
    if(data>=_diceStepList.length){
      data=0;
      bDiceStepIndex.saveData(data);
    }
    return _diceStepList[data];
  }

  _scrollList(){
    var height=0;
    if(currentDiceSmallIndex>=19){
      height=7;
    }else if(currentDiceSmallIndex>=14){
      height=5;
    }else if(currentDiceSmallIndex>=9){
      height=3;
    }else if(currentDiceSmallIndex>=4){
      height=1;
    }
    var distance = height*(84.w)+currentDiceLargeIndex*672.w;
    scrollController.animateTo(
      distance,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  _initAnimator(){
    // 上移动画
    _moveUpController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _moveUpAnim = Tween<double>(begin: 0, end: -(150.h)).animate(
      CurvedAnimation(parent: _moveUpController, curve: Curves.easeOut),
    );

    // 匀速旋转
    _rotateController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _rotateAnim = Tween<double>(begin: 0, end: 10 * pi).animate(
      CurvedAnimation(parent: _rotateController, curve: Curves.linear),
    );

    // 下移动画
    _moveDownController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _moveDownAnim = Tween<double>(begin: -(150.h), end: 0).animate(
      CurvedAnimation(parent: _moveDownController, curve: Curves.easeIn),
    );
  }

  String getDiceIcon()=>diceImages[currentDiceIndex-1];

  Listenable getAnimationListenable()=>Listenable.merge([
    _moveUpController,
    _rotateController,
    _moveDownController
  ]);

  double getOffsetY(){
    // 根据动画阶段决定偏移
    double offsetY = 0;
    if (_moveUpController.isAnimating || _moveUpController.isCompleted) {
      offsetY = _moveUpAnim.value;
    }
    if (_rotateController.isAnimating || _rotateController.isCompleted) {
      offsetY = -(150.h); // 旋转阶段保持在上移后的位置
    }
    if (_moveDownController.isAnimating || _moveDownController.isCompleted) {
      offsetY = _moveDownAnim.value;
    }
    return offsetY;
  }

  double getAngle()=>_rotateAnim.value;

  @override
  bool initFlora121Event() => true;

  @override
  receivedFlora121EventMsg(int flora121Code, int? flora121IntValue, String? flora121StringValue, Map? flora121Map) {
    switch(flora121Code){
      case Flora121EventCode.showNewUserStep8DiceBtn:
        showNewUserStep8DiceBtn();
        break;
      case Flora121EventCode.changeToGoldMode:
        update(["gold_view"]);
        break;
    }
  }

  showNewUserStep8DiceBtn(){
    var renderBox = diceGlobalKey.currentContext?.findRenderObject() as RenderBox;
    var offset = renderBox.localToGlobal(Offset.zero);
    Flora121UserGuideUtils.instance.showStep8Guide(
      context: context,
      offset: offset,
      dismissCallback: (){
        clickStart(fromNewUserGuide: true);
      },
    );
  }

  double getOtherAddNum(int largeIndex,int smallIndex){
    var value = otherAddNumMap["${largeIndex}_$smallIndex"];
    if(null==value){
      otherAddNumMap["${largeIndex}_$smallIndex"]=Flora121ValueUtils.instance.getDiceOtherAddNum();
    }
    return otherAddNumMap["${largeIndex}_$smallIndex"]??0.0;
  }

  @override
  void onClose() {
    _moveUpController.dispose();
    _rotateController.dispose();
    _moveDownController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}