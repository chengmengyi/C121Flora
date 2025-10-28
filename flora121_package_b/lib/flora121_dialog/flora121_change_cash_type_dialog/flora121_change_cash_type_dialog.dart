import 'package:flora121_base/flora121_base/flora121_base_dialog.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_change_cash_type_dialog/flora121_change_cash_type_dialog_con.dart';
import 'package:flora121_package_b/flora121_hep/flora121_cash_task_utils.dart';
import 'package:flutter/material.dart';

class Flora121ChangeCashTypeDialog extends Flora121BaseDialog<Flora121ChangeCashTypeDialogCon>{
  bool? fromNewUserGuide;
  Flora121ChangeCashTypeDialog({
    this.fromNewUserGuide,
  });

  @override
  onFlora121Init() {
    baseCon.fromNewUserGuide=fromNewUserGuide;
  }

  @override
  Flora121ChangeCashTypeDialogCon initBaseConFlora121() => Flora121ChangeCashTypeDialogCon();

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
            SizedBox(height: 28.h,),
            _cashTypeListWidget(),
            SizedBox(height: 28.h,),
            _btnWidget(),
          ],
        ),
      ),
      SizedBox(height: 28.h,),
      _closeWidget(),
    ],
  );

  _cashTypeListWidget()=> GetBuilder<Flora121ChangeCashTypeDialogCon>(
    id: "list",
    builder: (_){
      var cashTypeList = Flora121CashTaskUtils.instance.getCashTypeList();
      return MasonryGridView.count(
        padding: const EdgeInsets.all(0),
        itemCount: cashTypeList.length,
        shrinkWrap: true,
        crossAxisCount: 2,
        mainAxisSpacing: 12.h,
        crossAxisSpacing: 12.w,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context,index){
          var type = cashTypeList[index];
          var select = baseCon.cashType==type;
          return Flora121Click(
            onTap: (){
              baseCon.clickItem(type);
            },
            child: SizedBox(
              width: double.infinity,
              height: 64.h,
              key: index==0?baseCon.firstTypeGlobalKey:null,
              child: Stack(
                children: [
                  Flora121ImagesView(imagesName: baseCon.getImage(type),width: double.infinity,height: double.infinity,),
                  Align(
                    alignment: Alignment.topRight,
                    child: Visibility(
                      visible: select,
                      child: Flora121ImagesView(imagesName: "icon_gou3",width: 20.w,height: 20.w,),
                    ),
                  ),
                  Visibility(
                    visible: select,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.w),
                        border: Border.all(
                          width: 3.w,
                          color: "#FFBD09".toColor(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );

  _btnWidget()=>Flora121Click(
    onTap: (){
      baseCon.clickSubmit();
    },
    child: Container(
      width: double.infinity,
      height: 50.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: "#4C7D0A".toColor(),
        borderRadius: BorderRadius.circular(16.w),
      ),
      child: Flora121TextView(text: "Submit", color: "#FFFFFF", size: 16.sp,fontWeight: FontWeight.bold,),
    ),
  );
  
  _closeWidget()=>Flora121Click(
    onTap: (){
      baseCon.clickClose();
    },
    child: Flora121ImagesView(imagesName: "icon_close",width: 30.w,height: 30.w,),
  );
}