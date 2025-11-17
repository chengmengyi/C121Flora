import 'package:flora121_base/flora121_base/flora121_base_dialog.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_spine_animator_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_gold_dialog/flora121_gold_step1_dialog/flora121_gold_step1_dialog_con.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_gold_dialog/flora121_gold_step4_dialog/flora121_gold_step4_dialog_con.dart';
import 'package:flutter/material.dart';

class Flora121GoldStep4Dialog extends Flora121BaseDialog<Flora121GoldStep4DialogCon>{
  Function() clickNextCallback;
  Function() clickCloseCallback;
  Flora121GoldStep4Dialog({
    required this.clickNextCallback,
    required this.clickCloseCallback,
});
  @override
  Flora121GoldStep4DialogCon initBaseConFlora121() => Flora121GoldStep4DialogCon();

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
                baseCon.clickClose(clickCloseCallback);
              },
              child: Flora121ImagesView(imagesName: "icon_close",width: 30.w,height: 30.w,),
            ),
          ],
        ),
        SizedBox(height: 46.h,),
        Flora121TextView(
          text: "Oops!",
          color: "#FFFFFF",
          size: 36.sp,
          fontWeight: FontWeight.w900,
          textAlign: TextAlign.center,
        ),
        Flora121TextView(
          text: "Just one more step!",
          color: "#48DC2A",
          size: 36.sp,
          fontWeight: FontWeight.w900,
          textAlign: TextAlign.center,
        ),
        Flora121ImagesView(imagesName: "gold5",width: 204.w,height: 204.w,),
        Flora121TextView(text: "Advertiser review isn’t complete.", color: "#FFFFFF", size: 14.sp,fontWeight: FontWeight.bold,),
        SizedBox(height: 16.h,),
        RichText(
          text: TextSpan(
            children: [
              // We’re sorry for the delay — earn 20 gold bars
              // to complete your final payout instantly.
              TextSpan(
                text: "We’re sorry for the delay — ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                  color: "#FFFFFF".toColor(),
                ),
              ),
              TextSpan(
                text: "earn 20 gold bars",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                  color: "#F7FF00".toColor(),
                ),
              ),
              TextSpan(
                text: "to complete your final payout instantly.",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                  color: "#FFFFFF".toColor(),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 117.h,),
        Flora121Click(
          onTap: (){
            baseCon.clickNext(clickNextCallback);
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
            child: Flora121TextView(text: "Next", color: "#FFFFFF", size: 16.sp,fontWeight: FontWeight.bold,),
          ),
        ),
      ],
    ),
  );
}