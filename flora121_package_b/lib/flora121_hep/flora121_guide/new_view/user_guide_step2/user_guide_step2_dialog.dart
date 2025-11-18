import 'package:flora121_base/flora121_base/flora121_base_dialog.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_spine_animator_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_b/flora121_hep/flora121_guide/new_view/user_guide_step2/user_guide_step2_con.dart';
import 'package:flora121_package_b/flora121_view/flora121_user_guide_head_widget.dart';
import 'package:flutter/material.dart';

class UserGuideStep2Dialog extends Flora121BaseDialog<UserGuideStep2Con>{
  Function() dismissCallback;
  UserGuideStep2Dialog({
    required this.dismissCallback,
});

  @override
  UserGuideStep2Con initBaseConFlora121() => UserGuideStep2Con();

  @override
  Widget initBaseWidgetFlora121() => Flora121Click(
    onTap: (){
      baseCon.clickNext(dismissCallback);
    },
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flora121UserGuideHeadWidget(content: "We partner with sponsors who care about the environment.You can earn sponsorship rewards directly from their ads.The funds are used to reward users like you who make a difference for the planet."),
        SizedBox(height: 20.h,),
        Flora121SpineAnimatorView(
          atlasFile: "11",
          skeletonFile: "skeleton",
          animatorName: "animation",
          folder: "guide2",
          width: 300.w,
          height: 350.h,
        ),
        SizedBox(height: 40.h,),
        Flora121TextView(
          text: "Next",
          color: "#919191",
          size: 20.sp,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
          decorationColor: "#919191".toColor(),
        ),
      ],
    ),
  );
}