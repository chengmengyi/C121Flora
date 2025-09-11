import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flutter/material.dart';

class Flora121NewUserStep9View extends StatelessWidget{
  Offset offset;
  Function() dismissCallback;
  Flora121NewUserStep9View({
    required this.offset,
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
              top: offset.dy,
              left: offset.dx,
              child: Flora121ImagesView(imagesName: "energy_quiz",width: 66.w,height: 66.w,),
            ),
            Positioned(
              top: offset.dy+80.h,
              right: 0,
              child: SizedBox(
                width: 300.w,
                height: 82.h,
                child: Stack(
                  children: [
                    Flora121ImagesView(imagesName: "step2",width: double.infinity,height: double.infinity,),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 12.h),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flora121TextView(text: "Train your brain & earn!", color: "#3B6204", size: 12.sp,fontWeight: FontWeight.bold,),
                            Flora121TextView(text: "Smart players win fast. Quiz your way to cash!", color: "#3B6204", size: 12.sp,),
                          ],
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