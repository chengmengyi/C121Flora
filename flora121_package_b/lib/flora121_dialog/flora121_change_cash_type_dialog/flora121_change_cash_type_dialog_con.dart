import 'package:flora121_base/flora121_base/flora121_base_con.dart';
import 'package:flora121_base/flora121_hep/flora121_event/flora121_event_utils.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_package_b/flora121_hep/flora121_event_code.dart';
import 'package:flora121_package_b/flora121_hep/flora121_guide/flora121_user_guide_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_storage/flora121_storage.dart';
import 'package:flora121_package_b/flora_enum/flora121_cash_type.dart';
import 'package:flutter/material.dart';

class Flora121ChangeCashTypeDialogCon extends Flora121BaseCon{
  bool? fromNewUserGuide;
  var cashType=bSelectCashType.getData();
  GlobalKey firstTypeGlobalKey=GlobalKey();
  // List<String> cashTypeList=[Flora121CashType.paypal,Flora121CashType.cashApp,Flora121CashType.pagBank,Flora121CashType.pix];
  List<String> cashTypeList=[Flora121CashType.paypal,Flora121CashType.cashApp];

  @override
  void onReady() {
    super.onReady();
    _showGuide();
  }

  clickItem(String type){
    cashType=type;
    update(["list"]);
  }

  String getImage(String type){
    switch(type){
      case Flora121CashType.paypal: return "cash_type_paypal";
      case Flora121CashType.cashApp: return "cash_type_cashapp";
      case Flora121CashType.pagBank: return "cash_type_pagbank";
      case Flora121CashType.pix: return "cash_type_pix";
      default: return "cash_type_paypal";
    }
  }

  clickSubmit(){
    bSelectCashType.saveData(cashType);
    Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.updateCashType);
    Flora121RoutersHep.back();
  }

  clickClose(){
    Flora121RoutersHep.back();
  }

  _showGuide(){
    if(fromNewUserGuide!=true){
      return;
    }
    var renderBox = firstTypeGlobalKey.currentContext?.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);
    Flora121UserGuideUtils.instance.showStep5Guide(
      context: context,
      offset: offset,
      size: size,
      dismissCallback: (){
        Flora121RoutersHep.back();
      },
    );
  }
}