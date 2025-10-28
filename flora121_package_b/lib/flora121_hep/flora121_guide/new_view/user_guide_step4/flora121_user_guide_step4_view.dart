import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_b/flora121_view/flora121_finger_view.dart';
import 'package:flora121_package_b/flora121_view/flora121_user_guide_head_widget.dart';
import 'package:flutter/material.dart';

class Flora121UserGuideStep4View extends StatelessWidget{
  Offset moneyOffset;
  Offset treeOffset;
  Function() clickCallback;
  Flora121UserGuideStep4View({
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
              top: moneyOffset.dy,
              left: moneyOffset.dx,
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Flora121ImagesView(imagesName: "energy_money",width: 66.w,height: 66.w,),
                  Flora121ImagesView(imagesName: "icon_video",width: 28.w,height: 28.h,),
                ],
              ),
            ),
            Positioned(
              top: moneyOffset.dy+30.h,
              left: moneyOffset.dx+30.w,
              child: Flora121FingerView(),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 50.h,
              child: Flora121UserGuideHeadWidget(content: "Just one ad for cash - exceptional value. Collect bubbles to start your cash flow!"),
            ),
          ],
        ),
      ),
    ),
  );
}