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
    child: GetBuilder<Flora121CashCon>(
      id: "page",
      builder: (_){
        if(null==baseCon.flora121cashRankBean){
          return SingleChildScrollView(
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
          );
        }
        return _rankWidget();
      },
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
            var currentMoneyHasCashTask = baseCon.currentMoneyHasCashTask(bean.money);
            return Flora121Click(
              onTap: (){
                baseCon.clickAmountItem(index);
              },
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 102.h,
                    margin: EdgeInsets.only(top: 4.h),
                    key: index==0?baseCon.firstCashAmountGlobalKey:null,
                    decoration: BoxDecoration(
                      color: baseCon.getAmountItemBgColor().toColor(),
                      borderRadius: BorderRadius.circular(16.w),
                      border: currentMoneyHasCashTask?
                      null:
                      isSelect?
                      Border.all(
                        width: 2.w,
                        color: baseCon.getBorderItemBgColor().toColor(),
                      ):null,
                    ),
                    child: Stack(
                      children: [
                        Visibility(
                          visible: currentMoneyHasCashTask,
                          child: Flora121ImagesView(imagesName: "cash1",width: double.infinity,height: double.infinity,),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Visibility(
                            visible: isSelect&&!currentMoneyHasCashTask,
                            child: Flora121ImagesView(imagesName: baseCon.getGouIcon(),width: 20.w,height: 20.w,),
                          ),
                        ),
                        Align(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flora121TextView(text: "\$${bean.money}", color: "#313831", size: 24.sp,fontWeight: FontWeight.bold,),
                              SizedBox(height: 2.h,),
                              Flora121ImagesView(imagesName: baseCon.getMoneyTag(bean.money),width: 94.w,height: 29.h,),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: currentMoneyHasCashTask,
                    child: Container(
                      padding: EdgeInsets.only(left: 12.w,right: 12.w,top: 2.h,bottom: 2.h,),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.w),
                          bottomRight: Radius.circular(16.w),
                        ),
                        gradient: LinearGradient(
                            colors: ["#04B40A".toColor(),"#087522".toColor()]
                        ),
                      ),
                      child: Flora121TextView(text: "processing", color: "#FFFFFF", size: 12.sp,fontWeight: FontWeight.bold,),
                    ),
                  )
                ],
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
      Flora121CashTaskUtils.instance.showCashTaskDialog(baseCon.taskBean);
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
          Flora121TextView(text: baseCon.getTitleStr(), color: "#313831", size: 14.sp,fontWeight: FontWeight.bold,),
          Flora121TextView(text: baseCon.getDescStr(), color: "#738473", size: 12.sp),
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
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            margin: EdgeInsets.only(right: 6.w),
            child: Visibility(
              visible: Flora121CashTaskUtils.instance.showTaskCompletedIcon(task1, currentList),
              child: Flora121ImagesView(imagesName: "icon_gou4",width: 52.w,height: 52.w,),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Column(
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
        ),
      ],
    ),
  );

  _cashInstructionsWidget(int money)=>Container(
    width: double.infinity,
    padding: EdgeInsets.all(12.w),
    decoration: BoxDecoration(
      color: baseCon.getInsBgColor().toColor(),
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

  _cashBtnWidget()=>GetBuilder<Flora121CashCon>(
    id: "btn",
    builder: (_)=>Flora121Click(
      onTap: (){
        baseCon.clickCash();
      },
      child: Container(
        width: double.infinity,
        height: 48.h,
        key: baseCon.cashBtnGlobalKey,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: baseCon.getBtnColor().toColor(),
          borderRadius: BorderRadius.circular(100.w),
        ),
        child: Flora121TextView(text: "Withdraw", color: "#FFFFFF", size: 16.sp,fontWeight: FontWeight.bold,),
      ),
    ),
  );

  _rankWidget()=>Container(
    width: double.infinity,
    margin: EdgeInsets.only(left: 18.w,right: 18.w,top: 160.h),
    child: Column(
      children: [
        _rankCashNumWidget(),
        SizedBox(height: 12.h,),
        _rankListWidget(),
        SizedBox(height: 4.h,),
        _skipWaitBtnWidget(),
        SizedBox(height: 80.h,),
      ],
    ),
  );

  _rankListWidget()=>Expanded(
    child: Column(
      children: [
        GetBuilder<Flora121CashCon>(
          id: "rank_text",
          builder: (_)=>RichText(
            text: TextSpan(
                children: [
                  TextSpan(
                    text: "${baseCon.flora121cashRankBean?.totalProgress??0}",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: "#1A9A3C".toColor(),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: " in queue，Your Current rank ",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: "#57698C".toColor(),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: "${baseCon.flora121cashRankBean?.currentProgress??0}",
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: "#E67A0D".toColor(),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]
            ),
          ),
        ),
        SizedBox(height: 8.h,),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.w),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: "#D9E7F2".toColor(),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 35.h,
                    child: Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Flora121TextView(text: "Queue", color: "#244768", size: 12.sp,fontWeight: FontWeight.bold,),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Flora121TextView(text: "Account", color: "#244768", size: 12.sp,fontWeight: FontWeight.bold,),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Flora121TextView(text: "Amount", color: "#244768", size: 12.sp,fontWeight: FontWeight.bold,),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      removeBottom: true,
                      child: GetBuilder<Flora121CashCon>(
                        id: "rank_list",
                        builder: (_)=>ListView.builder(
                          itemCount: baseCon.rankList.length,
                          controller: baseCon.scrollController,
                          itemBuilder: (context,index){
                            var bean = baseCon.rankList[index];
                            var textColor = bean.isMe?"#CD0707":"#24292D";
                            return Container(
                              width: double.infinity,
                              height: 36.h,
                              color: index%2==0?"#F0F9FF".toColor():null,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: Flora121TextView(text: baseCon.getQueueID(index), color: textColor, size: 14.sp,fontWeight: FontWeight.bold,),
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Flora121TextView(text: bean.account, color: textColor, size: 14.sp,fontWeight: FontWeight.bold,),
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Flora121TextView(text: "\$${bean.amount}", color: textColor, size: 14.sp,fontWeight: FontWeight.bold,),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );

  _skipWaitBtnWidget()=>Flora121Click(
    onTap: (){
      baseCon.clickSkipWait();
    },
    child: SizedBox(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            width: double.infinity,
            height: 48.h,
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 16.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.w),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: ["#FF0000".toColor(),"#FF8104".toColor(),]
              ),
            ),
            child: Flora121TextView(text: "Skip Wait", color: "#FFFFFF", size: 20.sp,outlineColor: "#000000",fontWeight: FontWeight.bold,),
          ),
          Flora121ImagesView(imagesName: "icon_video",width: 42.w,height: 42.h,),
        ],
      ),
    ),
  );

  _rankCashNumWidget()=>Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Flora121TextView(text: "Withdrawal amount", color: "#243824", size: 14.sp,fontWeight: FontWeight.bold,),
      SizedBox(height: 12.h,),
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: "#E1E1E1".toColor(),
          borderRadius: BorderRadius.circular(14.w),
        ),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 6.w,top: 6.h,bottom: 10.h,),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Flora121ImagesView(imagesName: "cash2",width: 105.w,height: 107.h,),
                  Container(
                    margin: EdgeInsets.only(bottom: 14.h,),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flora121TextView(text: "\$${baseCon.flora121cashRankBean?.cashMoney??0}", color: "#313831", size: 24.sp,fontWeight: FontWeight.bold,),
                        Flora121ImagesView(imagesName: "icon_hot",width: 95.w,height: 29.h,),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 14.w,),
            Expanded(
              child: RichText(
                text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Congratulations! You’ve entered the withdrawal review queue. You can tap ",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: "#000000".toColor(),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: "“Skip Wait”",
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: "#CD0707".toColor(),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: " to speed up the review process.",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: "#000000".toColor(),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}