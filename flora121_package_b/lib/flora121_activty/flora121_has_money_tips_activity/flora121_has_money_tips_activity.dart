import 'package:flora121_base/flora121_base/flora121_base_activity.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_b/flora121_activty/flora121_has_money_tips_activity/flora121_has_money_tips_con.dart';
import 'package:flora121_package_b/flora121_hep/flora121_storage/flora121_storage.dart';
import 'package:flora121_package_b/flora121_hep/flora121_value_utils.dart';
import 'package:flora121_package_b/flora_enum/flora121_cash_type.dart';
import 'package:flutter/material.dart';

class Flora121HasMoneyTipsActivity extends Flora121BaseActivity<Flora121HasMoneyTipsCon>{
  @override
  Flora121HasMoneyTipsCon initBaseConFlora121() => Flora121HasMoneyTipsCon();

  @override
  Widget initBaseWidgetFlora121() => Container(
    padding: EdgeInsets.only(left: 35.w,right: 35.w),
    color: "#FFFFFF".toColor(),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _topTextWidget(),
        SizedBox(height: 20.h,),
        _cashMoneyWidget(),
        SizedBox(height: 30.h,),
        _infoWidget(),
        SizedBox(height: 30.h,),
        Flora121Click(
          onTap: (){
            baseCon.clickClose();
          },
          child: Container(
            width: 242.w,
            height: 50.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: "#4C7D0A".toColor(),
              borderRadius: BorderRadius.circular(15.w),
            ),
            child: Flora121TextView(text: "Confirm", color: "#FFFFFF", size: 20.sp,fontWeight: FontWeight.bold,),
          ),
        ),
      ],
    ),
  );

  _infoWidget()=>Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      _infoItemWidget("Payout Platform","PlantFortune"),
      _infoItemWidget("Payout Instructions","Earnings withdrawal"),
      _infoItemWidget("Creation time",getTodayTimeStr()),
      _infoItemWidget("Estimated payment time",getTime3DaysStr()),
      _cashTypeWidget(),
    ],
  );

  _infoItemWidget(String title,String content)=>Container(
    padding: EdgeInsets.only(top: 10.h,bottom: 10.h),
    child: Row(
      children: [
        Flora121TextView(text: title, color: "#3D3D3D", size: 14.sp,fontWeight: FontWeight.w500,),
        Spacer(),
        Flora121TextView(text: content, color: "#000000", size: 14.sp,fontWeight: FontWeight.w900,),
      ],
    ),
  );

  _cashTypeWidget()=>Container(
    padding: EdgeInsets.only(top: 10.h,bottom: 10.h),
    child: Row(
      children: [
        Flora121TextView(text: "Payment method", color: "#3D3D3D", size: 14.sp,fontWeight: FontWeight.w500,),
        Spacer(),
        Flora121ImagesView(imagesName: bSelectCashType.getData()==Flora121CashType.paypal?"icon_paypal2":"icon_cashapp2",height: 30.h,fit: BoxFit.fitHeight,),
      ],
    ),
  );

  _cashMoneyWidget()=>Container(
    width: 236.w,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.w),
      color: "#FFFFFF".toColor(),
      boxShadow: [
        BoxShadow(
          color: "#000000".toColor().withOpacity(0.2),
          spreadRadius: 2,
          blurRadius: 5,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.infinity,
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: 2.h,bottom: 2.h),
          decoration: BoxDecoration(
            color: "#DC5C00".toColor(),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.w),
              topRight: Radius.circular(10.w),
            ),
          ),
          child: Flora121TextView(text: "Withdrawal amount", color: "#FFFFFF", size: 16.sp,fontWeight: FontWeight.w900,),
        ),
        Flora121TextView(text: "\$${baseCon.cashMoney}", color: "#000000", size: 40.sp,fontWeight: FontWeight.w900,),
        Flora121ImagesView(imagesName: "icon_hot",height: 26.h,fit: BoxFit.fitHeight,),
        SizedBox(height: 10.h,),
      ],
    ),
  );
  
  _topTextWidget()=>Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      //Please verify your
      // payout account!
      Flora121TextView(text: "Please verify your", color: "#000000", size: 30.sp,fontWeight: FontWeight.w900,),
      Flora121TextView(text: "Payout account!", color: "#FF0000", size: 30.sp,fontWeight: FontWeight.w900,),
    ],
  );
}