import 'package:flora121_base/flora121_base/flora121_base_dialog.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_a/flora121_bean/flora121_store_bean.dart';
import 'package:flora121_package_a/flora121_dialog/flora121_store_detail_dialog/flora121_store_detail_dialog_con.dart';
import 'package:flutter/material.dart';

class Flora121StoreDetailDialog extends Flora121BaseDialog<Flora121StoreDetailDialogCon>{
  Flora121StoreBean bean;
  Flora121StoreDetailDialog({
    required this.bean,
});

  @override
  Flora121StoreDetailDialogCon initBaseConFlora121() => Flora121StoreDetailDialogCon();

  @override
  Widget initBaseWidgetFlora121() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: double.infinity,
        margin: EdgeInsets.only(left: 34.w,right: 34.w),
        decoration: BoxDecoration(
          color: "#80B640".toColor(),
          borderRadius: BorderRadius.circular(20.w),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 20.h,),
            _infoWidget(),
            SizedBox(height: 16.h,),
            _contentWidget(),
          ],
        ),
      ),
      SizedBox(height: 23.h,),
      Flora121Click(
        onTap: (){
          Flora121RoutersHep.back();
        },
        child: Flora121ImagesView(imagesName: "icon_close",width: 30.w,height: 30.w,),
      ),
    ],
  );

  _infoWidget()=>Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 80.w,
        height: 80.w,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2.w,
            color: "#FFFFFF".toColor(),
          ),
          borderRadius: BorderRadius.circular(40.w),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40.w),
          child: Flora121ImagesView(imagesName: bean.head??"",width: 80.w,height: 80.w,ext: "png",),
        ),
      ),
      SizedBox(width: 30.w,),
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flora121TextView(text: bean.name??"", color: "#0D4611", size: 24.sp,fontWeight: FontWeight.bold,),
          Flora121TextView(text: bean.type??"", color: "#FFFFFF", size: 14.sp,),
        ],
      ),
    ],
  );

  _contentWidget()=>Container(
    width: double.infinity,
    padding: EdgeInsets.all(18.w),
    constraints: BoxConstraints(
      maxHeight: 464.h,
    ),
    decoration: BoxDecoration(
      color: "#F9FFF2".toColor(),
      borderRadius: BorderRadius.circular(20.w),
    ),
    child: SingleChildScrollView(
      child: Flora121TextView(text: bean.storyEn??"", color: "#313831", size: 12.sp),
    ),
  );
}