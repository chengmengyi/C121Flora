import 'package:flora121_base/flora121_base/flora121_base_dialog.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_wheel_get_dialog/flora121_wheel_get_dialog_con.dart';
import 'package:flora121_package_b/flora121_hep/flora121_hep.dart';
import 'package:flora121_package_b/flora121_hep/flora121_storage/flora121_storage.dart';
import 'package:flora121_package_b/flora121_view/flora121_watch_video_btn_widget.dart';
import 'package:flutter/material.dart';

class Flora121WheelGetDialog extends Flora121BaseDialog<Flora121WheelGetDialogCon>{
  double addNum;
  Function(bool received) dismissCallback;
  Flora121WheelGetDialog({
    required this.addNum,
    required this.dismissCallback,
});

  @override
  Flora121WheelGetDialogCon initBaseConFlora121() => Flora121WheelGetDialogCon();

  @override
  Widget initBaseWidgetFlora121() => _contentWidget();

  _contentWidget()=>Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: double.infinity,
        height: 448.h,
        margin: EdgeInsets.only(left: 34.w,right: 34.w),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Flora121ImagesView(imagesName: "wheel12",width: double.infinity,height: double.infinity,),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _monetWidget(),
                _progressListWidget(),
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
          baseCon.clickClose(addNum,dismissCallback);
        },
        child: Flora121ImagesView(imagesName: "icon_close",width: 30.w,height: 30.w,),
      )
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
            child: Flora121TextView(text: "+\$$addNum", color: "#239E04", size: 16.sp,fontWeight: FontWeight.bold,),
          ),
        )
      ],
    ),
  );

  _progressListWidget()=>GetBuilder<Flora121WheelGetDialogCon>(
    id: "progress",
    builder: (_)=>Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(left: 23.w,right: 23.w),
          child: MasonryGridView.count(
            padding: const EdgeInsets.all(0),
            itemCount: 4,
            shrinkWrap: true,
            crossAxisCount: 4,
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context,index){
              return Stack(
                alignment: Alignment.centerRight,
                children: [
                  Container(
                    width: double.infinity,
                    height: 6.h,
                    decoration: BoxDecoration(
                      color: baseCon.progressIndex>=index?"#A6E300".toColor():"#5B3E00".toColor(),
                      borderRadius: BorderRadius.only(
                        topLeft: index==0?Radius.circular(20.w):Radius.zero,
                        bottomLeft: index==0?Radius.circular(20.w):Radius.zero,
                      ),
                    ),
                  ),
                  Container(
                    width: 14.w,
                    height: 14.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.w),
                      color: baseCon.progressIndex>=index?"#A6E300".toColor():"#5B3E00".toColor(),
                    ),
                  )
                ],
              );
            },
          ),
        ),
        SizedBox(height: 20.h,),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _progressItemWidget(0,"Trusted by 1M+ Users"),
            _progressItemWidget(1,"100% Secure Transfer"),
            _progressItemWidget(2,"Instant Payment"),
            _progressItemWidget(3,"Direct to Your Account"),
          ],
        ),
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

  _btnWidget()=>Flora121WatchVideoBtnWidget(
    text: "Claim",
    btnColor: "#FBAC00",
    onTap: (){
      baseCon.clickDouble(addNum,dismissCallback);
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

  _titleWidget()=>Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Flora121TextView(text: "Only ", color: "#113313", size: 16.sp,fontWeight: FontWeight.bold,),
      Flora121TextView(text: "\$${getLeftCashNum()}", color: "#3EA508", size: 16.sp,fontWeight: FontWeight.bold,),
      Flora121TextView(text: " left to cash out", color: "#113313", size: 16.sp,fontWeight: FontWeight.bold,),
    ],
  );
}