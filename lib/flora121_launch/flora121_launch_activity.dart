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
      Flora121ImagesView(imagesName: "launch1",width: double.infinity,height: double.infinity,),
      Align(
        alignment: Alignment.topCenter,
        child: Container(
          margin: EdgeInsets.only(left: 6.w,right: 6.w,top: 80.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flora121ImagesView(imagesName: "launch2",width: double.infinity,fit: BoxFit.fitWidth,),
              Flora121ImagesView(imagesName: "launch5",width: double.infinity,fit: BoxFit.fitWidth,),
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

  _bottomWidget(){
    if(launchShowLoading.getData()){
      return Container(
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
                        colors: ["#FFEA00".toColor(),"#C3DD32".toColor()],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      );
    }
    return Column(
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
            Flora121Click(
              onTap: (){
                baseCon.clickPrivacy();
              },
              child: Flora121TextView(text: "Privacy Policy&Terms of Service", color: "#472B0A", size: 14.sp,fontWeight: FontWeight.bold,),
            ),
          ],
        ),
      ],
    );
  }
}