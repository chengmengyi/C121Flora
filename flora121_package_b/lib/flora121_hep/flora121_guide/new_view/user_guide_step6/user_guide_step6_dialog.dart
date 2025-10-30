import 'package:flora121_base/flora121_base/flora121_base_dialog.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_b/flora121_hep/flora121_cash_task_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_guide/new_view/user_guide_step6/user_guide_step6_con.dart';
import 'package:flora121_package_b/flora121_view/flora121_user_guide_head_widget.dart';
import 'package:flora121_package_b/flora_enum/flora121_cash_type.dart';
import 'package:flutter/material.dart';

class UserGuideStep6Dialog extends Flora121BaseDialog<UserGuideStep6Con>{
  Function() dismissCallback;
  UserGuideStep6Dialog({
    required this.dismissCallback,
});
  @override
  UserGuideStep6Con initBaseConFlora121() => UserGuideStep6Con();

  @override
  Widget initBaseWidgetFlora121() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        margin: EdgeInsets.only(left: 34.w,right: 34.w),
        decoration: BoxDecoration(
          color: "#F9FFF2".toColor(),
          borderRadius: BorderRadius.circular(20.w),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flora121TextView(text: "Withdrawal Method", color: "#7A5040", size: 16.sp,fontWeight: FontWeight.bold,),
            SizedBox(height: 8.h,),
            _cashTypeListWidget(),
            SizedBox(height: 16.h,),
            _accountWidget(),
            SizedBox(height: 16.h,),
            Flora121TextView(text: "Direct to Your paypal Instant Payment", color: "#727463", size: 12.sp),
            SizedBox(height: 9.h,),
            Flora121Click(
              onTap: (){
                baseCon.clickSubmit(dismissCallback);
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
                child: Flora121TextView(text: "Submit", color: "#FFFFFF", size: 16.sp,fontWeight: FontWeight.bold,),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 40.h,),
      Flora121UserGuideHeadWidget(content: "Quick pick: Cash out & keep supporting the Earth"),
    ],
  );

  _cashTypeListWidget()=>GetBuilder<UserGuideStep6Con>(
    id: "list",
    builder: (_){
      var cashTypeList = Flora121CashTaskUtils.instance.getCashTypeList();
      return ListView.builder(
        shrinkWrap: true,
        itemCount: cashTypeList.length,
        itemBuilder: (context,index)=>_cashTypeItemWidget(cashTypeList[index]),
      );
    },
  );

  _cashTypeItemWidget(String type)=>Flora121Click(
    onTap: (){
      baseCon.clickCashType(type);
    },
    child: Container(
      margin: EdgeInsets.only(top: 8.h,bottom: 8.h),
      child: Stack(
        children: [
          Flora121ImagesView(imagesName: type==Flora121CashType.paypal?"guide7":"guide8",width: double.infinity,height: 64.h,),
          Visibility(
            visible: type==baseCon.selectCashType,
            child: Container(
              width: double.infinity,
              height: 64.h,
              alignment: Alignment.topRight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.w),
                border: Border.all(
                  width: 3.w,
                  color: "#FFBD09".toColor(),
                )
              ),
              child: Flora121ImagesView(imagesName: "guide9",width: 20.w,height: 20.w,),
            ),
          ),
        ],
      ),
    ),
  );

  _accountWidget()=>Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Flora121TextView(text: "Account/Phone", color: "#414712", size: 14.sp,),
      SizedBox(height: 3.h,),
      Container(
        width: double.infinity,
        height: 45.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: "#E8EFDE".toColor(),
          borderRadius: BorderRadius.circular(34.w),
        ),
        child: GetBuilder<UserGuideStep6Con>(
          id: "input",
          builder: (_)=>TextField(
            enabled: true,
            textAlign: TextAlign.center,
            controller: baseCon.textEditingController,
            textInputAction: TextInputAction.done,
            style: TextStyle(
              fontSize: 14.sp,
              color: "#4C7D0A".toColor(),
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              counterText: '',
              isCollapsed: true,
              hintText: baseCon.getInputTipsStr(),
              hintStyle: TextStyle(
                fontSize: 14.sp,
                color: "#748262".toColor(),
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    ],
  );
}