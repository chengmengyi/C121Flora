import 'package:flora121_base/flora121_base/flora121_base_dialog.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_input_phone_dialog/flora121_input_phone_dialog_con.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_input_pix_dialog/flora121_input_pix_dialog_con.dart';
import 'package:flora121_package_b/flora121_hep/flora121_hep.dart';
import 'package:flutter/material.dart';

class Flora121InputPixDialog extends Flora121BaseDialog<Flora121InputPixDialogCon>{
  Function(String account) sureCallback;

  Flora121InputPixDialog({
    required this.sureCallback,
  });

  @override
  Flora121InputPixDialogCon initBaseConFlora121() => Flora121InputPixDialogCon();

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
                _cpfWidget(),
                _nameWidget(),
                _accountTypeWidget(),
                _accountWidget(),
                SizedBox(height: 28.h,),
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
      Flora121TextView(text: "Direct to Your pix • Instant Payment", color: "#727463", size: 10.sp,fontWeight: FontWeight.bold,),
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

  _cpfWidget()=>Container(
    width: double.infinity,
    height: 30.h,
    margin: EdgeInsets.only(left: 16.w,right: 16.w,top: 16.h),
    padding: EdgeInsets.only(left: 16.w,right: 16.w),
    decoration: BoxDecoration(
      color: "#FFFFFF".toColor(),
      borderRadius: BorderRadius.circular(30.w),
    ),
    child: Row(
      children: [
        Flora121TextView(text: "CPF", color: "#414712", size: 14.sp,fontWeight: FontWeight.bold,),
        Expanded(
          child: TextField(
            enabled: true,
            maxLength: 11,
            textAlign: TextAlign.right,
            controller: baseCon.cpfTextEditingController,
            textInputAction: TextInputAction.done,
            style: TextStyle(
              fontSize: 10.sp,
              color: "#4C7D0A".toColor(),
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              counterText: '',
              isCollapsed: true,
              hintText: "e.g. 99999999999",
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

  _nameWidget()=>Container(
    width: double.infinity,
    height: 30.h,
    margin: EdgeInsets.only(left: 16.w,right: 16.w,top: 16.h),
    padding: EdgeInsets.only(left: 16.w,right: 16.w),
    decoration: BoxDecoration(
      color: "#FFFFFF".toColor(),
      borderRadius: BorderRadius.circular(30.w),
    ),
    child: Row(
      children: [
        Flora121TextView(text: "Name", color: "#414712", size: 14.sp,fontWeight: FontWeight.bold,),
        Expanded(
          child: TextField(
            enabled: true,
            maxLength: 20,
            textAlign: TextAlign.right,
            controller: baseCon.nameTextEditingController,
            textInputAction: TextInputAction.done,
            style: TextStyle(
              fontSize: 10.sp,
              color: "#4C7D0A".toColor(),
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              counterText: '',
              isCollapsed: true,
              hintText: "Please input full name",
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

  _accountTypeWidget()=>Container(
    width: double.infinity,
    margin: EdgeInsets.only(left: 16.w,right: 16.w,top: 16.h),
    padding: EdgeInsets.only(left: 16.w,right: 16.w,top: 5.h,bottom: 5.h),
    decoration: BoxDecoration(
      color: "#FFFFFF".toColor(),
      borderRadius: BorderRadius.circular(30.w),
    ),
    child: Row(
      children: [
        Flora121TextView(text: "Account Type", color: "#414712", size: 14.sp,fontWeight: FontWeight.bold,),
        SizedBox(width: 30.w,),
        Expanded(
          child: GetBuilder<Flora121InputPixDialogCon>(
            id: "cash_type",
            builder: (_)=>MasonryGridView.count(
              padding: const EdgeInsets.all(0),
              itemCount: baseCon.cashTypeList.length,
              shrinkWrap: true,
              crossAxisCount: 2,
              mainAxisSpacing: 4.h,
              crossAxisSpacing: 4.w,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context,index){
                var s = baseCon.cashTypeList[index];
                var selected = baseCon.selectCashType==s;
                return Flora121Click(
                  onTap: (){
                    baseCon.clickCashTypeItem(s);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 20.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.w),
                      color: selected?"#77962E".toColor():"#E4E9DD".toColor(),
                    ),
                    child: Flora121TextView(text: s, color: selected?"#FFFFFF":"#748262", size: 10.sp),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    ),
  );

  _accountWidget()=>Container(
    width: double.infinity,
    height: 30.h,
    margin: EdgeInsets.only(left: 16.w,right: 16.w,top: 16.h),
    padding: EdgeInsets.only(left: 16.w,right: 16.w),
    decoration: BoxDecoration(
      color: "#FFFFFF".toColor(),
      borderRadius: BorderRadius.circular(30.w),
    ),
    child: GetBuilder<Flora121InputPixDialogCon>(
      id: "account",
      builder: (_)=>Row(
        children: [
          Flora121TextView(text: baseCon.selectCashType, color: "#414712", size: 14.sp,fontWeight: FontWeight.bold,),
          Expanded(
            child: TextField(
              enabled: true,
              maxLength: 36,
              textAlign: TextAlign.right,
              controller: baseCon.accountTextEditingController,
              textInputAction: TextInputAction.done,
              style: TextStyle(
                fontSize: 10.sp,
                color: "#4C7D0A".toColor(),
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                counterText: '',
                isCollapsed: true,
                hintText: baseCon.getAccountTipsStr(),
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
    ),
  );

  _titleWidget()=>Container(
    width: double.infinity,
    height: 60.h,
    alignment: Alignment.centerLeft,
    padding: EdgeInsets.only(left: 20.w),
    decoration: BoxDecoration(
      color: "#11A594".toColor(),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.w),
        topRight: Radius.circular(20.w),
      )
    ),
    child: Flora121ImagesView(imagesName: "icon_pix",height: 45.h,fit: BoxFit.fitHeight,),
  );
}