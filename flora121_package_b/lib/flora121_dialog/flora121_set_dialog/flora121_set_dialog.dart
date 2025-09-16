import 'package:flora121_base/flora121_base/flora121_base_dialog.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_music_hep.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_set_dialog/flora121_set_dialog_con.dart';
import 'package:flutter/material.dart';

class Flora121SetDialog extends Flora121BaseDialog<Flora121SetDialogCon>{
  @override
  Flora121SetDialogCon initBaseConFlora121() => Flora121SetDialogCon();

  @override
  Widget initBaseWidgetFlora121() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: double.infinity,
        margin: EdgeInsets.only(left: 34.w,right: 34.w),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: "#F9FFF2".toColor(),
          borderRadius: BorderRadius.circular(20.w),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flora121TextView(text: "Setting", color: "#7A5040", size: 16.sp,fontWeight: FontWeight.bold,),
            SizedBox(height: 16.h,),
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
      ),
      SizedBox(height: 25.h,),
      Flora121Click(
        onTap: (){
          baseCon.clickClose();
        },
        child: Flora121ImagesView(imagesName: "icon_close",width: 30.w,height: 30.w,),
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
    height: 40.h,
    alignment: Alignment.centerLeft,
    padding: EdgeInsets.only(left: 15.w,right: 15.w),
    decoration: BoxDecoration(
      color: "#EFF6E5".toColor(),
      borderRadius: BorderRadius.circular(15.w),
    ),
    child: Row(
      children: [
        Flora121TextView(text: "Music", color: "#313831", size: 12.sp,fontWeight: FontWeight.bold,),
        Spacer(),
        Flora121Click(
          onTap: (){
            baseCon.clickMusic();
          },
          child: GetBuilder<Flora121SetDialogCon>(
            id: "music",
            builder: (_)=>Flora121ImagesView(imagesName: musicSwitch.getData()?"music_on":"music_off",width: 75.w,height: 30.h,),
          ),
        ),
      ],
    ),
  );
}