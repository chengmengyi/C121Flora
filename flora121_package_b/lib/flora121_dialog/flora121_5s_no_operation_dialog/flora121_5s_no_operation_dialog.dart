import 'package:flora121_base/flora121_base/flora121_base_dialog.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_spine_animator_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_5s_no_operation_dialog/flora121_5s_no_operation_dialog_con.dart';
import 'package:flora121_package_b/flora121_hep/flora121_storage/flora121_storage.dart';
import 'package:flora121_package_b/flora121_hep/flora121_value_utils.dart';
import 'package:flutter/material.dart';

class Flora1215sNoOperationDialog extends Flora121BaseDialog<Flora1215sNoOperationDialogCon>{
  @override
  Flora1215sNoOperationDialogCon initBaseConFlora121() => Flora1215sNoOperationDialogCon();

  @override
  Widget initBaseWidgetFlora121() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        margin: EdgeInsets.only(left: 34.w,right: 34.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.w),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                "#FFFDBC".toColor(),
                "#FFFDEF".toColor(),
              ]
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flora121TextView(text: "Safe funds have been locked", color: "#7A5040", size: 18.sp,fontWeight: FontWeight.bold,),
            SizedBox(height: 12.h,),
            Flora121SpineAnimatorView(atlasFile: "skeleton", skeletonFile: "skeleton", animatorName: "animation", folder: "naozhong",width: 168.w,height: 136.h,),
            Flora121TextView(text: "\$${bMyMoneyNum.getData()}", color: "#4C7D0A", size: 32.sp,fontWeight: FontWeight.bold,),
            Flora121TextView(text: "Account Limit", color: "#89937D", size: 14.sp,fontWeight: FontWeight.bold,),
            SizedBox(height: 12.h,),
            Flora121TextView(
              text: "Just \$${Flora121ValueUtils.instance.getCashLeftMoney()} more to unlock your payment.",
              color: "#8A5A07",
              size: 12.sp,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12.h,),
            Flora121Click(
              onTap: (){
                baseCon.clickKeep();
              },
              child: Container(
                width: double.infinity,
                height: 50.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: "#FBAC00".toColor(),
                  borderRadius: BorderRadius.circular(15.w),
                ),
                child: Flora121TextView(text: "Keep Earning", color: "#FFFFFF", size: 16.sp,fontWeight: FontWeight.bold,),
              ),
            )
          ],
        ),
      ),
      SizedBox(height: 26.h,),
      Flora121Click(
        onTap: (){
          Flora121RoutersHep.back();
        },
        child: Flora121ImagesView(imagesName: "icon_close",width: 30.w,height: 30.w,),
      ),
    ],
  );
}