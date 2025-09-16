import 'package:flora121_base/flora121_base/flora121_base_dialog.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_input_email_dialog/flora121_input_email_dialog_con.dart';
import 'package:flutter/material.dart';

class Flora121InputEmailDialog extends Flora121BaseDialog<Flora121InputEmailDialogCon>{
  String cashType;
  Flora121InputEmailDialog({
    required this.cashType,
  });

  @override
  Flora121InputEmailDialogCon initBaseConFlora121() => Flora121InputEmailDialogCon();

  @override
  Widget initBaseWidgetFlora121() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Stack(
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(left: 34.w,right: 34.w),
            decoration: BoxDecoration(
              color: "#F9FFF2".toColor(),
              borderRadius: BorderRadius.circular(20.w),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _titleWidget(),
              ],
            ),
          ),
          Flora121ImagesView(imagesName: "input1",width: 82.w,height: 82.w,),
        ],
      ),
      SizedBox(height: 28.h,),
      Flora121Click(
        onTap: (){
          baseCon.clickClose();
        },
        child: Flora121ImagesView(imagesName: "icon_close",width: 30.w,height: 30.w,),
      ),
    ],
  );

  _titleWidget()=>Container(
    width: double.infinity,
    height: 60.h,
    decoration: BoxDecoration(
      color: baseCon.getTitleColor(cashType).toColor(),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.w),
        topRight: Radius.circular(20.w),
      )
    ),
  );
}