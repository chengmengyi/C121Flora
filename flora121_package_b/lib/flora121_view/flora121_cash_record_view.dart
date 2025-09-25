import 'dart:math';

import 'package:flora121_base/flora121_base/flora121_base_stateful.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_b/flora121_hep/flora121_event_code.dart';
import 'package:flora121_package_b/flora121_hep/flora121_hep.dart';
import 'package:flora121_package_b/flora121_hep/flora121_storage/flora121_storage.dart';
import 'package:flora121_package_b/flora121_hep/flora121_user_info_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_value_utils.dart';
import 'package:flutter/material.dart';

class Flora121CashRecordView extends Flora121BaseStateful{
  @override
  State<StatefulWidget> createState() => _Flora121CashRecordViewState();

}

class _Flora121CashRecordViewState extends Flora121BaseStatefulState<Flora121CashRecordView>{
  List<List<Widget>> marqueeList=[];

  @override
  void initState() {
    super.initState();
    _initMarqueeList();
  }

  @override
  Widget initBaseWidgetFlora121() {
    if(!bBarrageSwitch.getData()){
      return Container();
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: marqueeList.map((value){
        return SizedBox(
          height: 30.h,
          child: Marqueer(
            pps: 100,
            interaction: false,
            controller: MarqueerController(),
            direction: MarqueerDirection.rtl,
            restartAfterInteractionDuration: const Duration(seconds: 6),
            restartAfterInteraction: false,
            onChangeItemInViewPort: (index) {
            },
            onInteraction: () {
            },
            onStarted: () {
            },
            onStopped: () {
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: value,
            ),
          ),
        );

      }).toList(),
    );;
  }

  _initMarqueeList()async{
    var iconList = ["icon_cashapp_circle","icon_pagbank_circle","icon_paypal_circle","icon_pix_circle"];
    while(marqueeList.length<3){
      List<Widget> childList=[];
      while(childList.length<20){
        var id = Flora121UserInfoUtils.instance.generateRandomString(9);
        var money = Flora121ValueUtils.instance.getCashList().random();
        var icon = iconList.random();
        childList.add(Container(width: (Random().nextInt(100)+100).toDouble()));
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
        childList.add(Container(width: (Random().nextInt(100)+100).toDouble()));
      }
      await Future.delayed(Duration(milliseconds: Random().nextInt(1000)+1000));
      marqueeList.add(childList);
      setState(() {});
    }
  }

  @override
  bool initFlora121Event() => true;

  @override
  receivedFlora121EventMsg(int flora121Code, int? flora121IntValue, String? flora121StringValue, Map? flora121Map) {
    switch(flora121Code){
      case Flora121EventCode.updateBarrageShow:
        setState(() {});
        break;
    }
  }
}