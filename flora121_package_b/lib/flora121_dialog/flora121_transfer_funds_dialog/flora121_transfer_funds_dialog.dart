import 'package:flora121_base/flora121_base/flora121_base_dialog.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_b/flora121_bean/flora121_cash_task_bean.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_transfer_funds_dialog/flora121_transfer_funds_dialog_con.dart';
import 'package:flora121_package_b/flora121_hep/flora121_hep.dart';
import 'package:flutter/material.dart';

class Flora121TransferFundsDialog extends Flora121BaseDialog<Flora121TransferFundsDialogCon>{
  Flora121CashTaskBean? bean;
  Function() dismissCallback;
   Flora121TransferFundsDialog({
    required this.bean,
    required this.dismissCallback,
});
  @override
  Flora121TransferFundsDialogCon initBaseConFlora121() => Flora121TransferFundsDialogCon(dismissCallback);

  @override
  Widget initBaseWidgetFlora121() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Flora121TextView(text: "Processing payment", color: "#FFFFFF", size: 20.sp,fontWeight: FontWeight.bold,),
      SizedBox(height: 30.h,),
      Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Flora121ImagesView(imagesName: getCashTypeMoneyBg(bean?.cashType),width: 164.w,height: 74.h,),
          Flora121TextView(text: "\$${bean?.cashMoney??0}", color: "#000000", size: 32.sp,fontWeight: FontWeight.bold,),
        ],
      ),
      SizedBox(height: 6.h,),
      GetBuilder<Flora121TransferFundsDialogCon>(
        id: "icon",
        builder: (_){
          if(baseCon.showFail){
            return Container(
              width: 115.w,
              height: 115.h,
              alignment: Alignment.center,
              child: Flora121ImagesView(imagesName: "task_tips3",width: 50.w,height: 50.h,),
            );
          }
          return Flora121ImagesView(imagesName: "task_tips1",width: 115.w,height: 115.h,);
        },
      ),
      Flora121Click(onTap: (){Flora121RoutersHep.back();},child: Flora121ImagesView(imagesName: "task_tips2",width: 140.w,height: 140.h,)),
      GetBuilder<Flora121TransferFundsDialogCon>(
        id: "bottom_text",
        builder: (_)=>Visibility(
          visible: baseCon.showFail,
          maintainAnimation: true,
          maintainState: true,
          maintainSize: true,
          child: Flora121TextView(text: "The bank requires you to\nverify that you are not a robot", color: "#EAECCC", size: 20.sp,fontWeight: FontWeight.bold,),
        ),
      )
    ],
  );
}