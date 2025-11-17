import 'package:flora121_base/flora121_base/flora121_base_stateful.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_b/flora121_bean/flora121_gold_progress_bean.dart';
import 'package:flora121_package_b/flora121_hep/flora121_cash_task_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_event_code.dart';
import 'package:flutter/material.dart';

class Flora121HomeTopGoldView extends Flora121BaseStateful{
  @override
  State<StatefulWidget> createState() => _Flora121HomeTopGoldViewState();
}

class _Flora121HomeTopGoldViewState extends Flora121BaseStatefulState<Flora121HomeTopGoldView>{
  Flora121GoldProgressBean? flora121goldProgressBean;

  @override
  void initState() {
    super.initState();
    _queryProgress();
  }

  @override
  Widget initBaseWidgetFlora121() => Container(
    width: double.infinity,
    height: 114.h,
    margin: EdgeInsets.only(left: 12.w,right: 12.w,top: 10.h),
    child: Stack(
      children: [
        Flora121ImagesView(imagesName: "home21",width: double.infinity,height: double.infinity,),
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(left: 16.w,right: 16.w),
          child: _progressWidget(),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(bottom: 50.h,left: 18.w,right: 18.w),
            child: Flora121ImagesView(imagesName: "home25",width: double.infinity,height: 1.h,),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: _goldNumWidget(),
        ),
      ],
    ),
  );

  _goldNumWidget()=>Container(
    width: double.infinity,
    height: 50.h,
    alignment: Alignment.centerLeft,
    margin: EdgeInsets.only(left: 16.w,right: 16.w,bottom: 4.h),
    child: Row(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            height: 36.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.w),
              color: "#FFFFFF".toColor().withOpacity(0.15),
            ),
            child: Row(
              children: [
                Flora121ImagesView(imagesName: flora121goldProgressBean?.goldType==Flora121GoldMode.gold?"home26":"home29",width: 36.w,height: 36.h,),
                Expanded(
                  child: Center(
                    child: Flora121TextView(text: "${flora121goldProgressBean?.currentProgress??0} Received", color: "#2D5208", size: 16.sp,fontWeight: FontWeight.w900,),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 10.w,),
        Flora121ImagesView(imagesName: "home27",width: 1.w,height: 36.h,),
        SizedBox(width: 10.w,),
        Expanded(
          child: Container(
            width: double.infinity,
            height: 36.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.w),
              color: "#FFFFFF".toColor().withOpacity(0.15),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flora121ImagesView(imagesName: flora121goldProgressBean?.goldType==Flora121GoldMode.gold?"home26":"home29",width: 36.w,height: 36.h,),
                Expanded(
                  child: Center(
                    child: Flora121TextView(text: "${_getLeft()} Left", color: "#2D5208", size: 16.sp,fontWeight: FontWeight.w900,),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  _progressWidget()=>SizedBox(
    width: double.infinity,
    height: 60.h,
    child: Stack(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: double.infinity,
            height: 18.h,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 2.w,right: 2.w),
            margin: EdgeInsets.only(left: 30.w,right: 46.w),
            decoration: BoxDecoration(
              color: "#084708".toColor(),
              border: Border.all(
                width: 1.w,
                color: "#FFA81C".toColor(),
              ),
            ),
            child: LayoutBuilder(
              builder: (context,bc){
                var maxWidth = bc.maxWidth;
                return Container(
                  width: maxWidth*_getPro(),
                  height: 14.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.w),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: ["#B3FF3A".toColor(),"#489923".toColor(),]
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Flora121ImagesView(imagesName: flora121goldProgressBean?.goldType==Flora121GoldMode.gold?"home22":"home23",width: 40.w,height: 50.h,),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Flora121ImagesView(imagesName: "home24",width: 60.w,height: 60.h,),
        ),
      ],
    ),
  );

  double _getPro(){
    var totalProgress = flora121goldProgressBean?.totalProgress??0;
    if(totalProgress<=0){
      return 0.0;
    }
    var d = (flora121goldProgressBean?.currentProgress??0)/totalProgress;
    if(d<=0){
      return 0.0;
    }else if(d>=1.0){
      return 1.0;
    }else{
      return d;
    }
  }

  double _getLeft(){
    var totalProgress = flora121goldProgressBean?.totalProgress??0;
    var currentProgress = flora121goldProgressBean?.currentProgress??0;
    var d = (Decimal.parse("$totalProgress")-Decimal.parse("$currentProgress")).toDouble();
    if(d<=0){
      return d;
    }
    return d;
  }

  _queryProgress()async{
    flora121goldProgressBean = await Flora121CashTaskUtils.instance.queryGoldProgress();
    setState(() {});
  }

  @override
  bool initFlora121Event() => true;

  @override
  receivedFlora121EventMsg(int flora121Code, int? flora121IntValue, String? flora121StringValue, Map? flora121Map) {
    switch(flora121Code){
      case Flora121EventCode.changeToGoldMode:
        _queryProgress();
        break;
    }
  }
}