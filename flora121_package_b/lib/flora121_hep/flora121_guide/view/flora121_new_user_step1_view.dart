import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_b/flora121_view/flora121_finger_view.dart';
import 'package:flutter/material.dart';

class Flora121NewUserStep1View extends StatelessWidget{
  Offset moneyOffset;
  Offset treeOffset;
  Function() clickCallback;
  Flora121NewUserStep1View({
    required this.moneyOffset,
    required this.treeOffset,
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
              top: treeOffset.dy,
              left: treeOffset.dx,
              child: Flora121ImagesView(imagesName: "flower1",width: 100.w,),
            ),
            Positioned(
              top: moneyOffset.dy,
              left: moneyOffset.dx,
              child: Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flora121ImagesView(imagesName: "energy_money",width: 66.w,height: 66.w,),
                      SizedBox(
                        width: 260.w,
                        height: 82.h,
                        child: Stack(
                          children: [
                            Flora121ImagesView(imagesName: "step1",width: double.infinity,height: double.infinity,),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                margin: EdgeInsets.only(bottom: 22.h),
                                child: Flora121TextView(text: "Collect bubbles to start your cash flow!", color: "#3B6204", size: 12.sp,fontWeight: FontWeight.bold,),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 40.h,
                    left: 40.w,
                    child: Flora121FingerView(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}