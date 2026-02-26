import 'package:flora121/flora121_launch/flora121_launch_con.dart';
import 'package:flora121_base/flora121_base/flora121_base_activity.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flutter/material.dart';

class Flora121LaunchActivity extends Flora121BaseActivity<Flora121LaunchCon>{
  @override
  Flora121LaunchCon initBaseConFlora121() => Flora121LaunchCon();

  @override
  Widget initBaseWidgetFlora121() => Stack(
    children: [
      Flora121ImagesView(imagesName: "launch6",width: double.infinity,height: double.infinity,),
      Align(
        alignment: Alignment.topCenter,
        child: Container(
          margin: EdgeInsets.only(left: 6.w,right: 6.w,top: 100.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Flora121ImagesView(imagesName: "launch2",width: double.infinity,fit: BoxFit.fitWidth,),
              // Flora121ImagesView(imagesName: "launch5",width: double.infinity,fit: BoxFit.fitWidth,),

              // Every tap gets you closer to payout.
              // Plus, we'll donate to planet care when you earn
              Flora121TextView(text: "Grow Flowers", color: "#124C74", size: 32.sp,fontWeight: FontWeight.bold,),
              Flora121TextView(text: "Earn Real Cash", color: "#124C74", size: 32.sp,fontWeight: FontWeight.bold,),
              SizedBox(height: 12.h,),
              Flora121TextView(text: "Every tap gets you closer to payout.", color: "#EFF1F1", size: 16.sp,fontWeight: FontWeight.bold,outlineColor: "#134A71",),
              Flora121TextView(text: "Plus, we'll donate to planet care when you earn", color: "#EFF1F1", size: 16.sp,fontWeight: FontWeight.bold,outlineColor: "#134A71",textAlign: TextAlign.center,),
              SizedBox(height: 18.h,),
              Visibility(
                visible: launchShowLoading.getData(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 42.w,right: 42.w),
                      child: LayoutBuilder(
                        builder: (context,bc){
                          var maxWidth = bc.maxWidth-2.w;
                          return Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              Flora121ImagesView(imagesName: "launch4",width: double.infinity,height: 16.h,),
                              GetBuilder<Flora121LaunchCon>(
                                id: "pro_view",
                                builder: (_)=>Container(
                                  width: maxWidth*baseCon.animationController.value,
                                  height: 14.h,
                                  margin: EdgeInsets.only(left: 1.w),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.w),
                                    gradient: LinearGradient(
                                      colors: ["#7EFD65".toColor(),"#32DDD4".toColor()],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 12.h,),
                    Flora121TextView(text: "Loading Steps...", color: "#472B0A", size: 10.sp,fontWeight: FontWeight.bold,),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: EdgeInsets.only(bottom: 130.h),
          child: _bottomWidget(),
        ),
      )
    ],
  );

  _bottomWidget()=>Visibility(
    visible: !launchShowLoading.getData(),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flora121Click(
          onTap: (){
            baseCon.clickStart();
          },
          child: Flora121ImagesView(imagesName: "launch3",width: 214.w,height: 50.h,),
        ),
        SizedBox(height: 10.h,),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flora121Click(
              onTap: (){
                baseCon.clickSelect();
              },
              child: GetBuilder<Flora121LaunchCon>(
                id: "selected",
                builder: (_)=>Flora121ImagesView(imagesName: baseCon.selected?"icon_sel":"icon_uns",width: 22.w,height: 22.w,),
              ),
            ),
            SizedBox(width: 4.w,),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flora121Click(
                  onTap: (){
                    baseCon.clickPrivacy();
                  },
                  child: Flora121TextView(text: "Privacy Policy", color: "#FFFFFF", size: 14.sp,fontWeight: FontWeight.bold,outlineColor: "#000000",),
                ),
                Flora121TextView(text: "&", color: "#FFFFFF", size: 14.sp,fontWeight: FontWeight.bold,outlineColor: "#000000",),
                Flora121Click(
                  onTap: (){
                    baseCon.clickTerms();
                  },
                  child: Flora121TextView(text: "Terms of Service", color: "#FFFFFF", size: 14.sp,fontWeight: FontWeight.bold,outlineColor: "#000000",),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}