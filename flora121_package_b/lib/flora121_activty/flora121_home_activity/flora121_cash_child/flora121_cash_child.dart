import 'package:flora121_base/flora121_base/flora121_base_child.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_b/flora121_activty/flora121_home_activity/flora121_cash_child/flora121_cash_con.dart';
import 'package:flora121_package_b/flora121_hep/flora121_value_utils.dart';
import 'package:flutter/material.dart';

class Flora121CashChild extends Flora121BaseChild<Flora121CashCon>{
  @override
  Flora121CashCon initBaseConFlora121() => Flora121CashCon();

  @override
  Widget initBaseWidgetFlora121() => Container(
    width: double.infinity,
    height: double.infinity,
    color: "#FFFFFF".toColor(),
    child: SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(left: 18.w,right: 18.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 160.h,),
            _cashAmountWidget(),
            SizedBox(height: 12.h,),
            _cashRecordListWidget(),
            SizedBox(height: 12.h,),
            _cashInstructionsWidget(),
            SizedBox(height: 20.h,),
            _cashBtnWidget(),
          ],
        ),
      ),
    ),
  );

  _cashAmountWidget()=>Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Flora121TextView(text: "Withdrawal amount", color: "#243824", size: 14.sp,fontWeight: FontWeight.bold,),
      SizedBox(height: 12.h,),
      MasonryGridView.count(
        padding: const EdgeInsets.all(0),
        itemCount: Flora121ValueUtils.instance.getCashList().length,
        shrinkWrap: true,
        crossAxisCount: 3,
        mainAxisSpacing: 12.h,
        crossAxisSpacing: 12.w,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context,index){
          var isSelect = baseCon.chooseIndex==index;
          var money = Flora121ValueUtils.instance.getCashList()[index];
          return Container(
            width: double.infinity,
            height: 66.h,
            key: index==0?baseCon.firstCashAmountGlobalKey:null,
            decoration: BoxDecoration(
              color: "#E6F8FF".toColor(),
              borderRadius: BorderRadius.circular(16.w),
              border: isSelect?
              Border.all(
                width: 2.w,
                color: "#4179B9".toColor(),
              ):null,
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Visibility(
                    visible: isSelect,
                    child: Flora121ImagesView(imagesName: "icon_gou2",width: 20.w,height: 20.w,),
                  ),
                ),
                Align(
                  child: Flora121TextView(text: "\$$money", color: "#313831", size: 16.sp,fontWeight: FontWeight.bold,),
                ),
              ],
            ),
          );
        },
      ),
    ],
  );

  _cashRecordListWidget()=>GetBuilder<Flora121CashCon>(
    id: "marquee",
    builder: (_)=>Column(
      mainAxisSize: MainAxisSize.min,
      children: baseCon.marqueeList.map((value){
        return SizedBox(
          height: 30.h,
          child: Marqueer(
            pps: 100,
            interaction: false,
            controller: MarqueerController(),
            direction: MarqueerDirection.rtl,
            restartAfterInteractionDuration: const Duration(seconds: 6),
            restartAfterInteraction: false,
            onChangeItemInViewPort: (index) {
            },
            onInteraction: () {
            },
            onStarted: () {
            },
            onStopped: () {
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: value,
            ),
          ),
        );

      }).toList(),
    ),
  );

  _cashInstructionsWidget()=>Container(
    width: double.infinity,
    padding: EdgeInsets.all(12.w),
    decoration: BoxDecoration(
      color: "#E2F9F2".toColor(),
      borderRadius: BorderRadius.circular(10.w),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flora121TextView(text: "Withdrawal Instructions", color: "#313831", size: 14.sp,fontWeight: FontWeight.bold,),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "· For security, the minimum withdrawal is ",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: "#738473".toColor(),
                  fontWeight: FontWeight.bold
                ),
              ),
              TextSpan(
                text: "${Flora121ValueUtils.instance.getCashList().first}",
                style: TextStyle(
                    fontSize: 12.sp,
                    color: "#EBA100".toColor(),
                    fontWeight: FontWeight.bold
                ),
              ),
              TextSpan(
                text: ".",
                style: TextStyle(
                    fontSize: 12.sp,
                    color: "#738473".toColor(),
                    fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h,),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: "#FFFFFF".toColor(),
            borderRadius: BorderRadius.circular(10.w),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    //XX more needed to withdraw XX.
                    TextSpan(
                      text: "\$${baseCon.getCashLeft()}",
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: "#38980B".toColor(),
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    TextSpan(
                      text: " more needed to withdraw ",
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: "#313831".toColor(),
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    TextSpan(
                      text: "\$${Flora121ValueUtils.instance.getCashList().first}",
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: "#EB176C".toColor(),
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    TextSpan(
                      text: ".",
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: "#313831".toColor(),
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  LayoutBuilder(
                    builder: (context,bc){
                      var maxWidth = bc.maxWidth;
                      return Container(
                        width: double.infinity,
                        height: 10.h,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: "#0F6259".toColor(),
                          borderRadius: BorderRadius.circular(20.w),
                        ),
                        child: Container(
                          width: maxWidth*baseCon.getCashLeftProgress(),
                          decoration: BoxDecoration(
                            color: "#FFA600".toColor(),
                            borderRadius: BorderRadius.circular(20.w),
                          ),
                        ),
                      );
                    },
                  ),
                  Flora121ImagesView(imagesName: "icon_money2",width: 40.w,height: 40.w,)
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );

  _cashBtnWidget()=>Flora121Click(
    onTap: (){
      baseCon.clickCash();
    },
    child: Container(
      width: double.infinity,
      height: 48.h,
      key: baseCon.cashBtnGlobalKey,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: "#1363AE".toColor(),
        borderRadius: BorderRadius.circular(100.w),
      ),
      child: Flora121TextView(text: "Withdraw", color: "#FFFFFF", size: 16.sp,fontWeight: FontWeight.bold,),
    ),
  );
}