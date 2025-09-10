import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flutter/material.dart';

class Flora121WatchVideoBtnWidget extends StatelessWidget{
  String text;
  String btnColor;
  EdgeInsetsGeometry? margin;
  Function()? onTap;
  Flora121WatchVideoBtnWidget({
    required this.text,
    required this.btnColor,
    this.margin,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) => Flora121Click(
    onTap: (){
      onTap?.call();
    },
    child: Container(
      margin: margin??EdgeInsets.only(left: 16.w,right: 16.w),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            width: double.infinity,
            height: 50.h,
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 20.h),
            decoration: BoxDecoration(
              color: btnColor.toColor(),
              borderRadius: BorderRadius.circular(15.w),
            ),
            child:Flora121TextView(text: text, color: "#FFFFFF", size: 16.sp,fontWeight: FontWeight.bold,),
          ),
          Flora121ImagesView(imagesName: "icon_video",width: 42.w,height: 42.h,),
        ],
      ),
    ),
  );
}