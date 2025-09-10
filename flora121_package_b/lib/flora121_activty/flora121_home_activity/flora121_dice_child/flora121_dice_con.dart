import 'dart:async';
import 'dart:math';
import 'package:flora121_base/flora121_base/flora121_base_con.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_package_b/flora121_hep/flora121_event_code.dart';
import 'package:flora121_package_b/flora121_hep/flora121_guide/flora121_user_guide_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_storage/flora121_storage.dart';
import 'package:flutter/material.dart';

class Flora121DiceCon extends Flora121BaseCon with GetTickerProviderStateMixin{
  late AnimationController _moveUpController;   // 上移动画
  late AnimationController _rotateController;   // 旋转动画
  late AnimationController _moveDownController; // 下移动画
  late Animation<double> _moveUpAnim;
  late Animation<double> _rotateAnim;
  late Animation<double> _moveDownAnim;

  Timer? _timer;
  int currentDiceIndex = 0,currentDiceLargeIndex=0,currentDiceSmallIndex=0;
  bool _isAnimating = false;
  final List<String> diceImages = ["dice1","dice2","dice3","dice4","dice5","dice6",];

  GlobalKey diceGlobalKey = GlobalKey();

  @override
  void onInit() {
    super.onInit();
    currentDiceLargeIndex=bDiceLargeIndex.getData();
    currentDiceSmallIndex=bDiceSmallIndex.getData();
    _initAnimator();
  }

  clickStart(){
    if (_isAnimating) return; // 避免动画还在进行时重复触发
    _isAnimating = true;

    // 重置所有 controller
    _moveUpController.reset();
    _rotateController.reset();
    _moveDownController.reset();

    // 动画流程
    _moveUpController.forward().whenComplete(() {
      _startRolling();
    });
  }

  _startRolling() {
    // 定时切换点数
    _timer = Timer.periodic(const Duration(milliseconds: 80), (timer) {
      currentDiceIndex = Random().nextInt(6);
      update(["dice_result"]);
    });

    _rotateController.forward().whenComplete(() async {
      // 停止随机，固定结果
      _timer?.cancel();
      currentDiceIndex = Random().nextInt(6);
      update(["dice_result"]);
      // 停留 2 秒
      await Future.delayed(const Duration(seconds: 1));
      // 下移动画
      _moveDownController.forward().whenComplete(() {
        _isAnimating = false; // 动画结束，可以再次点击
      });
    });
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

  String getDiceIcon()=>diceImages[currentDiceIndex];

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
      case Flora121EventCode.showNewUserStep4DiceBtn:
        showNewUserStep4DiceBtn();
        break;
    }
  }

  showNewUserStep4DiceBtn(){
    var renderBox = diceGlobalKey.currentContext?.findRenderObject() as RenderBox;
    var offset = renderBox.localToGlobal(Offset.zero);
    Flora121UserGuideUtils.instance.showStep4Overlay(context, offset);
  }

  @override
  void onClose() {

    super.onClose();
  }
}