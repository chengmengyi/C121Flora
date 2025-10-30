import 'package:flora121_base/flora121_base/flora121_base_dialog.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_b/flora121_hep/flora121_guide/new_view/user_guide_step3/user_guide_step3_con.dart';
import 'package:flutter/material.dart';

class UserGuideStep3Dialog extends Flora121BaseDialog<UserGuideStep3Con>{
  Function() dismissCallback;
  UserGuideStep3Dialog({
    required this.dismissCallback,
});
  @override
  UserGuideStep3Con initBaseConFlora121() => UserGuideStep3Con(dismissCallback);

  @override
  Widget initBaseWidgetFlora121() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: double.infinity,
        height: 376.h,
        alignment: Alignment.topCenter,
        margin: EdgeInsets.only(left: 50.w,right: 50.w),
        child: GetBuilder<UserGuideStep3Con>(
          id: "pro",
          builder: (_)=>ClipRRect(
            child: Align(
              alignment: Alignment.topCenter,
              heightFactor: baseCon.animationController.value,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _stepWidget("Contributing to eco projects"),
                  Flora121ImagesView(imagesName: "guide3",width: 40.w,height: 50.h,),
                  _stepWidget("Instant cash rewards 💵"),
                  Flora121ImagesView(imagesName: "guide3",width: 40.w,height: 50.h,),
                  _stepWidget("Reaching withdrawal goals"),
                ],
              ),
            ),
          ),
        ),
      ),
      SizedBox(height: 16.h,),
      GetBuilder<UserGuideStep3Con>(
        id: "gift",
        builder: (_)=>Visibility(
          visible: baseCon.showGift,
          maintainAnimation: true,
          maintainState: true,
          maintainSize: true,
          child: Row(
            children: [
              Flora121ImagesView(imagesName: "guide14",width: 153.w,height: 153.w,),
              Spacer(),
              Flora121ImagesView(imagesName: "guide15",width: 153.w,height: 153.w,),
            ],
          ),
        ),
      ),
    ],
  );

  _stepWidget(String content)=>Stack(
    alignment: Alignment.center,
    children: [
      Flora121ImagesView(imagesName: "guide2",width: double.infinity,height: 92.h,),
      Flora121TextView(text: content, color: "#3F591B", size: 18.sp,fontWeight: FontWeight.bold,),
    ],
  );
}