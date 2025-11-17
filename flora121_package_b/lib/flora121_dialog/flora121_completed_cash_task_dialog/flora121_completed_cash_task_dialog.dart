import 'package:flora121_base/flora121_base/flora121_base_dialog.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_completed_cash_task_dialog/flora121_completed_cash_task_dialog_con.dart';
import 'package:flutter/material.dart';

class Flora121CompletedCashTaskDialog extends Flora121BaseDialog<Flora121CompletedCashTaskDialogCon>{
  Function() dismissCallback;
  Flora121CompletedCashTaskDialog({
    required this.dismissCallback,
});
  @override
  Flora121CompletedCashTaskDialogCon initBaseConFlora121() => Flora121CompletedCashTaskDialogCon();

  @override
  Widget initBaseWidgetFlora121() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        margin: EdgeInsets.only(left: 34.w,right: 34.w,),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.w),
          color: "#F9FFF2".toColor(),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flora121TextView(text: "Waiting to receive payment", color: "#7A5040", size: 16.sp,fontWeight: FontWeight.bold,),
            SizedBox(height: 5.h,),
            Flora121ImagesView(imagesName: "complete",width: 182.w,height: 155.h,),
            SizedBox(height: 5.h,),
            Flora121TextView(text: "Withdrawal request successful", color: "#4C7D0A", size: 14.sp,fontWeight: FontWeight.bold,),
            SizedBox(height: 16.h,),
            Flora121Click(
              onTap: (){
                baseCon.clickOk(dismissCallback);
              },
              child: Container(
                width: double.infinity,
                height: 50.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: "#4C7D0A".toColor(),
                  borderRadius: BorderRadius.circular(15.w),
                ),
                child: Flora121TextView(text: "OK", color: "#FFFFFF", size: 16.sp,fontWeight: FontWeight.bold,),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 28.h,),
      Flora121Click(
        onTap: (){
          baseCon.clickOk(dismissCallback);
        },
        child: Flora121ImagesView(imagesName: "icon_close",width: 30.w,height: 30.w,),
      ),
    ],
  );
}