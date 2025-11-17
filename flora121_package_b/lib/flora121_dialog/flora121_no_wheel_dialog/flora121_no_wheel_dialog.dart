import 'package:flora121_base/flora121_base/flora121_base_dialog.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_no_wheel_dialog/flora121_no_wheel_dialog_con.dart';
import 'package:flutter/material.dart';

class Flora121NoWheelDialog extends Flora121BaseDialog<Flora121NoWheelDialogCon>{
  @override
  Flora121NoWheelDialogCon initBaseConFlora121() => Flora121NoWheelDialogCon();

  @override
  Widget initBaseWidgetFlora121() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        margin: EdgeInsets.only(left: 34.w,right: 34.w),
        decoration: BoxDecoration(
          color: "#F9FFF2".toColor(),
          borderRadius: BorderRadius.circular(20.w),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flora121TextView(text: "No more spins available", color: "#7A5040", size: 16.sp,fontWeight: FontWeight.bold,),
            Flora121ImagesView(imagesName: "no_wheel2",width: 113.w,height: 113.w,),
            Flora121TextView(text: "Quiz Now - Earn Spins!", color: "#4C7D0A", size: 12.sp,fontWeight: FontWeight.bold,),
            Flora121Click(
              onTap: (){
                baseCon.clickAd();
              },
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    width: double.infinity,
                    height: 50.h,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 20.h),
                    decoration: BoxDecoration(
                      color: "#FBAC00".toColor(),
                      borderRadius: BorderRadius.circular(15.w),
                    ),
                    child: Flora121TextView(text: "Directly obtain", color: "#FFFFFF", size: 16.sp,fontWeight: FontWeight.bold,),
                  ),
                  Flora121ImagesView(imagesName: "icon_video",width: 42.w,height: 42.w,),
                ],
              ),
            ),
            SizedBox(height: 12.h,),
            Flora121Click(
              onTap: (){
                baseCon.clickEarn();
              },
              child: Container(
                width: double.infinity,
                height: 50.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.w),
                  color: "#4C7D0A".toColor(),
                ),
                child: Flora121TextView(text: "Earn Spins", color: "#FFFFFF", size: 16.sp,fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 18.h,),
      Flora121Click(
        onTap: (){
          baseCon.clickClose();
        },
        child: Flora121ImagesView(imagesName: "icon_close",width: 30.w,height: 30.w,),
      ),
    ],
  );
}