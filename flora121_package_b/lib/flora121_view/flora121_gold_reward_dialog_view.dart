import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_b/flora121_hep/flora121_cash_task_utils.dart';
import 'package:flora121_package_b/flora121_view/flora121_watch_video_btn_widget.dart';
import 'package:flutter/material.dart';

class Flora121GoldRewardDialogView extends StatelessWidget{
  String goldMode;
  double addNum;
  Function() clickGet;
  Function() clickClose;
  Flora121GoldRewardDialogView({
    required this.goldMode,
    required this.addNum,
    required this.clickGet,
    required this.clickClose,
});
  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: double.infinity,
        height: 448.h,
        margin: EdgeInsets.only(left: 34.w,right: 34.w),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Flora121ImagesView(imagesName: "gold_reward_bg",width: double.infinity,height: double.infinity,),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 200.w,
                  height: 200.h,
                  child: Stack(
                    children: [
                      Flora121ImagesView(imagesName: "get6",width: 200.w,height: 200.h,),
                      Align(
                        child: Flora121ImagesView(
                          imagesName: goldMode==Flora121GoldMode.gold?"icon_gold_large":"icon_diamond_large",
                          width: 200.w,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: EdgeInsets.only(bottom: 10.h),
                          child: Flora121TextView(text: "+$addNum", color: "#239E04", size: 16.sp,fontWeight: FontWeight.bold,),
                        ),
                      )
                    ],
                  ),
                ),
                Flora121TextView(text: "You get diamonds. ", color: "#239E04", size: 24.sp,fontWeight: FontWeight.bold,),
                SizedBox(height: 12.h,),
                Flora121WatchVideoBtnWidget(
                  text: "Collect",
                  btnColor: "#FBAC00",
                  onTap: (){
                    clickGet.call();
                  },
                ),
                SizedBox(height: 12.h,),
                Flora121Click(
                  onTap: (){
                    clickClose.call();
                  },
                  child: Flora121TextView(
                    text: "Give Up",
                    color: "#4C7D0A",
                    size: 12.sp,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    decorationColor: "#4C7D0A".toColor(),
                  ),
                ),
                SizedBox(height: 26.h,),
              ],
            ),
          ],
        ),
      ),
      SizedBox(height: 32.h,),
      Flora121Click(
        onTap: (){
          clickClose.call();
        },
        child: Flora121ImagesView(imagesName: "icon_close",width: 30.w,height: 30.w,),
      ),
    ],
  );
}