import 'package:flora121_base/flora121_base/flora121_base_dialog.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_money_15_80_animator_dialog/flora121_money_15_80_animator_dialog_con.dart';
import 'package:flutter/material.dart';

class Flora121Money1580AnimatorDialog extends Flora121BaseDialog<Flora121Money1580AnimatorDialogCon>{
  Function() dismissCallback;
  Flora121Money1580AnimatorDialog({
    required this.dismissCallback,
});
  @override
  Flora121Money1580AnimatorDialogCon initBaseConFlora121() => Flora121Money1580AnimatorDialogCon(dismissCallback);

  @override
  Widget initBaseWidgetFlora121() => Stack(
    alignment: Alignment.center,
    children: [
      SlideTransition(
        position: baseCon.leftAnim,
        child: Flora121ImagesView(imagesName: "guide10",width: double.infinity,height: 243.h,),
      ),
      SlideTransition(
        position: baseCon.rightAnim,
        child: Flora121ImagesView(imagesName: "guide11",width: 310.w,height: 180.h,),
      ),
    ],
  );
}