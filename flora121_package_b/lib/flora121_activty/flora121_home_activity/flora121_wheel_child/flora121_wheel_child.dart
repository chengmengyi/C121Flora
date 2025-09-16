import 'dart:math';

import 'package:flora121_base/flora121_base/flora121_base_child.dart';
import 'package:flora121_base/flora121_hep/flora121_event/flora121_event_utils.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_b/flora121_activty/flora121_home_activity/flora121_wheel_child/flora121_wheel_child_con.dart';
import 'package:flora121_package_b/flora121_hep/flora121_event_code.dart';
import 'package:flora121_package_b/flora121_hep/flora121_hep.dart';
import 'package:flora121_package_b/flora121_hep/flora121_storage/flora121_storage.dart';
import 'package:flora121_package_b/flora121_hep/flora121_wheel_utils.dart';
import 'package:flora121_package_b/flora121_view/flora121_health_view.dart';
import 'package:flora121_package_b/flora121_view/flora121_user_info_view.dart';
import 'package:flutter/material.dart';

class Flora121WheelChild extends Flora121BaseChild<Flora121WheelChildCon>{
  @override
  Flora121WheelChildCon initBaseConFlora121() => Flora121WheelChildCon();

  @override
  Widget initBaseWidgetFlora121() => Stack(
    children: [
      Flora121ImagesView(
        imagesName: "wheel8",
        width: double.infinity,
        height: double.infinity,
      ),
      Column(
        children: [
          _topWidget(),
          _wheelWidget(),
          _giftWidget(),
          _btnWidget(),
          SizedBox(height: 10.h,),
          _bottomWidget(),
        ],
      ),
      Positioned(
        left: 0,
        top: 130.h,
        child: Flora121ImagesView(imagesName: "wheel10",width: 188.w,height: 188.h,),
      ),
      _myAccountWidget(),
    ],
  );

