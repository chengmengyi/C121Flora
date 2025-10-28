import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_b/flora121_view/flora121_user_guide_head_widget.dart';
import 'package:flutter/material.dart';

class UserGuideStep8View extends StatelessWidget{
  Offset offset;
  Function() clickCallback;
  UserGuideStep8View({
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
              top: offset.dy-200.h,
              left: 0,
              right: 0,
              child: Flora121UserGuideHeadWidget(content: "Roll the dice — and see what fortune has in store for you."),
            ),
          ],
        ),
      ),
    ),
  );
}