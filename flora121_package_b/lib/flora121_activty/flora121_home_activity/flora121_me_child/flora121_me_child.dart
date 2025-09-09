import 'package:flora121_base/flora121_base/flora121_base_child.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_music_hep.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_b/flora121_activty/flora121_home_activity/flora121_me_child/flora121_me_child_con.dart';
import 'package:flora121_package_b/flora121_view/flora121_user_info_view.dart';
import 'package:flutter/material.dart';

class Flora121MeChild extends Flora121BaseChild<Flora121MeChildCon>{
  @override
  Flora121MeChildCon initBaseConFlora121() => Flora121MeChildCon();

  @override
  Widget initBaseWidgetFlora121() => Stack(
    children: [
      Container(
        width: double.infinity,
        height: double.infinity,
        color: "#FCFFF6".toColor(),
      ),
      Column(
        children: [
          _headWidget(),
          SizedBox(height: 23.h,),
          _musicWidget(),
          Container(
            width: double.infinity,
            height: 1.h,
            color: "#313831".toColor().withOpacity(0.3),
            margin: EdgeInsets.only(left: 32.w,right: 32.w,top: 22.h),
          ),
          SizedBox(height: 26.h,),
          _aboutWidget(),
        ],
      ),
    ],
  );

  _aboutWidget()=>Container(
    margin: EdgeInsets.only(left: 32.w,right: 32.w),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Flora121TextView(text: "About", color: "#313831", size: 14.sp,fontWeight: FontWeight.bold,),
            Spacer(),
            Flora121ImagesView(imagesName: "me1",width: 22.w,height: 15.h,),
          ],
        ),
        SizedBox(height: 18.h,),
        Flora121Click(
          onTap: (){
            baseCon.clickUserAgreement();
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Flora121ImagesView(imagesName: "me2",width: double.infinity,height: 50.h,),
              Flora121TextView(text: "User Agreement", color: "#313831", size: 13.sp,fontWeight: FontWeight.bold,),
            ],
          ),
        ),
        SizedBox(height: 15.h,),
        Flora121Click(
          onTap: (){
            baseCon.clickPrivacy();
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Flora121ImagesView(imagesName: "me2",width: double.infinity,height: 50.h,),
              Flora121TextView(text: "Privacy Policy", color: "#313831", size: 13.sp,fontWeight: FontWeight.bold,),
            ],
          ),
        ),
      ],
    ),
  );

  _musicWidget()=>Container(
    width: double.infinity,
    height: 50.h,
    alignment: Alignment.centerLeft,
    margin: EdgeInsets.only(left: 32.w,right: 32.w),
    padding: EdgeInsets.only(left: 17.w,right: 17.w),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15.w),
      color: "#EFF6E5".toColor(),
    ),
    child: Row(
      children: [
        Flora121TextView(text: "Music", color: "#313831", size: 14.sp,fontWeight: FontWeight.bold,),
        Spacer(),
        Flora121Click(
          onTap: (){
            baseCon.clickMusic();
          },
          child: GetBuilder<Flora121MeChildCon>(
            id: "music",
            builder: (_)=>Flora121ImagesView(imagesName: musicSwitch.getData()?"music_on":"music_off",width: 75.w,height: 30.h,),
          ),
        ),
      ],
    ),
  );

  _headWidget()=>Container(
    width: double.infinity,
    color: "#C2DD4A".toColor(),
    child: SafeArea(
      child: Container(
        margin: EdgeInsets.only(left: 20.w,bottom: 20.h,top: 20.h),
        child: Row(
          children: [
            Flora121UserInfoView(),
          ],
        ),
      ),
    ),
  );
}