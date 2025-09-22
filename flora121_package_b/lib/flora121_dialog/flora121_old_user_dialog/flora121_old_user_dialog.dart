import 'package:flora121_base/flora121_base/flora121_base_dialog.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_old_user_dialog/flora121_old_user_dialog_con.dart';
import 'package:flora121_package_b/flora121_hep/flora121_storage/flora121_storage.dart';
import 'package:flora121_package_b/flora121_hep/flora121_value_utils.dart';
import 'package:flora121_package_b/flora121_view/flora121_watch_video_btn_widget.dart';
import 'package:flutter/material.dart';

class Flora121OldUserDialog extends Flora121BaseDialog<Flora121OldUserDialogCon>{

  @override
  Flora121OldUserDialogCon initBaseConFlora121() => Flora121OldUserDialogCon();

  @override
  Widget initBaseWidgetFlora121() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(
        width: double.infinity,
        height: 600.h,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Flora121ImagesView(imagesName: "old1",width: double.infinity,height: double.infinity,),
            Container(
              margin: EdgeInsets.only(left: 40.w,right: 40.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _monetWidget(),
                  _progressListWidget(),
                  SizedBox(height: 16.h,),
                  _cashLeftTipsWidget(),
                  SizedBox(height: 8.h,),
                  Flora121TextView(text: "Everyone wins!", color: "#FF8000", size: 16.sp,fontWeight: FontWeight.bold,),
                  _claimBtnWidget(),
                  SizedBox(height: 16.h,),
                  _myCashWidget(),
                  SizedBox(height: 12.h,),
                ],
              ),
            ),
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

  _monetWidget()=>SizedBox(
    width: 200.w,
    height: 200.h,
    child: Stack(
      children: [
        Flora121ImagesView(imagesName: "get6",width: 200.w,height: 200.h,),
        Align(
          child: Flora121ImagesView(imagesName: "icon_money",width: 200.w,fit: BoxFit.fitWidth,),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(bottom: 10.h),
            child: Flora121TextView(text: "+\$${baseCon.addNum}", color: "#BC1D33", size: 16.sp,fontWeight: FontWeight.bold,),
          ),
        )
      ],
    ),
  );


  _progressListWidget()=>GetBuilder<Flora121OldUserDialogCon>(
    id: "progress",
    builder: (_)=>Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _progressItemWidget(0,"Trusted by 1M+ Users"),
        _progressItemWidget(1,"100% Secure Transfer"),
        _progressItemWidget(2,"Instant Payment"),
        _progressItemWidget(3,"Direct to Your Account"),
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

  _cashLeftTipsWidget()=>Container(
    width: double.infinity,
    padding: EdgeInsets.all(10.w),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: ["#FFFFFF".toColor().withOpacity(0.1),"#FFD9DB".toColor(),"#FFDEDF".toColor().withOpacity(0.8),"#FFFFFF".toColor().withOpacity(0.1),],
      )
    ),
    child: RichText(
      text: TextSpan(
        children: [
          //Watch a ad to earn $xxx for yourself AND unlock a $xxx donation from us to plant native flowers in California's wildfire recovery regions.
          TextSpan(
            text: "Watch a ad to earn ",
            style: TextStyle(
              fontSize: 12.sp,
              color: "#4E1010".toColor(),
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: "\$${Flora121ValueUtils.instance.getOldUserMoney1()}",
            style: TextStyle(
              fontSize: 12.sp,
              color: "#FFB127".toColor(),
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: " for yourself AND unlock a ",
            style: TextStyle(
              fontSize: 12.sp,
              color: "#4E1010".toColor(),
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: "\$${Flora121ValueUtils.instance.getOldUserMoney1()}",
            style: TextStyle(
              fontSize: 12.sp,
              color: "#FFB127".toColor(),
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: " donation from us to plant native flowers in California's wildfire recovery regions.",
            style: TextStyle(
              fontSize: 12.sp,
              color: "#4E1010".toColor(),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );

  _claimBtnWidget()=>Flora121WatchVideoBtnWidget(
    text: "Claim",
    btnColor: "#E23D40",
    showVideoIcon: false,
    onTap: (){
      baseCon.clickDouble();
    },
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
        Flora121ImagesView(imagesName: "get7",height: 26.h,fit: BoxFit.fitHeight,),
        Flora121ImagesView(imagesName: "get8",height: 26.h,fit: BoxFit.fitHeight,),
        Spacer(),
        Flora121TextView(text: "My Cash: ", color: "#324631", size: 10.sp,fontWeight: FontWeight.bold,),
        Flora121TextView(text: "\$${bMyMoneyNum.getData()}", color: "#239E04", size: 12.sp,fontWeight: FontWeight.bold,),
        SizedBox(width: 8.w,),
      ],
    ),
  );
}