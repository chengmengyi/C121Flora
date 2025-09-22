import 'package:flora121_base/flora121_base/flora121_base_dialog.dart';
import 'package:flora121_base/flora121_dialog/flora121_show_ad_fail_dialog/flora121_show_ad_fail_dialog_con.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flutter/material.dart';

class Flora121ShowAdFailDialog extends Flora121BaseDialog<Flora121ShowAdFailDialogCon>{
  Function() clickTryCall;
  Flora121ShowAdFailDialog({required this.clickTryCall,});

  @override
  Flora121ShowAdFailDialogCon initBaseConFlora121() => Flora121ShowAdFailDialogCon();

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
            Flora121TextView(text: "Quick Break - Back Soon!", color: "#7A5040", size: 16.sp,fontWeight: FontWeight.bold,),
            Flora121ImagesView(imagesName: "ad_fail1",width: 113.w,height: 113.w,),
            SizedBox(height: 10.h,),
            Flora121TextView(text: "More Cash Coming!", color: "#4C7D0A", size: 12.sp,fontWeight: FontWeight.bold,),
            SizedBox(height: 10.h,),
            Flora121Click(
              onTap: (){
                baseCon.clickTry(clickTryCall);
              },
              child: Container(
                width: double.infinity,
                height: 50.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: "#4C7D0A".toColor(),
                  borderRadius: BorderRadius.circular(15.w),
                ),
                child: Flora121TextView(text: "Try Again", color: "#FFFFFF", size: 16.sp,fontWeight: FontWeight.bold,),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 28.h,),
      Flora121Click(
        onTap: (){
          baseCon.clickClose();
        },
        child: Flora121ImagesView(imagesName: "icon_close",width: 30.w,height: 30.w,),
      ),
    ],
  );
}