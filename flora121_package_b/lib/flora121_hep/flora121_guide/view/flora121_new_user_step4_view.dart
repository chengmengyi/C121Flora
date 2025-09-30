import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flutter/material.dart';

class Flora121NewUserStep4View extends StatelessWidget{
  Offset offset;
  Function() clickCallback;
  Flora121NewUserStep4View({
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
              left: 0,
              right: 0,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                      width: 96.w,
                      height: 96.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: "#386309".toColor(),
                        borderRadius: BorderRadius.circular(48.w),
                      ),
                      child: Flora121ImagesView(imagesName: "dice1",width: 68.w,height: 68.w,)
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 70.h),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Flora121ImagesView(imagesName: "btn1",width: 214.w,height: 50.h,),
                        Flora121TextView(text: "Roll The Dice", color: "#FFFFFF", size: 16.sp,outlineColor: "#774005",),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: offset.dy-100.h,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 260.w,
                    height: 82.h,
                    child: Stack(
                      children: [
                        Flora121ImagesView(imagesName: "step3",width: double.infinity,height: double.infinity,),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            margin: EdgeInsets.only(top: 22.h),
                            child: Flora121TextView(text: "Every move helps nature!", color: "#3B6204", size: 12.sp,fontWeight: FontWeight.bold,),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}