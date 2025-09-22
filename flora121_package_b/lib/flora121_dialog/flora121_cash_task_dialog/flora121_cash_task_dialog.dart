import 'package:flora121_base/flora121_base/flora121_base_dialog.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_b/flora121_bean/flora121_cash_task_bean.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_cash_task_dialog/flora121_cash_task_dialog_con.dart';
import 'package:flora121_package_b/flora121_hep/flora121_cash_task_utils.dart';
import 'package:flutter/material.dart';

class Flora121CashTaskDialog extends Flora121BaseDialog<Flora121CashTaskDialogCon>{
  Flora121CashTaskBean? taskBean;
  Flora121CashTaskDialog({
    required this.taskBean,
});

  @override
  Flora121CashTaskDialogCon initBaseConFlora121() => Flora121CashTaskDialogCon();

  @override
  Widget initBaseWidgetFlora121() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: double.infinity,
        height: 500.h,
        padding: EdgeInsets.all(16.w),
        margin: EdgeInsets.only(left: 34.w,right: 34.w),
        decoration: BoxDecoration(
          color: "#F9FFF1".toColor(),
          borderRadius: BorderRadius.circular(20.w),
        ),
        child: Column(
          children: [
            _titleWidget(),
            SizedBox(height: 16.h,),
            _cashTaskListWidget(),
            SizedBox(height: 16.h,),
            _cashRecordWidget(),
            SizedBox(height: 16.h,),
            _btnWidget(),
          ],
        ),
      ),
      SizedBox(height: 32.h,),
      Flora121Click(
        onTap: (){
          baseCon.clickClose();
        },
        child: Flora121ImagesView(imagesName: "icon_close",width: 30.w,height: 30.w,),
      ),
    ],
  );

  _cashTaskListWidget(){
    var totalList = Flora121CashTaskUtils.instance.getCashTaskTotalList(taskBean);
    var currentList = Flora121CashTaskUtils.instance.getCashTaskCurrentList(taskBean);
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        maxHeight: 94.h,
        minHeight: 51.h,
      ),
      child: ListView.builder(
        itemCount: totalList.length,
        shrinkWrap: true,
        itemBuilder: (context,index){
          var task = totalList[index];
          return Container(
            width: double.infinity,
            height: 43.h,
            margin: EdgeInsets.only(bottom: 8.h),
            padding: EdgeInsets.only(left: 20.w,right: 20.w),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: "#EFF3CD".toColor(),
              borderRadius: BorderRadius.circular(10.w),
            ),
            child: Row(
              children: [
                Flora121ImagesView(imagesName: Flora121CashTaskUtils.instance.getCashTaskIcon(task),height: 35.h,fit: BoxFit.fitHeight,),
                SizedBox(width: 12.w,),
                Expanded(
                  child: Flora121TextView(text: Flora121CashTaskUtils.instance.getCashTaskTitleStr(task), color: "#113313", size: 10.sp,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis,),
                ),
                SizedBox(width: 12.w,),
                Flora121TextView(text: Flora121CashTaskUtils.instance.getCashTaskPro(task, currentList), color: "#DB6F2C", size: 10.sp,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis,),
              ],
            ),
          );
        },
      ),
    );
  }
  
  _cashRecordWidget()=>Expanded(
    child: Column(
      children: [
        Flora121TextView(text: "- Cash-out Showcase -", color: "#D89402", size: 14.sp,fontWeight: FontWeight.bold,),
        SizedBox(height: 2.h,),
        Expanded(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: "#EDEFDC".toColor(),
              borderRadius: BorderRadius.circular(15.w),
            ),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 32.h,
                  child: Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Flora121TextView(text: "Date", color: "#2A6824", size: 12.sp,fontWeight: FontWeight.bold,),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Flora121TextView(text: "UserID", color: "#2A6824", size: 12.sp,fontWeight: FontWeight.bold,),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Flora121TextView(text: "Amount", color: "#2A6824", size: 12.sp,fontWeight: FontWeight.bold,),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: baseCon.recordList.length,
                    controller: baseCon.scrollController,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context,index){
                      var bean = baseCon.recordList[index];
                      return Container(
                        width: double.infinity,
                        height: 23.h,
                        alignment: Alignment.centerLeft,
                        color: index%2==0?"#F9FFF1".toColor():"#EDEFDC".toColor(),
                        child: Row(
                          children: [
                            Expanded(
                              child: Center(
                                child: Flora121TextView(text: bean.date, color: "#4A5748", size: 10.sp,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis,),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Flora121TextView(text: baseCon.userIdAddStar(bean.account), color: "#4A5748", size: 10.sp,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis,),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Flora121TextView(text: "\$${bean.money}", color: "#4A5748", size: 10.sp,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis,),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );

  _btnWidget()=>Flora121Click(
    onTap: (){
      baseCon.clickClose();
    },
    child: Container(
      width: double.infinity,
      height: 50.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: "#FBAC00".toColor(),
        borderRadius: BorderRadius.circular(15.w),
      ),
      child: Flora121TextView(text: "Complete", color: "#FFFFFF", size: 16.sp,fontWeight: FontWeight.bold,),
    ),
  );

  _titleWidget()=>Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Flora121TextView(text: baseCon.getTitleStr(taskBean), color: "#113313", size: 16.sp,fontWeight: FontWeight.bold,),
      SizedBox(height: 12.h,),
      Flora121TextView(text: baseCon.getDescStr(taskBean), color: "#4C7D0A", size: 12.sp,fontWeight: FontWeight.bold,textAlign: TextAlign.center,)
    ],
  );
}