import 'package:flora121_base/flora121_base/flora121_base_dialog.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_donot_worry_dialog/flora121_donot_worry_dialog_con.dart';
import 'package:flutter/material.dart';

class Flora121DonotWorryDialog extends Flora121BaseDialog<Flora121DonotWorryDialogCon>{
  Function() dismissCallback;
  Flora121DonotWorryDialog({
    required this.dismissCallback,
});
  @override
  Flora121DonotWorryDialogCon initBaseConFlora121() => Flora121DonotWorryDialogCon();

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
            Flora121TextView(text: "Don't Worry", color: "#7A5040", size: 16.sp,fontWeight: FontWeight.bold,),
            Flora121ImagesView(imagesName: "task_tips2",width: 140.w,height: 140.w,),
            Flora121TextView(
              text: "We will assist you with completing your\nwithdrawal—simply follow the\nsteps below to finalize the process.",
              color: "#4C7D0A",
               size: 12.sp,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 12.h,),
            Flora121Click(
              onTap: (){
                baseCon.clickClose(dismissCallback);
              },
              child: Container(
                width: double.infinity,
                height: 50.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: "#4C7D0A".toColor(),
                  borderRadius: BorderRadius.circular(15.w,),
                ),
                child: Flora121TextView(text: "Instantly Credited", color: "#FFFFFF", size: 16.sp,fontWeight: FontWeight.bold,),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 28.h,),
      Flora121Click(
        onTap: (){
          baseCon.clickClose(dismissCallback);
        },
        child: Flora121ImagesView(imagesName: "icon_close",width: 30.w,height: 30.w,),
      ),
    ],
  );
}