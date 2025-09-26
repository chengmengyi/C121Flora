import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_b/flora121_hep/flora121_value_utils.dart';
import 'package:flora121_package_b/flora121_view/flora121_finger_view.dart';
import 'package:flutter/material.dart';

class Flora121NewUserStep6View extends StatelessWidget{
  Offset firstOffset;
  Offset cashBtnOffset;
  Size firstSize;
  Function() dismissCallback;
  Flora121NewUserStep6View({
    required this.firstOffset,
    required this.firstSize,
    required this.cashBtnOffset,
    required this.dismissCallback,
});

  @override
  Widget build(BuildContext context) => Material(
    type: MaterialType.transparency,
    child: Flora121Click(
      onTap: (){
        dismissCallback.call();
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black.withOpacity(0.7),
        child: Stack(
          children: [
            Positioned(
              top: firstOffset.dy,
              left: firstOffset.dx,
              child: Container(
                width: firstSize.width,
                height: 66.h,
                decoration: BoxDecoration(
                  color: "#E6F8FF".toColor(),
                  borderRadius: BorderRadius.circular(16.w),
                  border: Border.all(
                    width: 2.w,
                    color: "#4179B9".toColor(),
                  ),
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Flora121ImagesView(imagesName: "icon_gou2",width: 20.w,height: 20.w,),
                    ),
                    Align(
                      child: Flora121TextView(text: "\$${Flora121ValueUtils.instance.getCashList().first}", color: "#313831", size: 16.sp,fontWeight: FontWeight.bold,),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: firstOffset.dy+80.h,
              left: 22.w,
              child: SizedBox(
                width: 260.w,
                height: 82.h,
                child: Stack(
                  children: [
                    Flora121ImagesView(imagesName: "step1",width: double.infinity,height: double.infinity,),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 25.h),
                        // child: Flora121TextView(text: "Almost there! Earn \$50 more today!", color: "#3B6204", size: 12.sp,fontWeight: FontWeight.bold,),
                        child: RichText(
                          text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Almost there! Earn ",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: "#3B6204".toColor(),
                                  ),
                                ),
                                TextSpan(
                                  text: "\$50",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: "#EF5D00".toColor(),
                                  ),
                                ),
                                TextSpan(
                                  text: " more today!",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: "#3B6204".toColor(),
                                  ),
                                ),
                              ]
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: cashBtnOffset.dy,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                height: 48.h,
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 18.w,right: 18.w),
                decoration: BoxDecoration(
                  color: "#1363AE".toColor(),
                  borderRadius: BorderRadius.circular(100.w),
                ),
                child: Flora121TextView(text: "Withdraw", color: "#FFFFFF", size: 16.sp,fontWeight: FontWeight.bold,),
              ),
            ),
            Positioned(
              top: cashBtnOffset.dy+24.h,
              right: 30.w,
              child: Flora121FingerView(),
            ),
          ],
        ),
      ),
    ),
  );
}