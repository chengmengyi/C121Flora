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
      case Flora121CashTaskIndex.tasks1: return "Security Verification";
      case Flora121CashTaskIndex.tasks2: return "Earnings Review";
      case Flora121CashTaskIndex.tasks3: return "Transaction Processing";
      case Flora121CashTaskIndex.tasks4: return "Identity Confirmation";
      case Flora121CashTaskIndex.tasks5: return "Compliance Check";
      default: return "";
    }
  }

  String getDescStr(Flora121CashTaskBean? taskBean){
    switch(taskBean?.cashTaskIndex){
      case Flora121CashTaskIndex.tasks1: return "Your withdrawal is under security verification. Please complete the required task to confirm account authenticity.";
      case Flora121CashTaskIndex.tasks2: return "Your Eco earnings are being reviewed. Verification is needed to ensure all contributions are valid.";
      case Flora121CashTaskIndex.tasks3: return "Withdrawal request is being processed. We are confirming account and transaction details for your security.";
      case Flora121CashTaskIndex.tasks4: return "Suspicious activity detected. Please complete verification tasks to confirm your identity and proceed with withdrawal.";
      case Flora121CashTaskIndex.tasks5: return "Your withdrawal is pending compliance review. Complete the required steps to validate your account and release funds.";
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