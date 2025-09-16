import 'package:flora121_base/flora121_base/flora121_base_dialog.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_input_phone_dialog/flora121_input_phone_dialog_con.dart';
import 'package:flora121_package_b/flora121_hep/flora121_hep.dart';
import 'package:flutter/material.dart';

class Flora121InputPhoneDialog extends Flora121BaseDialog<Flora121InputPhoneDialogCon>{
  String cashType;
  Function(String account) sureCallback;

  Flora121InputPhoneDialog({
    required this.cashType,
    required this.sureCallback,
  });

  @override
  Flora121InputPhoneDialogCon initBaseConFlora121() => Flora121InputPhoneDialogCon();

  @override
  Widget initBaseWidgetFlora121() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(left: 34.w,right: 34.w,top: 28.h),
            decoration: BoxDecoration(
              color: "#F9FFF2".toColor(),
              borderRadius: BorderRadius.circular(20.w),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _titleWidget(),
                _accountWidget(),
                SizedBox(height: 100.h,),
                _bottomWidget(),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 50.w),
            child: Flora121ImagesView(imagesName: "input1",width: 82.w,height: 82.w,),
          ),
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

  _bottomWidget()=>Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Flora121TextView(text: "Direct to Your $cashType • Instant Payment", color: "#727463", size: 10.sp,fontWeight: FontWeight.bold,),
      SizedBox(height: 16.h,),
      Flora121Click(
        onTap: (){
          baseCon.clickSure(sureCallback);
        },
        child: Container(
          width: double.infinity,
          height: 50.h,
          alignment: Alignment.center,
          margin: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: "#4C7D0A".toColor(),
            borderRadius: BorderRadius.circular(15.w),
          ),
          child: Flora121TextView(text: "Confirm", color: "#FFFFFF", size: 16.sp,fontWeight: FontWeight.bold,),
        ),
      ),
    ],
  );

  _accountWidget()=>Container(
    width: double.infinity,
    height: 30.h,
    margin: EdgeInsets.all(16.w),
    padding: EdgeInsets.only(left: 16.w,right: 16.w),
    decoration: BoxDecoration(
      color: "#FFFFFF".toColor(),
      borderRadius: BorderRadius.circular(30.w),
    ),
    child: Row(
      children: [
        Flora121TextView(text: "Account", color: "#414712", size: 14.sp,fontWeight: FontWeight.bold,),
        Expanded(
          child: TextField(
            enabled: true,
            maxLength: 10,
            textAlign: TextAlign.right,
            controller: baseCon.textEditingController,
            textInputAction: TextInputAction.done,
            style: TextStyle(
              fontSize: 10.sp,
              color: "#4C7D0A".toColor(),
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              counterText: '',
              isCollapsed: true,
              hintText: "e.g.5551234567",
              hintStyle: TextStyle(
                fontSize: 10.sp,
                color: "#748262".toColor(),
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    ),
  );

  _titleWidget()=>Container(
    width: double.infinity,
    height: 60.h,
    alignment: Alignment.centerLeft,
    padding: EdgeInsets.only(left: 20.w),
    decoration: BoxDecoration(
      color: baseCon.getTitleColor(cashType).toColor(),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.w),
        topRight: Radius.circular(20.w),
      )
    ),
    child: Flora121ImagesView(imagesName: getCashTypeIcon(cashType),height: 21.h,fit: BoxFit.fitHeight,),
  );
}