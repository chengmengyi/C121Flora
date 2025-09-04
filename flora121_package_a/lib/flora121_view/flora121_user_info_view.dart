import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_a/flora121_hep/flora121_user_info_utils.dart';
import 'package:flutter/material.dart';

class Flora121UserInfoView extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    var userInfo = Flora121UserInfoUtils.instance.getUserInfo();
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Container(
          margin: EdgeInsets.only(left: 20.w),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Flora121ImagesView(imagesName: "home3",width: 142.w,height: 37.h,),
              Flora121TextView(text: userInfo?.userId??"", color: "#313831", size: 12.sp,fontWeight: FontWeight.bold,),
            ],
          ),
        ),
        Flora121ImagesView(imagesName: userInfo?.headIcon??"head1",width: 42.w,height: 42.h,),
      ],
    );
  }
}