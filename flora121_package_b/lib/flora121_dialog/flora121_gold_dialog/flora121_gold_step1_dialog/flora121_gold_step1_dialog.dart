import 'package:flora121_base/flora121_base/flora121_base_dialog.dart';
import 'package:flora121_base/flora121_view/flora121_spine_animator_view.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_gold_dialog/flora121_gold_step1_dialog/flora121_gold_step1_dialog_con.dart';
import 'package:flutter/material.dart';

class Flora121GoldStep1Dialog extends Flora121BaseDialog<Flora121GoldStep1DialogCon>{
  Function() dismissCallback;
  Flora121GoldStep1Dialog({
    required this.dismissCallback,
});
  @override
  Flora121GoldStep1DialogCon initBaseConFlora121() => Flora121GoldStep1DialogCon(dismissCallback);

  @override
  Widget initBaseWidgetFlora121() => Flora121SpineAnimatorView(
    atlasFile: "1",
    skeletonFile: "skeleton",
    animatorName: "animation",
    folder: "gold1",
    width: double.infinity,
    height: double.infinity,
    controller: baseCon.spineWidgetController,
  );
}