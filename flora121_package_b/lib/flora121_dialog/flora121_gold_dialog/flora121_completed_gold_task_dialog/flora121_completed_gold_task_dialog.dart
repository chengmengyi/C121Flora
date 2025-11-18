import 'package:flora121_base/flora121_base/flora121_base_dialog.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_gold_dialog/flora121_completed_gold_task_dialog/flora121_completed_gold_task_dialog_con.dart';
import 'package:flutter/material.dart';

class Flora121CompletedGoldTaskDialog extends Flora121BaseDialog<Flora121CompletedGoldTaskDialogCon>{
  int cashMoney;
  Function() dismissCallback;
  Flora121CompletedGoldTaskDialog({
    required this.cashMoney,
    required this.dismissCallback,
});
  @override
  Flora121CompletedGoldTaskDialogCon initBaseConFlora121() => Flora121CompletedGoldTaskDialogCon();

  @override
  Widget initBaseWidgetFlora121() => Container(
    margin: EdgeInsets.only(left: 15.w,right: 15.w),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flora121Click(
              onTap: (){
                baseCon.clickClose(dismissCallback);
              },
              child: Flora121ImagesView(imagesName: "icon_close",width: 30.w,height: 30.w,),
            ),
          ],
        ),
        SizedBox(height: 40.h,),
        Flora121TextView(
          text: "Advertiser Approved",
          color: "#FFE77B",
          size: 26.sp,
          fontWeight: FontWeight.w900,
          textAlign: TextAlign.center,
        ),
        Flora121TextView(
          text: "& Bonus Unlocked！",
          color: "#FFE77B",
          size: 26.sp,
          fontWeight: FontWeight.w900,
          textAlign: TextAlign.center,
        ),
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Flora121ImagesView(imagesName: "gold1",width: 300.w,height: 300.w,),
                Flora121ImagesView(imagesName: "images_diamond",height: 245.w,fit: BoxFit.fitHeight,),
              ],
            ),
            Container(
              margin: EdgeInsets.only(bottom: 60.h),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Flora121ImagesView(imagesName: "gold6",width: 314.w,height: 58.h,),
                  Container(
                    margin: EdgeInsets.only(bottom: 6.h),
                    child: Flora121TextView(text: "\$$cashMoney", color: "#442202", size: 20.sp,fontWeight: FontWeight.w900,),
                  ),
                ],
              ),
            ),
          ],
        ),
        Flora121TextView(
          text: "Advertiser apologized and\nupgraded your account security.",
          color: "#FFFFFF",
          size: 16.sp,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.bold,
        ),
        SizedBox(height: 20.h,),
        Flora121TextView(
          text: "Collect 10 diamonds to speed up\nyour \$$cashMoney withdrawal.",
          color: "#9BFF29",
          size: 20.sp,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.bold,
        ),
        SizedBox(height: 30.h,),
        Flora121Click(
          onTap: (){
            baseCon.clickNext(dismissCallback);
          },
          child: Container(
            width: double.infinity,
            height: 50.h,
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 40.w,right: 40.w,),
            decoration: BoxDecoration(
              color: "#4C7D0A".toColor(),
              borderRadius: BorderRadius.circular(15.w),
            ),
            child: Flora121TextView(text: "Start Now", color: "#FFFFFF", size: 16.sp,fontWeight: FontWeight.bold,),
          ),
        ),
      ],
    ),
  );
}