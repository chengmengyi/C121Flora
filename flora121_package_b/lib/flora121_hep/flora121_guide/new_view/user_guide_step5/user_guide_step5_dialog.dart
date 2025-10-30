import 'package:flora121_base/flora121_base/flora121_base_dialog.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_b/flora121_hep/flora121_guide/new_view/user_guide_step5/user_guide_step5_con.dart';
import 'package:flutter/material.dart';

class UserGuideStep5Dialog extends Flora121BaseDialog<UserGuideStep5Con>{
  int addNum;
  Function() dismissCallback;
  UserGuideStep5Dialog({
    required this.addNum,
    required this.dismissCallback,
});
  @override
  UserGuideStep5Con initBaseConFlora121() => UserGuideStep5Con();

  @override
  Widget initBaseWidgetFlora121() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: double.infinity,
        margin: EdgeInsets.only(left: 50.w,right: 50.w),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 25.h),
              padding: EdgeInsets.only(left: 12.w,right: 12.w,top: 45.h,bottom: 26.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.w),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: ["#FFFFFF".toColor(),"#F6FFDD".toColor(),]
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flora121ImagesView(imagesName: "guide4",width: 60.w,height: 52.h,),
                          Flora121TextView(text: "\$$addNum", color: "#000000", size: 14.sp,),
                        ],
                      ),
                      SizedBox(width: 8.w,),
                      Flora121ImagesView(imagesName: "guide5",width: 42.w,height: 33.h,),
                      SizedBox(width: 8.w,),
                      Flora121ImagesView(imagesName: "guide6",width: 64.w,height: 64.h,),
                    ],
                  ),
                  SizedBox(height: 10.h,),
                  Flora121TextView(text: "Your first cash is one tap away.", color: "#D27A16", size: 14.sp,fontWeight: FontWeight.bold,),
                  Flora121TextView(text: "Withdrawal information registration", color: "#3F591B", size: 12.sp,fontWeight: FontWeight.bold,),
                  Flora121TextView(text: "Ensure the safety of your funds", color: "#3F591B", size: 12.sp,fontWeight: FontWeight.bold,),
                ],
              ),
            ),
            Flora121ImagesView(imagesName: "icon_head",width: 70.w,height: 70.w,),
          ],
        ),
      ),
      SizedBox(height: 50.h,),
      Flora121Click(
        onTap: (){
          baseCon.clickNext(dismissCallback);
        },
        child: Container(
          width: double.infinity,
          height: 50.h,
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 50.w,right: 50.w),
          decoration: BoxDecoration(
            color: "#4C7D0A".toColor(),
            borderRadius: BorderRadius.circular(15.w),
          ),
          child: Flora121TextView(text: "Fill in", color: "#FFFFFF", size: 24.sp,fontWeight: FontWeight.bold,),
        ),
      ),
    ],
  );
}