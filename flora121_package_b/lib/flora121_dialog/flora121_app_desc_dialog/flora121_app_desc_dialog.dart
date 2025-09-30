import 'package:flora121_base/flora121_base/flora121_base_dialog.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_app_desc_dialog/flora121_app_desc_dialog_controller.dart';
import 'package:flutter/material.dart';

class Flora121AppDescDialog extends Flora121BaseDialog<Flora121AppDescDialogController>{
  Function() clickCallback;
  Flora121AppDescDialog({
    required this.clickCallback,
});

  @override
  Flora121AppDescDialogController initBaseConFlora121() => Flora121AppDescDialogController();

  @override
  Widget initBaseWidgetFlora121() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: double.infinity,
        margin: EdgeInsets.only(left: 34.w,right: 34.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.w),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: ["#80B640".toColor(),"#9ADD4A".toColor(),"#C2DD4A".toColor()],
            )
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            _titleWidget(),
            _contentWidget(),
          ],
        ),
      ),
      SizedBox(height: 25.h,),
      Flora121Click(
        onTap: (){
          baseCon.click(clickCallback);
        },
        child: Flora121ImagesView(imagesName: "icon_close",width: 30.w,height: 30.w,),
      ),
    ],
  );

  _contentWidget()=>Container(
    width: double.infinity,
    margin: EdgeInsets.only(top: 64.h),
    padding: EdgeInsets.only(left: 14.w,right: 14.w,top: 43.h,bottom: 30.h),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.w),
      color: "#F9FFF2".toColor(),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _text1Widget(),
        SizedBox(height: 10.h,),
        _text2Widget(),
        SizedBox(height: 10.h,),
        _text3Widget(),
        SizedBox(height: 20.h,),
        _btnWidget(),
      ],
    ),
  );

  _text1Widget()=>Flora121TextView(text: "We are a small environmental organization, devoted to protecting flowers and nature. In our app, every flower you grow contributes to green plant protection on Earth and the restoration of vegetation after wildfires.", color: "#313831", size: 14.sp);

  _text2Widget()=>RichText(
    text: TextSpan(
      children: [
    // 50% of our ad revenue supports users’ plant growth and wildfire restoration,
    //     40% provides timely cash rewards, and
    //     10% covers platform operations.
        TextSpan(
          text: "50%",
          style: TextStyle(
            fontSize: 14.sp,
            color: "#EE7838".toColor(),
            fontWeight: FontWeight.bold,
          ),
        ),
        TextSpan(
          text: " of our ad revenue supports users’ plant growth and wildfire restoration,",
          style: TextStyle(
            fontSize: 14.sp,
            color: "#313831".toColor(),
            fontWeight: FontWeight.bold,
          ),
        ),
        TextSpan(
          text: "40%",
          style: TextStyle(
            fontSize: 14.sp,
            color: "#EE7838".toColor(),
            fontWeight: FontWeight.bold,
          ),
        ),
        TextSpan(
          text: " provides timely cash rewards, and",
          style: TextStyle(
            fontSize: 14.sp,
            color: "#313831".toColor(),
            fontWeight: FontWeight.bold,
          ),
        ),
        TextSpan(
          text: "10%",
          style: TextStyle(
            fontSize: 14.sp,
            color: "#EE7838".toColor(),
            fontWeight: FontWeight.bold,
          ),
        ),
        TextSpan(
          text: " covers platform operations.",
          style: TextStyle(
            fontSize: 14.sp,
            color: "#313831".toColor(),
            fontWeight: FontWeight.bold,
          ),
        ),
      ]
    ),
  );

  _text3Widget()=>Flora121TextView(text: "Together, we have accumulated \$83.9M in contributions. Your effort not only earns rewards—it helps make the planet greener.", color: "#313831", size: 14.sp);


  _titleWidget()=>Container(
    width: double.infinity,
    height: 64.h,
    alignment: Alignment.center,
    child: Flora121TextView(text: "App Description", color: "#0D4611", size: 24.sp,fontWeight: FontWeight.bold,),
  );

  _btnWidget()=>Flora121Click(
    onTap: (){
      baseCon.click(clickCallback);
    },
    child: Container(
      width: double.infinity,
      height: 50.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: "#4C7D0A".toColor(),
        borderRadius: BorderRadius.circular(15.w),
      ),
      child: Flora121TextView(text: "Plant & Earn", color: "#FFFFFF", size: 16.sp,fontWeight: FontWeight.bold,),
    ),
  );
}