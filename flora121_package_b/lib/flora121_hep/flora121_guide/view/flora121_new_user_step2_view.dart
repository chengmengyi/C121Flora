import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_b/flora121_hep/flora121_storage/flora121_storage.dart';
import 'package:flora121_package_b/flora121_hep/flora121_user_info_utils.dart';
import 'package:flutter/material.dart';

class Flora121NewUserStep2View extends StatelessWidget{
  double addNum;
  Function() dismissCallback;
  Flora121NewUserStep2View({
    required this.addNum,
    required this.dismissCallback,
});

  @override
  Widget build(BuildContext context) => Material(
    type: MaterialType.transparency,
    child: Flora121Click(
      onTap: (){
        dismissCallback.call();
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black.withOpacity(0.7),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 148.h,
                  child: Stack(
                    children: [
                      Flora121ImagesView(imagesName: "paypal_bg",width: double.infinity,height: double.infinity,),
                      _bottomLeftWidget(),
                      _bottomRightWidget(),
                    ],
                  ),
                ),
                SizedBox(
                  width: 340.w,
                  height: 90.h,
                  child: Stack(
                    children: [
                      Flora121ImagesView(imagesName: "step1",width: double.infinity,height: double.infinity,),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: EdgeInsets.only(bottom: 16.h),
                          child: Row(
                            children: [
                              SizedBox(width: 10.w,),
                              Flora121ImagesView(imagesName: "icon_head",width: 43.w,height: 43.w,),
                              SizedBox(width: 10.w,),
                              Expanded(
                                child: Flora121TextView(text: "Every \$$addNum you earn = \$$addNum donated to eco projects.", color: "#3B6204", size: 12.sp,fontWeight: FontWeight.bold,),
                              ),
                              SizedBox(width: 10.w,),
                            ],
                          ),
                          // child: RichText(
                          //   text: TextSpan(
                          //     children: [
                          //       TextSpan(
                          //         text: "Nice! ",
                          //         style: TextStyle(
                          //           fontSize: 12.sp,
                          //           fontWeight: FontWeight.bold,
                          //           color: "#3B6204".toColor(),
                          //         ),
                          //       ),
                          //       TextSpan(
                          //         text: "+ $addNum",
                          //         style: TextStyle(
                          //           fontSize: 12.sp,
                          //           fontWeight: FontWeight.bold,
                          //           color: "#EF5D00".toColor(),
                          //         ),
                          //       ),
                          //       TextSpan(
                          //         text: " for you!",
                          //         style: TextStyle(
                          //           fontSize: 12.sp,
                          //           fontWeight: FontWeight.bold,
                          //           color: "#3B6204".toColor(),
                          //         ),
                          //       ),
                          //     ]
                          //   ),
                          // ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );

  _bottomRightWidget()=>Positioned(
    right: 20.w,
    bottom: 15.h,
    child: Container(
      padding: EdgeInsets.only(left: 20.w,right: 20.w,top: 2.h,bottom: 2.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.w),
        color: "#FFFFFF".toColor().withOpacity(0.3),
      ),
      child: Flora121TextView(text: "ID:${Flora121UserInfoUtils.instance.getUserInfo()?.userId??""}", color: "#FFFFFF", size: 10.sp),
    ),
  );

  _bottomLeftWidget()=>Positioned(
    left: 22.w,
    bottom: 5.h,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flora121TextView(text: "My Balance", color: "#FFFFFF", size: 10.sp,fontWeight: FontWeight.bold,),
        Flora121TextView(text: "\$${bMyMoneyNum.getData()}", color: "#FFFFFF", size: 28.sp,fontWeight: FontWeight.bold,),
      ],
    ),
  );
}