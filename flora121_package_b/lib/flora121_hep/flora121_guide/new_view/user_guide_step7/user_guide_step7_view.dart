import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_b/flora121_view/flora121_finger_view.dart';
import 'package:flora121_package_b/flora121_view/flora121_user_guide_head_widget.dart';
import 'package:flutter/material.dart';

class UserGuideStep7View extends StatelessWidget{
  Offset offset;
  Function() clickCallback;
  UserGuideStep7View({
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
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: offset.dy+100.h),
                child: Flora121UserGuideHeadWidget(content: "Tap Here for Your Lucky Cash Reward!"),
              ),
            )
          ],
        ),
      ),
    ),
  );
}