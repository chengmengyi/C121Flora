import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flutter/material.dart';

class Flora121UserGuideHeadWidget extends StatelessWidget{
  String content;
  Flora121UserGuideHeadWidget({
    required this.content,
});
  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    margin: EdgeInsets.only(left: 50.w,right: 50.w),
    child: Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 25.h),
          padding: EdgeInsets.only(left: 12.w,right: 12.w,top: 45.h,bottom: 26.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.w),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: ["#FFFFFF".toColor(),"#F6FFDD".toColor(),]
            ),
          ),
          child: Flora121TextView(text: content, color: "#3F591B", size: 14.sp,fontWeight: FontWeight.bold,),
        ),
        Flora121ImagesView(imagesName: "icon_head",width: 70.w,height: 70.w,),
      ],
    ),
  );
}