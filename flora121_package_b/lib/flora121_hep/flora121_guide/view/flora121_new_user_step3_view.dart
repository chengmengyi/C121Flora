import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_b/flora121_view/flora121_finger_view.dart';
import 'package:flutter/material.dart';

class Flora121NewUserStep3View extends StatelessWidget{
  Offset offset;
  Function() clickCallback;
  Flora121NewUserStep3View({
    required this.offset,
    required this.clickCallback,
  });

  @override
  Widget build(BuildContext context) => Material(
    type: MaterialType.transparency,
    child: Flora121Click(
      onTap: (){
        clickCallback.call();
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black.withOpacity(0.7),
        child: Stack(
          children: [
            Positioned(
              top: offset.dy,
              left: offset.dx,
              child: Flora121ImagesView(imagesName: "energy_dice",width: 66.w,height: 66.w,),
            ),
            Positioned(
              top: offset.dy+33.w,
              left: offset.dx+33.w,
              child: Flora121FingerView(),
            ),
            Positioned(
              top: offset.dy+80.h,
              left: 40.w,
              child: SizedBox(
                width: 260.w,
                height: 82.h,
                child: Stack(
                  children: [
                    Flora121ImagesView(imagesName: "step2",width: double.infinity,height: double.infinity,),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 25.h),
                        // child: Flora121TextView(text: "Tap Here for Your Lucky Cash Reward!", color: "#3B6204", size: 12.sp,fontWeight: FontWeight.bold,),
                        child: RichText(
                          text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Tap Here for Your ",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: "#3B6204".toColor(),
                                  ),
                                ),
                                TextSpan(
                                  text: "Lucky Cash Reward!",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: "#EF5D00".toColor(),
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
          ],
        ),
      ),
    ),
  );
}