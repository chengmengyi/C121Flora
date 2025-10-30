import 'package:flora121_base/flora121_base/flora121_base_dialog.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_b/flora121_hep/flora121_guide/new_view/user_guide_step1/user_guide_step1_controller.dart';
import 'package:flora121_package_b/flora121_view/flora121_user_guide_head_widget.dart';
import 'package:flutter/material.dart';

class UserGuideStep1Dialog extends Flora121BaseDialog<UserGuideStep1Controller>{
  Function() dismissCallback;
  UserGuideStep1Dialog({
    required this.dismissCallback,
  });

  @override
  UserGuideStep1Controller initBaseConFlora121() => UserGuideStep1Controller();

  @override
  Widget initBaseWidgetFlora121() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Flora121UserGuideHeadWidget(content: "Hello, I’m Jessica, the promoter of this app. \nI’ll show you how to earn money and contribute to environmental protection through it."),
      SizedBox(height: 260.h,),
      Flora121Click(
        onTap: (){
          baseCon.clickNext(dismissCallback);
        },
        child: Container(
          width: double.infinity,
          height: 50.h,
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 50.w,right: 50.w),
          decoration: BoxDecoration(
            color: "#4C7D0A".toColor(),
            borderRadius: BorderRadius.circular(15.w),
          ),
          child: Flora121TextView(text: "Next", color: "#FFFFFF", size: 24.sp,fontWeight: FontWeight.bold,),
        ),
      ),
    ],
  );
}