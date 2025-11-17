import 'package:flora121_base/flora121_base/flora121_base_dialog.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_gold_dialog/flora121_completed_gold_and_diamond_task_dialog/flora121_completed_gold_and_diamond_task_dialog_con.dart';
import 'package:flutter/material.dart';

class Flora121CompletedGoldAndDiamondTaskDialog extends Flora121BaseDialog<Flora121CompletedGoldAndDiamondTaskDialogCon>{
  Function() dismissCallback;
  Flora121CompletedGoldAndDiamondTaskDialog({
    required this.dismissCallback,
});

  @override
  Flora121CompletedGoldAndDiamondTaskDialogCon initBaseConFlora121() => Flora121CompletedGoldAndDiamondTaskDialogCon();

  @override
  Widget initBaseWidgetFlora121() => Container(
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
        Flora121TextView(text: "Limit met, withdraw now!!", color: "#7A5040", size: 16.sp,fontWeight: FontWeight.bold,),
        SizedBox(height: 20.h,),
        Flora121ImagesView(imagesName: "has_money1",width: 168.w,height: 130.h,),
        Flora121TextView(text: "Cash arrives in seconds", color: "#4C7D0A", size: 12.sp,fontWeight: FontWeight.bold,),
        SizedBox(height: 34.h,),
        Flora121Click(
          onTap: (){
            baseCon.clickOk(dismissCallback);
          },
          child: Container(
            width: double.infinity,
            height: 50.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.w),
              color: "#4C7D0A".toColor(),
            ),
            child: Flora121TextView(text: "Right Now", color: "#FFFFFF", size: 16.sp,fontWeight: FontWeight.bold,),
          ),
        )
      ],
    ),
  );
}