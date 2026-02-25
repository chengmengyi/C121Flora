import 'package:flora121_base/flora121_base/flora121_base_dialog.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_ad_enum.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_common_get_dialog/flora121_common_get_dialog_con.dart';
import 'package:flora121_package_b/flora121_hep/flora121_hep.dart';
import 'package:flora121_package_b/flora121_hep/flora121_storage/flora121_storage.dart';
import 'package:flora121_package_b/flora121_view/flora121_gold_reward_dialog_view.dart';
import 'package:flora121_package_b/flora121_view/flora121_watch_video_btn_widget.dart';
import 'package:flutter/material.dart';

class Flora121CommonGetDialog extends Flora121BaseDialog<Flora121CommonGetDialogCon>{
  double addNum;
  bool fromNewUser;
  bool fromWater;
  Flora121AdEnum rvAdEnum;
  Flora121AdEnum intAdEnum;
  Function(bool received) dismissCallback;
  bool fromQuiz;
  bool fromDice;
  Flora121CommonGetDialog({
    required this.addNum,
    required this.rvAdEnum,
    required this.intAdEnum,
    this.fromNewUser=false,
    this.fromQuiz=false,
    this.fromDice=false,
    this.fromWater=false,
    required this.dismissCallback,
});

  @override
  Flora121CommonGetDialogCon initBaseConFlora121() => Flora121CommonGetDialogCon(fromWater);

  @override
  onFlora121Init() {
    baseCon.uploadShowPointEvent(rvAdEnum);
  }

  @override
  Widget initBaseWidgetFlora121() {
    var goldMode=bGoldMode.getData();
    if(goldMode.isNotEmpty){
      return Flora121GoldRewardDialogView(
        goldMode: goldMode,
        addNum: addNum,
        clickGet: (){
          baseCon.clickDouble(addNum,fromNewUser,rvAdEnum,fromQuiz,dismissCallback);
        },
        clickClose: (){
          baseCon.clickClose(addNum,intAdEnum,dismissCallback);
        },
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flora121ImagesView(imagesName: "get4",height: 62.h,fit: BoxFit.fitHeight,),
        _contentWidget(),
      ],
    );
  }

  _contentWidget()=>Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: double.infinity,
        height: 490.h,
        margin: EdgeInsets.only(left: 34.w,right: 34.w),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Flora121ImagesView(imagesName: "get5",width: double.infinity,height: double.infinity,),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _titleWidget(),
                _monetWidget(),
                // _progressListWidget(),
                SizedBox(height: 6.h,),
                Flora121TextView(
                  text: fromDice?"Nice! Your play=🌱 for the planet=Cash Prizes":"Double win: \nCash for you, care for the planet!",
                  color: "#324631",
                  size: 16.sp,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 6.h,),
                _btnWidget(),
                SizedBox(height: 12.h,),
                _myCashWidget(),
                SizedBox(height: 12.h,),
              ],
            ),
          ],
        ),
      ),
      SizedBox(height: 32.h,),
      Flora121Click(
        onTap: (){
          baseCon.clickClose(addNum,intAdEnum,dismissCallback);
        },
        child: Flora121ImagesView(imagesName: "icon_close",width: 30.w,height: 30.w,),
      ),
    ],
  );

  _monetWidget()=>SizedBox(
    width: 180.w,
    height: 180.h,
    child: Stack(
      children: [
        Flora121ImagesView(imagesName: "get6",width: 180.w,height: 180.h,),
        Align(
          child: Flora121ImagesView(
            imagesName: "icon_money",
            width: 200.w,
            fit: BoxFit.fitWidth,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(bottom: 10.h),
            child: Flora121TextView(text: "+\$$addNum", color: "#239E04", size: 16.sp,fontWeight: FontWeight.bold,),
          ),
        )
      ],
    ),
  );

  _progressListWidget()=>GetBuilder<Flora121CommonGetDialogCon>(
    id: "progress",
    builder: (_)=>Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _progressItemWidget(0,"Ensure SafetySafety"),
        _progressItemWidget(1,"Arrived Within 24 Hours"),
        _progressItemWidget(2,"1M+ Users Trusted"),
      ],
    ),
  );

  _progressItemWidget(int index,String content)=>Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Flora121ImagesView(imagesName: baseCon.progressIndex>=index?"icon_sel2":"icon_uns2",width: 12.w,height: 12.w,),
      SizedBox(width: 4.w,),
      Flora121TextView(text: content, color: "#324631", size: 12.sp,fontWeight: FontWeight.bold,),
    ],
  );

  _btnWidget()=>Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Flora121WatchVideoBtnWidget(
        text: fromWater?"Free Claim":"Double Claim",
        btnColor: "#FBAC00",
        showVideoIcon: !fromNewUser&&!fromWater,
        onTap: (){
          if(rvAdEnum==Flora121AdEnum.frfcn_level_rv||rvAdEnum==Flora121AdEnum.frfcn_signin_rv){
            baseCon.fromLevelClickDouble(addNum, rvAdEnum,intAdEnum, dismissCallback);
            return;
          }
          baseCon.clickDouble(addNum,fromNewUser,rvAdEnum,fromQuiz,dismissCallback);
        },
      ),
      Visibility(
        visible: fromQuiz,
        child: Container(
          margin: EdgeInsets.only(top: 10.h),
          child: Flora121Click(
            onTap: (){

            },
            child: Flora121TextView(
              text: "Only\$$addNum",
              color: "#324631",
              size: 16.sp,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              decorationColor: "#324631".toColor(),
            ),
          ),
        ),
      ),
    ],
  );

  _myCashWidget()=>Container(
    width: double.infinity,
    height: 28.h,
    margin: EdgeInsets.only(left: 16.w,right: 16.w),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.w),
      color: "#000000".toColor().withOpacity(0.1),
    ),
    child: Row(
      children: [
        // Flora121ImagesView(imagesName: "get7",height: 26.h,fit: BoxFit.fitHeight,),
        // Flora121ImagesView(imagesName: "get8",height: 26.h,fit: BoxFit.fitHeight,),
        SizedBox(width: 8.w,),
        Flora121ImagesView(imagesName: "get9",height: 14.h,fit: BoxFit.fitHeight,),
        SizedBox(width: 8.w,),
        Flora121ImagesView(imagesName: "get10",height: 14.h,fit: BoxFit.fitHeight,),
        Spacer(),
        Flora121TextView(text: "My Cash: ", color: "#324631", size: 10.sp,fontWeight: FontWeight.bold,),
        Flora121TextView(text: "\$${bMyMoneyNum.getData()}", color: "#239E04", size: 12.sp,fontWeight: FontWeight.bold,),
        SizedBox(width: 8.w,),
      ],
    ),
  );

  _titleWidget()=>Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Flora121TextView(text: "Only ", color: "#113313", size: 16.sp,fontWeight: FontWeight.bold,),
      Flora121TextView(text: "\$${getLeftCashNum()}", color: "#3EA508", size: 16.sp,fontWeight: FontWeight.bold,),
      Flora121TextView(text: " left to cash out", color: "#113313", size: 16.sp,fontWeight: FontWeight.bold,),
    ],
  );
}