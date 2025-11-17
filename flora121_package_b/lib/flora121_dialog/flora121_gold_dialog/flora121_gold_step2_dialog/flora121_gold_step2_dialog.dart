import 'package:flora121_base/flora121_base/flora121_base_dialog.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_gold_dialog/flora121_gold_step2_dialog/flora121_gold_step2_dialog_con.dart';
import 'package:flutter/material.dart';

class Flora121GoldStep2Dialog extends Flora121BaseDialog<Flora121GoldStep2DialogCon>{
  int cashMoney;
  Function() clickOkCallback;
  Flora121GoldStep2Dialog({
    required this.cashMoney,
    required this.clickOkCallback,
});
  @override
  Flora121GoldStep2DialogCon initBaseConFlora121() => Flora121GoldStep2DialogCon();

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
                baseCon.clickClose();
              },
              child: Flora121ImagesView(imagesName: "icon_close",width: 30.w,height: 30.w,),
            ),
          ],
        ),
        SizedBox(height: 46.h,),
        Flora121TextView(
          text: "\$$cashMoney has been safely stored\nin your vault",
          color: "#FFEC43",
          size: 24.sp,
          fontWeight: FontWeight.w900,
          textAlign: TextAlign.center,
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            Flora121ImagesView(imagesName: "gold1",width: 300.w,height: 300.w,),
            Flora121ImagesView(imagesName: "gold2",width: 300.w,height: 190.w,),
          ],
        ),
        Flora121TextView(text: "Funds are ready — payout will be sent anytime.", color: "#FFFFFF", size: 14.sp,),
        SizedBox(height: 90.h,),
        Flora121Click(
          onTap: (){
            baseCon.clickOk(clickOkCallback);
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