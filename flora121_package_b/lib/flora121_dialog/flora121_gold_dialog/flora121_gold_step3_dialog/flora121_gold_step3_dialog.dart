import 'package:flora121_base/flora121_base/flora121_base_dialog.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_gold_dialog/flora121_gold_step2_dialog/flora121_gold_step2_dialog_con.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_gold_dialog/flora121_gold_step3_dialog/flora121_gold_step3_dialog_con.dart';
import 'package:flora121_package_b/flora121_hep/flora121_hep.dart';
import 'package:flora121_package_b/flora121_hep/flora121_storage/flora121_storage.dart';
import 'package:flutter/material.dart';

class Flora121GoldStep3Dialog extends Flora121BaseDialog<Flora121GoldStep3DialogCon>{
  int cashMoney;
  Function() clickOkCallback;
  Function() clickCloseCallback;
  Flora121GoldStep3Dialog({
    required this.cashMoney,
    required this.clickOkCallback,
    required this.clickCloseCallback,
});
  @override
  Flora121GoldStep3DialogCon initBaseConFlora121() => Flora121GoldStep3DialogCon(clickOkCallback);

  @override
  Widget initBaseWidgetFlora121() => Container(
    margin: EdgeInsets.only(left: 45.w,right: 45.w),
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
        SizedBox(height: 100.h,),
        _contentWidget(),
        SizedBox(height: 126.h,),
        // Flora121Click(
        //   onTap: (){
        //     baseCon.clickOk(clickOkCallback);
        //   },
        //   child: Container(
        //     width: double.infinity,
        //     height: 50.h,
        //     alignment: Alignment.center,
        //     margin: EdgeInsets.only(left: 40.w,right: 40.w,),
        //     decoration: BoxDecoration(
        //       color: "#4C7D0A".toColor(),
        //       borderRadius: BorderRadius.circular(15.w),
        //     ),
        //     child: Flora121TextView(text: "Next", color: "#FFFFFF", size: 16.sp,fontWeight: FontWeight.bold,),
        //   ),
        // ),
      ],
    ),
  );

  _contentWidget()=>Container(
    width: double.infinity,
    padding: EdgeInsets.all(4.w),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15.w),
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: ["#12B450".toColor(),"#A1B928".toColor(),]
      )
    ),
    child: Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: "#FFFFFF".toColor(),
        borderRadius: BorderRadius.circular(15.w),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flora121TextView(text: "Advertiser under review...", color: "#2B821E", size: 18.sp,fontWeight: FontWeight.bold,),
          SizedBox(height: 24.h,),
          SizedBox(
            width: double.infinity,
            height: 197.h,
            child: Stack(
              children: [
                Flora121ImagesView(imagesName: "gold3",width: double.infinity,height: double.infinity,),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: EdgeInsets.only(top: 14.h,),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Flora121ImagesView(imagesName: getCashTypeMoneyBg(bSelectCashType.getData()),width: 164.w,height: 74.h,),
                        Flora121TextView(text: "\$$cashMoney", color: "#000000", size: 32.sp,fontWeight: FontWeight.bold,),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 16.h),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 192.w,
                          height: 16.h,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 2.w,right: 2.w,),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.w),
                            color: "#084708".toColor(),
                          ),
                          child: GetBuilder<Flora121GoldStep3DialogCon>(
                            id: "pro_view",
                            builder: (_)=>Container(
                              width: (188.w)*baseCon.animationController.value,
                              height: 12.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.w),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: ["#FFFB00".toColor(),"#BC930B".toColor()],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 6.h,),
                        Flora121TextView(text: "Under review...", color: "#FFFFFF", size: 16.sp,fontWeight: FontWeight.bold,),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h,),
        ],
      ),
    ),
  );
}