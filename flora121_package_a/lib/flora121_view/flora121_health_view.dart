import 'dart:async';

import 'package:flora121_base/flora121_base/flora121_base_stateful.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_a/flora121_hep/flora121_event_code.dart';
import 'package:flora121_package_a/flora121_hep/flora121_user_info_utils.dart';
import 'package:flutter/material.dart';

class Flora121HealthView extends Flora121BaseStateful{
  @override
  State<StatefulWidget> createState() => _Flora121HealthViewState();
}

class _Flora121HealthViewState extends Flora121BaseStatefulState<Flora121HealthView>{
  
  @override
  Widget initBaseWidgetFlora121() => SizedBox(
    width: 130.w,
    height: 37.h,
    child: Stack(
      children: [
        Flora121ImagesView(imagesName: "home4",width: double.infinity,height: double.infinity,),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: EdgeInsets.only(left: 12.w),
            child: Flora121TextView(text: "Health", color: "#B9F6A6", size: 10.sp,fontWeight: FontWeight.bold,),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            width: 70.w,
            height: 21.h,
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 12.w),
            decoration: BoxDecoration(
              color: "#294E08".toColor(),
              borderRadius: BorderRadius.circular(15.w)
            ),
            child: Flora121TextView(text: "${Flora121UserInfoUtils.instance.getUserInfo()?.healthNum??0}/100", color: "#FFFFFF", size: 12.sp,fontWeight: FontWeight.bold,),
          ),
        )
      ],
    ),
  );


  @override
  bool initFlora121Event() => true;

  @override
  receivedFlora121EventMsg(int flora121Code, int? flora121IntValue, String? flora121StringValue, Map? flora121Map) {
    switch(flora121Code){
      case Flora121EventCode.updateHealthNum:
        setState(() {});
        break;
    }
  }
}