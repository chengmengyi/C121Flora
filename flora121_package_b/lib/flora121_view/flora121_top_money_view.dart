import 'package:flora121_base/flora121_base/flora121_base_stateful.dart';
import 'package:flora121_base/flora121_hep/flora121_event/flora121_event_utils.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_change_cash_type_dialog/flora121_change_cash_type_dialog.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_set_dialog/flora121_set_dialog.dart';
import 'package:flora121_package_b/flora121_hep/flora121_event_code.dart';
import 'package:flora121_package_b/flora121_hep/flora121_hep.dart';
import 'package:flora121_package_b/flora121_hep/flora121_storage/flora121_storage.dart';
import 'package:flora121_package_b/flora121_hep/flora121_user_info_utils.dart';
import 'package:flora121_package_b/flora_enum/flora121_cash_type.dart';
import 'package:flutter/material.dart';

class Flora121TopMoneyView extends Flora121BaseStateful{
  @override
  State<StatefulWidget> createState() => _Flora121TopMoneyViewState();
}

class _Flora121TopMoneyViewState extends Flora121BaseStatefulState<Flora121TopMoneyView>{
  @override
  Widget initBaseWidgetFlora121() => Flora121Click(
    onTap: (){
      Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.showHomeTab,flora121IntValue: 3);
    },
    child: SizedBox(
      width: double.infinity,
      height: 148.h,
      child: Stack(
        children: [
          Flora121ImagesView(imagesName: _getBgImages(),width: double.infinity,height: double.infinity,),
          _bottomLeftWidget(),
          _bottomRightWidget(),
          _topRightWidget(),
          _topLeftWidget(),
        ],
      ),
    ),
  );

  _topLeftWidget(){
    var cashType = bSelectCashType.getData();
    return Positioned(
      top: 10.h,
      left: 20.w,
      child: SafeArea(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flora121ImagesView(imagesName: getCashTypeIcon(cashType),height: cashType==Flora121CashType.pix?45.h:21.h,fit: BoxFit.fitHeight,),
            SizedBox(width: 8.w,),
            Flora121Click(
              onTap: (){
                clickChangeCashType();
              },
              child: Flora121ImagesView(imagesName: "icon_change",width: 28.w,height: 28.w,),
            ),
          ],
        ),
      ),
    );
  }

  _topRightWidget()=>Positioned(
    top: 10.h,
    right: 20.w,
    child: SafeArea(
      child: Flora121Click(
        onTap: (){
          Flora121RoutersHep.dialog(child: Flora121SetDialog());
        },
        child: Flora121ImagesView(imagesName: "icon_set",width: 20.w,height: 20.w,),
      ),
    ),
  );
  
  _bottomRightWidget()=>Positioned(
    right: 20.w,
    bottom: 15.h,
    child: Container(
      padding: EdgeInsets.only(left: 20.w,right: 20.w,top: 2.h,bottom: 2.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.w),
        color: "#FFFFFF".toColor().withOpacity(0.3),
      ),
      child: Flora121TextView(text: "ID:${Flora121UserInfoUtils.instance.getUserInfo()?.userId??""}", color: "#FFFFFF", size: 10.sp),
    ),
  );

  _bottomLeftWidget()=>Positioned(
    left: 22.w,
    bottom: 5.h,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flora121TextView(text: "My Balance", color: "#FFFFFF", size: 10.sp,fontWeight: FontWeight.bold,),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flora121TextView(text: bMoneyStatusOpen.getData()?"\$${bMyMoneyNum.getData()}":"\$${getStar()}", color: "#FFFFFF", size: 28.sp,fontWeight: FontWeight.bold,),
            SizedBox(width: 10.w,),
            Flora121Click(
              onTap: (){
                clickSeeSwitch();
              },
              child: Flora121ImagesView(imagesName: bMoneyStatusOpen.getData()?"icon_see_open":"icon_see_close",width: 16.w,height: 10.h,),
            ),
          ],
        ),
      ],
    ),
  );

  clickSeeSwitch(){
    bMoneyStatusOpen.saveData(!bMoneyStatusOpen.getData());
    setState(() {});
  }

  String getStar(){
    var length = bMyMoneyNum.getData().toString().length;
    String result="";
    while(result.length<length){
      result+="*";
    }
    return result;
  }

  clickChangeCashType(){
    Flora121RoutersHep.dialog(
      child: Flora121ChangeCashTypeDialog(),
    );
  }

  String _getBgImages(){
    switch(bSelectCashType.getData()){
      case Flora121CashType.paypal: return "paypal_bg";
      case Flora121CashType.pagBank: return "pagbank_bg";
      case Flora121CashType.pix: return "pix_bg";
      case Flora121CashType.cashApp: return "cashapp_bg";
      default: return "paypal_bg";
    }
  }

  @override
  bool initFlora121Event() => true;

  @override
  receivedFlora121EventMsg(int flora121Code, int? flora121IntValue, String? flora121StringValue, Map? flora121Map) {
    switch(flora121Code){
      case Flora121EventCode.updateMyMoney:
      case Flora121EventCode.updateCashType:
        setState(() {});
        break;
    }
  }
}