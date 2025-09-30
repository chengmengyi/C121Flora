import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_b/flora121_view/flora121_finger_view.dart';
import 'package:flutter/material.dart';

class Flora121NewUserStep7View extends StatelessWidget{
  Offset offset;
  Size size;
  Function() dismissCallback;
  Flora121NewUserStep7View({
    required this.offset,
    required this.size,
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
              child: SizedBox(
                width: size.width,
                height: 64.h,
                child: Stack(
                  children: [
                    Flora121ImagesView(imagesName: "cash_type_paypal",width: size.width,height: size.height,),
                    Align(
                      alignment: Alignment.topRight,
                      child: Flora121ImagesView(imagesName: "icon_gou3",width: 20.w,height: 20.w,),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.w),
                        border: Border.all(
                          width: 3.w,
                          color: "#FFBD09".toColor(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: offset.dy+30.h,
              left: offset.dx+size.width/3*2,
              child: Flora121FingerView(),
            ),
            Positioned(
              top: offset.dy-100.h,
              left: 0,
              child: SizedBox(
                width: 260.w,
                height: 82.h,
                child: Stack(
                  children: [
                    Flora121ImagesView(imagesName: "step3",width: double.infinity,height: double.infinity,),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: EdgeInsets.only(top: 10.h),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flora121TextView(text: "Quick pick!", color: "#3B6204", size: 12.sp,fontWeight: FontWeight.bold,),
                            Flora121TextView(text: "Cash out & keep supporting the Earth.", color: "#3B6204", size: 12.sp,),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}