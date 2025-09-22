import 'package:flora121_base/flora121_base/flora121_base_child.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_b/flora121_activty/flora121_home_activity/flora121_cash_child/flora121_cash_con.dart';
import 'package:flora121_package_b/flora121_bean/flora121_cash_task_config_bean.dart';
import 'package:flora121_package_b/flora121_hep/flora121_cash_task_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_value_utils.dart';
import 'package:flora121_package_b/flora121_view/flora121_cash_record_view.dart';
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
            Flora121CashRecordView(),
            SizedBox(height: 12.h,),
            _cashTaskOrInstructionsWidget(),
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
      GetBuilder<Flora121CashCon>(
        id: "amount",
        builder: (_)=>MasonryGridView.count(
          padding: const EdgeInsets.all(0),
          itemCount: baseCon.amountList.length,
          shrinkWrap: true,
          crossAxisCount: 3,
          mainAxisSpacing: 12.h,
          crossAxisSpacing: 12.w,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context,index){
            var isSelect = baseCon.chooseIndex==index;
            var bean = baseCon.amountList[index];
            return Flora121Click(
              onTap: (){
                baseCon.clickAmountItem(index);
              },
              child: Container(
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
                      child: Flora121TextView(text: "\$${bean.money}", color: "#313831", size: 16.sp,fontWeight: FontWeight.bold,),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ],
  );

  _cashTaskOrInstructionsWidget()=>GetBuilder<Flora121CashCon>(
    id: "task",
    builder: (_){
      if(baseCon.amountList.isEmpty){
        return Container();
      }
      if(null==baseCon.taskBean){
        return _cashInstructionsWidget(baseCon.amountList[baseCon.chooseIndex].money);
      }
      return _cashTaskWidget();
    },
  );

  _cashTaskWidget()=>Flora121Click(
    onTap: (){
      baseCon.showCashTaskDialog();
    },
    child: Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: "#E6F8FF".toColor(),
        borderRadius: BorderRadius.circular(10.w),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flora121TextView(text: "Human Verification", color: "#313831", size: 14.sp,fontWeight: FontWeight.bold,),
          Flora121TextView(text: "Please complete human verification before withdrawing.", color: "#738473", size: 12.sp),
          SizedBox(height: 12.h,),
          LayoutBuilder(
            builder: (context,bc){
              var width = (bc.maxWidth-18.w)/2;
              var totalList = Flora121CashTaskUtils.instance.getCashTaskTotalList(baseCon.taskBean);
              var currentList = Flora121CashTaskUtils.instance.getCashTaskCurrentList(baseCon.taskBean);
              return SizedBox(
                width: double.infinity,
                height: 62.h,
                child: ListView.builder(
                  itemCount: totalList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index)=>_cashTaskItemWidget(width,totalList[index],currentList),
                ),
              );
            },
          ),
        ],
      ),
    ),
  );

  _cashTaskItemWidget(double width, Task1 task1, List<Task1> currentList)=>Container(
    width: width,
    height: 62.h,
    alignment: Alignment.center,
    margin: EdgeInsets.only(right: 18.w),
    decoration: BoxDecoration(
      color: "#FFFFFF".toColor(),
      borderRadius: BorderRadius.circular(10.w),
    ),
    child: Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flora121TextView(text: Flora121CashTaskUtils.instance.getCashTaskTitleStr(task1), color: "#313831", size: 10.sp,fontWeight: FontWeight.bold,),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flora121ImagesView(imagesName: Flora121CashTaskUtils.instance.getCashTaskIcon(task1),height: 35.h,fit: BoxFit.fitHeight,),
                SizedBox(width: 12.w,),
                Flora121TextView(text: Flora121CashTaskUtils.instance.getCashTaskPro(task1, currentList), color: "#DB6F2C", size: 10.sp,fontWeight: FontWeight.bold,),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  _cashInstructionsWidget(int money)=>Container(
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
                text: "\$$money",
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
                      text: "\$${baseCon.getCashLeft(money)}",
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
                      text: "\$$money",
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
                          width: maxWidth*baseCon.getCashLeftProgress(money),
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