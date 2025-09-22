import 'dart:async';
import 'dart:math';

import 'package:flora121_base/flora121_base/flora121_base_con.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_point_enum.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_ttt.dart';
import 'package:flora121_package_b/flora121_bean/flora121_cash_record_bean.dart';
import 'package:flora121_package_b/flora121_bean/flora121_cash_task_bean.dart';
import 'package:flora121_package_b/flora121_hep/flora121_user_info_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_value_utils.dart';
import 'package:flora121_package_b/flora_enum/flora121_cash_task_type.dart';
import 'package:flutter/material.dart';

class Flora121CashTaskDialogCon extends Flora121BaseCon{
  List<Flora121CashRecordBean> recordList=[];
  ScrollController scrollController = ScrollController();
  Timer? _timer;
  final double _itemHeight = 23.h;
  final int _itemCount = 50;
  int _currentIndex = 0;

  @override
  void onInit() {
    super.onInit();
    _initRecord();
  }

  String getTitleStr(Flora121CashTaskBean? taskBean){
    switch(taskBean?.cashTaskIndex){
      case Flora121CashTaskIndex.tasks1: return "Withdrawal Unlock";
      case Flora121CashTaskIndex.tasks2: return "The device being used is not your usual device.";
      case Flora121CashTaskIndex.tasks3: return "Withdrawal Sprint";
      case Flora121CashTaskIndex.tasks4: return "Human Verification";
      case Flora121CashTaskIndex.tasks5: return "Withdrawal Complete! ";
      default: return "";
    }
  }

  String getDescStr(Flora121CashTaskBean? taskBean){
    switch(taskBean?.cashTaskIndex){
      case Flora121CashTaskIndex.tasks1: return "Abnormal activity detected on your account.Complete the task to verify you're a real person.";
      case Flora121CashTaskIndex.tasks2: return "Just one more step to withdraw.";
      case Flora121CashTaskIndex.tasks3: return "Keep going! Roll the Dice and claim your reward.";
      case Flora121CashTaskIndex.tasks4: return "Please complete human verification before withdrawing.";
      case Flora121CashTaskIndex.tasks5: return "The payment was successful, but the current bank queue is long. Complete tasks to become a VIP and enjoy priority payments.";
      default: return "";
    }
  }

  _initRecord(){
    while(recordList.length<_itemCount){
      var date = _getRandomRecentDate();
      var account = Flora121UserInfoUtils.instance.generateRandomString(6);
      var money = Flora121ValueUtils.instance.getCashList().random();
      recordList.add(Flora121CashRecordBean(date: date, account: account, money: money));
    }
    _startAutoScroll();
  }

  String _getRandomRecentDate() {
    final now = DateTime.now();
    final random = Random();
    int offset = random.nextInt(3);
    final date = now.subtract(Duration(days: offset));
    return "${date.month.toString().padLeft(2, '0')}."
        "${date.day.toString().padLeft(2, '0')}."
        "${date.year.toString().padLeft(4, '0')}";
  }

  _startAutoScroll(){
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _currentIndex++;
      if (_currentIndex >= _itemCount) {
        _currentIndex = 0;
        scrollController.jumpTo(0);
      }
      scrollController.animateTo(
        _currentIndex * _itemHeight,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }
  
  String userIdAddStar(String userId){
    var start = userId.substring(0,2);
    var end = userId.substring(4,6);
    return "$start**$end";
  }

  clickClose(){
    Flora121RoutersHep.back();
  }

  @override
  void onClose() {
    scrollController.dispose();
    _timer?.cancel();
    _timer=null;
    super.onClose();
  }
}