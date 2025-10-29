import 'package:flora121_base/flora121_base/flora121_base_stateful.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_b/flora121_hep/flora121_event_code.dart';
import 'package:flora121_package_b/flora121_hep/flora121_guide/flora121_user_guide_utils.dart';
import 'package:flutter/material.dart';

class Flora121BannerView extends Flora121BaseStateful{
  @override
  State<StatefulWidget> createState() => _Flora121BannerViewState();
}

class _Flora121BannerViewState extends Flora121BaseStatefulState<Flora121BannerView>{
  var title="",content="";

  @override
  Widget initBaseWidgetFlora121() => Visibility(
    visible: title.isNotEmpty&&content.isNotEmpty,
    child: Container(
      width: double.infinity,
      height: 102.h,
      margin: EdgeInsets.only(left: 16.w,right: 16.w,top: 40.h),
      child: Stack(
        children: [
          Flora121ImagesView(imagesName: "banner",width: double.infinity,height: double.infinity,),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 20.h),
              child: Flora121TextView(text: title, color: "#915C00", size: 28.sp,fontWeight: FontWeight.bold,),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: 10.h),
              child: Flora121TextView(text: content, color: "#000000", size: 20.sp,fontWeight: FontWeight.bold,),
            ),
          ),
        ],
      ),
    ),
  );

  @override
  bool initFlora121Event() => true;

  @override
  receivedFlora121EventMsg(int flora121Code, int? flora121IntValue, String? flora121StringValue, Map? flora121Map) {
    switch(flora121Code){
      case Flora121EventCode.showBanner:
        showBanner(flora121Map);
        break;
    }
  }

  showBanner(Map? flora121map)async{
    if(Flora121UserGuideUtils.instance.isNewUerGuide){
      return;
    }
    setState(() {
      title=flora121map?["title"]??"";
      content=flora121map?["content"]??"";
    });
    await Future.delayed(Duration(milliseconds: 2000));
    setState(() {
      title="";
      content="";
    });
  }
}