  _giftWidget()=>Stack(
    alignment: Alignment.centerRight,
    children: [
      GetBuilder<Flora121WheelChildCon>(
        id: "gift",
        builder: (_)=>Container(
          width: 254.w,
          height: 33.h,
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(right: 20.w),
          padding: EdgeInsets.only(left: 8.w,right: 8.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.w),
            color: "#FFF7E5".toColor(),
          ),
          child: MasonryGridView.count(
            padding: const EdgeInsets.all(0),
            itemCount: 5,
            shrinkWrap: true,
            crossAxisCount: 5,
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                width: double.infinity,
                height: 17.h,
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 1.5.w,right: 1.5.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: index==0?Radius.circular(20.w):Radius.zero,
                      bottomLeft: index==0?Radius.circular(20.w):Radius.zero,
                      topRight: index==4?Radius.circular(20.w):Radius.zero,
                      bottomRight: index==4?Radius.circular(20.w):Radius.zero,
                    ),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: bWheelGiftNum.getData()>index?["#FFCC00".toColor(),"#E49C00".toColor(),]:["#9A673A".toColor(),"#9A673A".toColor()]
                    )
                ),
                child: Flora121TextView(text: "${index+1}", color: "#FFFFFF", size: 12.sp,outlineColor: "#502813",fontWeight: FontWeight.bold,),
              );
            },
          ),
        ),
      ),
      Flora121Click(
        onTap: (){
          baseCon.clickBox();
        },
        child: Flora121ImagesView(imagesName: "icon_box",width: 50.w,height: 47.h,),
      ),
    ],
  );

  _wheelWidget()=>Container(
    margin: EdgeInsets.only(left: 40.w,right: 40.w),
    child: Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          margin: EdgeInsets.only(top: 30.h),
          child: AspectRatio(
            aspectRatio: 1,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  margin: EdgeInsets.all(10.w),
                  child: GetBuilder<Flora121WheelChildCon>(
                    id: "wheel",
                    builder: (_){
                      if(null==baseCon.wheelAnimation){
                        return Container();
                      }
                      return LayoutBuilder(
                        builder: (context,bc){
                          var size = bc.maxWidth;
                          final radius = (size / 2 - 30)*0.9;
                          return AnimatedBuilder(
                            animation: baseCon.wheelAnimation!,
                            builder: (context,child)=>Transform.rotate(
                              angle: baseCon.wheelAnimation!.value,
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Flora121ImagesView(imagesName: "wheel3",width: double.infinity,height: double.infinity,),
                                    ...List.generate(
                                      baseCon.wheelList.length, (i) =>
                                        _wheelItemWidget(
                                          money: baseCon.wheelList[i],
                                          angleDeg: i * 45.0 - 90,
                                          radius: radius,
                                        ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                Flora121ImagesView(imagesName: "wheel2",width: double.infinity,height: double.infinity,),
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Flora121ImagesView(imagesName: "wheel5",width: 90.w,height: 110.h,),
                    Container(
                      margin: EdgeInsets.only(bottom: 18.h),
                      child: GetBuilder<Flora121WheelChildCon>(
                        id: "wheel_num",
                        builder: (_)=>Flora121TextView(text: "${Flora121WheelUtils.instance.wheelNum}", color: "#1F4300", size: 16.sp),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Flora121ImagesView(imagesName: "wheel4",width: 315.w,height: 130.h,),
      ],
    ),
  );

  Widget _wheelItemWidget({
    required int money,
    required double angleDeg,
    required double radius,
  }) {
    final angleRad = angleDeg * pi / 180;
    final offset = Offset(
      radius * cos(angleRad),
      radius * sin(angleRad),
    );

    final textRotation = angleRad + pi / 2;

    return Transform.translate(
      offset: offset,
      child: Transform.rotate(
        angle: textRotation,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flora121ImagesView(imagesName: money>0?"icon_money":"wheel6",width: 40.w,height: 40.w,),
            Flora121TextView(text: money>0?"+\$$money":"Try Again", color: money>0?"#844F13":"#2E619A", size: 12.sp,fontWeight: FontWeight.bold,),
          ],
        ),
      ),
    );
  }

  _btnWidget()=>Flora121Click(
    onTap: (){
      baseCon.clickStart();
    },
    child: Stack(
      alignment: Alignment.center,
      children: [
        Flora121ImagesView(imagesName: "btn1",width: 214.w,height: 50.h,),
        Flora121TextView(text: "Spin", color: "#FFFFFF", size: 16.sp,outlineColor: "#774005",fontWeight: FontWeight.bold,),
      ],
    ),
  );

  _topWidget()=>Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(height: 80.h,),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flora121TextView(text: "Just ", color: "#FFFFFF", size: 16.sp,fontWeight: FontWeight.bold,outlineColor: "#2A4A06",),
          Flora121TextView(text: "\$${getLeftCashNum()}", color: "#FFCC00", size: 16.sp,fontWeight: FontWeight.bold,outlineColor: "#2A4A06",),
          Flora121TextView(text: " Pagbank withdrawal", color: "#FFFFFF", size: 16.sp,fontWeight: FontWeight.bold,outlineColor: "#2A4A06",),
        ],
      ),
      Flora121ImagesView(imagesName: "wheel9",height: 93.h,fit: BoxFit.fitHeight,),
    ],
  );

  _myAccountWidget()=>Positioned(
    right: 0,
    top: 240.h,
    child: Flora121Click(
      onTap: (){
        Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.showHomeTab,flora121IntValue: 3);
      },
      child: Container(
        padding: EdgeInsets.only(left: 2.w,top: 2.h,bottom: 2.h,right: 6.w),
        decoration: BoxDecoration(
          color: "#FFFFFF".toColor(),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.w),
            bottomLeft: Radius.circular(20.w),
          )
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flora121ImagesView(imagesName: "wheel11",width: 21.w,height: 21.w,),
            SizedBox(width: 8.w,),
            Flora121TextView(text: "My Account", color: "#0D5100", size: 10.sp,),
          ],
        ),
      ),
    ),
  );

  _bottomWidget()=>Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        padding: EdgeInsets.only(left: 12.w,right: 12.w,top: 4.h,bottom: 5.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: ["#DEFFA1".toColor().withOpacity(0.1),"#C6E804".toColor(),"#AFFF72".toColor().withOpacity(0.1)]
          ),
        ),
        child: RichText(
          text: TextSpan(
            children: [
              //12.12 Super Easy Withdrawal $50!
              TextSpan(
                text: baseCon.getToday(),
                style: TextStyle(
                  fontSize: 14.sp,
                  color: "#0051FF".toColor(),
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: " Super Easy Withdrawal ",
                style: TextStyle(
                  fontSize: 14.sp,
                  color: "#0D4611".toColor(),
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: "\$50",
                style: TextStyle(
                  fontSize: 14.sp,
                  color: "#FF0000".toColor(),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      SizedBox(
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
            children: [
              SizedBox(width: 200.w,),
              _marqueeItemWidget("You Must Withdraw ","\$50"," This Time!"),
              SizedBox(width: 200.w,),
              _marqueeItemWidget("Time to Grab Your ","\$50"," - Don't Miss Out!"),
              SizedBox(width: 200.w,),
              _marqueeItemWidget("Spin & Win Your ","\$50"," - Fortune Awaits!"),
              SizedBox(width: 200.w,),
              _marqueeItemWidget("Your ","\$50", "Prize - One Spin Away!"),
              SizedBox(width: 200.w,),
            ],
          ),
        ),
      )
    ],
  );

  _marqueeItemWidget(String left,String center,String right)=>Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Flora121TextView(text: left, color: "#FFFFFF", size: 16.sp,outlineColor: "#2A4A06",),
      Flora121TextView(text: center, color: "#FFFF7D", size: 16.sp,outlineColor: "#2A4A06",),
      Flora121TextView(text: right, color: "#FFFFFF", size: 16.sp,outlineColor: "#2A4A06",),
    ],
  );
}