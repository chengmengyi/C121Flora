import 'package:flora121_base/flora121_base/flora121_base_dialog.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_money_15_80_tips_dialog/flora121_money_15_80_tips_dialog_con.dart';
import 'package:flora121_package_b/flora121_hep/flora121_storage/flora121_storage.dart';
import 'package:flora121_package_b/flora121_hep/flora121_value_utils.dart';
import 'package:flora121_package_b/flora121_view/flora121_cash_record_view.dart';
import 'package:flutter/material.dart';

class Flora121Money1580TipsDialog extends Flora121BaseDialog<Flora121Money1580TipsDialogCon>{
  @override
  Flora121Money1580TipsDialogCon initBaseConFlora121() => Flora121Money1580TipsDialogCon();

  @override
  Widget initBaseWidgetFlora121() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Flora121CashRecordView(),
      SizedBox(height: 50.h,),
      _centerContentWidget(),
      SizedBox(height: 40.h,),
      _bottomContentWidget(),
    ],
  );

  _centerContentWidget()=>Container(
    width: double.infinity,
    padding: EdgeInsets.all(4.w),
    margin: EdgeInsets.only(left: 44.w,right: 44.w),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: ["#12B450".toColor(),"#A1B928".toColor(),],
      ),
      borderRadius: BorderRadius.circular(16.w),
    ),
    child: Container(
      width: double.infinity,
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: "#FFFFFF".toColor(),
        borderRadius: BorderRadius.circular(16.w),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flora121TextView(text: "Almost there! ", color: "#FF0000", size: 24.sp,fontWeight: FontWeight.bold,),
          RichText(
            text: TextSpan(
              children: [
                //Your withdrawal progress is
                // ahead of 98% of users!
                TextSpan(
                  text: "Your withdrawal progress is ahead of ",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: "#000000".toColor(),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: "98%",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: "#2B821E".toColor(),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: " of users!",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: "#000000".toColor(),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h,),
          Container(
            width: 162.w,
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
                    color: "#2B821E".toColor(),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.w),
                      topRight: Radius.circular(10.w),
                    ),
                  ),
                  child: Flora121TextView(text: "Current earnings", color: "#FFFFFF", size: 16.sp,fontWeight: FontWeight.w900,),
                ),
                Flora121TextView(text: "\$${bMyMoneyNum.getData()}", color: "#000000", size: 40.sp,fontWeight: FontWeight.w900,),
              ],
            ),
          ),
          SizedBox(height: 16.h,),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flora121ImagesView(imagesName: "icon_sel2",width: 18.w,height: 18.w,),
                  SizedBox(width: 10.w,),
                  Flora121TextView(text: "Submit payment information", color: "#324631", size: 14.sp,fontWeight: FontWeight.bold,),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flora121ImagesView(imagesName: "icon_uns2",width: 18.w,height: 18.w,),
                  SizedBox(width: 10.w,),
                  Flora121TextView(text: "Just \$${Flora121ValueUtils.instance.getCashLeftMoney()} away from payout!", color: "#FF5500", size: 14.sp,fontWeight: FontWeight.bold,),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flora121ImagesView(imagesName: "icon_uns2",width: 18.w,height: 18.w,),
                  SizedBox(width: 10.w,),
                  Flora121TextView(text: "Revenue received", color: "#324631", size: 14.sp,fontWeight: FontWeight.bold,),
                ],
              ),
            ],
          ),
          SizedBox(height: 12.h,),
          Flora121Click(
            onTap: (){
              baseCon.clickToDice();
            },
            child: Flora121ImagesView(imagesName: "guide12",width: double.infinity,fit: BoxFit.fitWidth,),
          ),
        ],
      ),
    ),
  );

  _bottomContentWidget()=>Container(
    width: double.infinity,
    height: 110.h,
    margin: EdgeInsets.only(left: 20.w,right: 20.w),
    child: Stack(
      children: [
        Flora121ImagesView(imagesName: "guide13",width: double.infinity,height: double.infinity,),
        Container(
          margin: EdgeInsets.only(left: 16.w,right: 16.w,top: 6.h,),
          child: Row(
            children: [
              Flora121ImagesView(imagesName: "icon_cashapp2",height: 30.h,fit: BoxFit.fitHeight,),
              Spacer(),
              Flora121Click(
                onTap: (){
                  baseCon.clickCash();
                },
                child: Container(
                  width: 130.w,
                  height: 32.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: "#2B821E".toColor(),
                    borderRadius: BorderRadius.circular(25.w),
                  ),
                  child: Flora121TextView(text: "Cash Out", color: "#FFFFFF", size: 16.sp,fontWeight: FontWeight.bold,),
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            height: 52.h,
            margin: EdgeInsets.only(left: 12.w,right: 12.w,bottom: 10.h,),
            decoration: BoxDecoration(
              color: "#FFFFFF".toColor(),
              borderRadius: BorderRadius.circular(10.w),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 8.h,
                  left: 8.w,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        //Accumulate $1000 to cash out.
                        TextSpan(
                          text: "Accumulate ",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: "#313831".toColor(),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: "\$1000",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: "#2B821E".toColor(),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: " to cash out.",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: "#313831".toColor(),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.only(left: 8.w,right: 8.w),
                    child: Stack(
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
                                color: "#177225".toColor(),
                                borderRadius: BorderRadius.circular(12.w),
                              ),
                              child: Container(
                                width: maxWidth*baseCon.getPro(),
                                decoration: BoxDecoration(
                                  color: "#FFA600".toColor(),
                                  borderRadius: BorderRadius.circular(12.w),
                                ),
                              ),
                            );
                          },
                        ),
                        Flora121ImagesView(imagesName: "icon_money2",width: 40.w,height: 40.w,),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}