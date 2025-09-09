import 'package:flora121_base/flora121_base/flora121_base_dialog.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_get_water_dialog/flora121_get_water_dialog_con.dart';
import 'package:flutter/material.dart';

class Flora121GetWaterDialog extends Flora121BaseDialog<Flora121GetWaterDialogCon>{
  int waterNum;
  bool? isHealth;
  String taskType;
  Function() getCallback;
  Flora121GetWaterDialog({
    required this.waterNum,
    required this.taskType,
    this.isHealth,
    required this.getCallback,
});

  @override
  Flora121GetWaterDialogCon initBaseConFlora121() => Flora121GetWaterDialogCon();

  @override
  Widget initBaseWidgetFlora121() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: double.infinity,
        height: 380.h,
        margin: EdgeInsets.only(left: 34.w,right: 34.w),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Flora121ImagesView(imagesName: "get1",width: double.infinity,height: double.infinity,),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _waterWidget(),
                SizedBox(height: 10.h,),
                Flora121TextView(text: "Get Water Droplets", color: "#7A5040", size: 14.sp,fontWeight: FontWeight.bold,),
                SizedBox(height: 10.h,),
                _doubleBtnWidget(),
                SizedBox(height: 10.h,),
                _singleBtnWidget(),
                SizedBox(height: 35.h,),
              ],
            ),
          ],
        ),
      ),
      SizedBox(height: 26.h,),
      Flora121Click(
        onTap: (){
          Flora121RoutersHep.back();
        },
        child: Flora121ImagesView(imagesName: "icon_close",width: 30.w,height: 30.w,),
      ),
    ],
  );
  
  _waterWidget()=>SizedBox(
    width: 197.w,
    height: 144.h,
    child: Stack(
      children: [
        Flora121ImagesView(imagesName: "get2",width: 197.w,height: 144.h,),
        Align(
          alignment: Alignment.bottomCenter,
          child: Flora121ImagesView(imagesName: "get3",width: 128.w,height: 117.h,),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Visibility(
            visible: isHealth==true,
            child: Flora121TextView(text: "+$waterNum", color: "#7A5040", size: 14.sp,fontWeight: FontWeight.bold,),
          ),
        ),
      ],
    ),
  );

  _doubleBtnWidget()=>Flora121Click(
    onTap: (){
      baseCon.getDouble(taskType,isHealth,waterNum,getCallback);
    },
    child: Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          width: 273.w,
          height: 50.h,
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 20.h),
          decoration: BoxDecoration(
            color: "#4C7D0A".toColor(),
            borderRadius: BorderRadius.circular(15.w),
          ),
          child:Flora121TextView(text: "Claim  X2", color: "#FFFFFF", size: 16.sp,fontWeight: FontWeight.bold,),
        ),
        Flora121ImagesView(imagesName: "icon_video",width: 42.w,height: 42.h,),
      ],
    ),
  );
  
  _singleBtnWidget()=>Flora121Click(
    onTap: (){
      baseCon.getSingle(taskType,isHealth,waterNum,getCallback);
    },
    child: Flora121TextView(
      text: "Claim  X1",
      color: "#4C7D0A",
      size: 12.sp,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.underline,
      decorationColor: "#4C7D0A".toColor(),
    ),
  );
}