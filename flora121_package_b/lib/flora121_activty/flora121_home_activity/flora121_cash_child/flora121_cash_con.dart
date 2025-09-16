import 'dart:math';

import 'package:flora121_base/flora121_base/flora121_base_con.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_b/flora121_bean/flora121_amount_bean.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_input_email_dialog/flora121_input_email_dialog.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_no_money_dialog/flora121_no_money_dialog.dart';
import 'package:flora121_package_b/flora121_hep/flora121_event_code.dart';
import 'package:flora121_package_b/flora121_hep/flora121_guide/flora121_user_guide_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_hep.dart';
import 'package:flora121_package_b/flora121_hep/flora121_storage/flora121_storage.dart';
import 'package:flora121_package_b/flora121_hep/flora121_user_info_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_value_utils.dart';
import 'package:flora121_package_b/flora_enum/flora121_cash_type.dart';
import 'package:flutter/material.dart';

class Flora121CashCon extends Flora121BaseCon{
  var chooseIndex=0;
  List<List<Widget>> marqueeList=[];
  GlobalKey firstCashAmountGlobalKey=GlobalKey();
  GlobalKey cashBtnGlobalKey=GlobalKey();
  List<Flora121AmountBean> amountList=[];

  @override
  void onReady() {
    super.onReady();
    _initMarqueeList();
    _initAmountList();
  }

  clickAmountItem(index){
    if(chooseIndex==index){
      return;
    }
    chooseIndex=index;
    update(["amount"]);
  }

  clickCash(){
    var myMoney= bMyMoneyNum.getData();
    var bean = amountList[chooseIndex];
    if(myMoney<bean.money){
      Flora121RoutersHep.dialog(
        child: Flora121NoMoneyDialog(),
      );
      return;
    }
    var cashType = bSelectCashType.getData();
    switch(cashType){
      case Flora121CashType.pagBank:
      case Flora121CashType.paypal:
        Flora121RoutersHep.dialog(
          child: Flora121InputEmailDialog(cashType: cashType),
        );
        break;
    }
  }

  _initAmountList(){
    amountList.clear();
    for (var value in Flora121ValueUtils.instance.getCashList()) {
      amountList.add(Flora121AmountBean(money: value));
    }
    update(["amount"]);
  }

  _initMarqueeList()async{
    var iconList = ["icon_cashapp_circle","icon_pagbank_circle","icon_paypal_circle","icon_pix_circle"];
    while(marqueeList.length<3){
      List<Widget> childList=[];
      while(childList.length<20){
        var id = Flora121UserInfoUtils.instance.generateRandomString(9);
        var money = Flora121ValueUtils.instance.getCashList().random();
        var icon = iconList.random();
        childList.add(
            Container(
              padding: EdgeInsets.only(right: 16.w),
              margin: EdgeInsets.only(left: 10.w,right: 10.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.w),
                color: "#565656".toColor(),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flora121ImagesView(imagesName: icon,width: 20.w,height: 20.w,),
                  SizedBox(width: 10.w,),
                  Flora121TextView(text: "Congrats,", color: "#FFFFFF", size: 10.sp,fontWeight: FontWeight.bold,),
                  Flora121TextView(text: idStar(id), color: "#20D810", size: 10.sp,fontWeight: FontWeight.bold,),
                  Flora121TextView(text: " withdraw ", color: "#FFFFFF", size: 10.sp,fontWeight: FontWeight.bold,),
                  Flora121TextView(text: "\$$money", color: "#FFEA00", size: 10.sp,fontWeight: FontWeight.bold,),
                ],
              ),
            )
        );
      }
      await Future.delayed(Duration(milliseconds: Random().nextInt(1000)+1000));
      marqueeList.add(childList);
      update(["marquee"]);
    }
  }

  double getCashLeft(){
    var first = Flora121ValueUtils.instance.getCashList().first;
    var data = bMyMoneyNum.getData();
    var result = (Decimal.fromInt(first)-Decimal.fromJson("$data")).toDouble();
    if(result<0){
      return 0;
    }
    return result;
  }

  double getCashLeftProgress(){
    var first = Flora121ValueUtils.instance.getCashList().first;
    var data = bMyMoneyNum.getData();
    var d = data/first;
    if(d<0){
      return 0.0;
    }else if(d>1){
      return 1.0;
    }else{
      return d;
    }
  }

  @override
  bool initFlora121Event() => true;

  @override
  receivedFlora121EventMsg(int flora121Code, int? flora121IntValue, String? flora121StringValue, Map? flora121Map) {
    switch(flora121Code){
      case Flora121EventCode.showNewUserStep6GuideFirstCashAmount:
        showNewUserStep6GuideFirstCashAmount();
        break;
    }
  }

  showNewUserStep6GuideFirstCashAmount(){
    var firstRenderBox = firstCashAmountGlobalKey.currentContext?.findRenderObject() as RenderBox;
    var firstSize = firstRenderBox.size;
    var firstOffset = firstRenderBox.localToGlobal(Offset.zero);

    var cashBtnRenderBox = cashBtnGlobalKey.currentContext?.findRenderObject() as RenderBox;
    var cashBtnOffset = cashBtnRenderBox.localToGlobal(Offset.zero);
    Flora121UserGuideUtils.instance.showStep6Guide(context, firstOffset, firstSize,cashBtnOffset);
  }
}