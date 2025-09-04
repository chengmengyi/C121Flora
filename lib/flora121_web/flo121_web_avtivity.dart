import 'package:flora121/flora121_web/flora121_web_con.dart';
import 'package:flora121_base/flora121_base/flora121_base_activity.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flutter/material.dart';

class Flo121WebAvtivity extends Flora121BaseActivity<Flora121WebCon>{
  @override
  Flora121WebCon initBaseConFlora121() => Flora121WebCon();

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
          Expanded(child: WebViewWidget(controller: baseCon.controller)),
        ],
      ),
    ],
  );

  _headWidget()=>Container(
    width: double.infinity,
    color: "#C2DD4A".toColor(),
    child: SafeArea(
      child: Container(
        width: double.infinity,
        height: 40.h,
        margin: EdgeInsets.only(left: 20.w,bottom: 10.h,top: 10.h),
        child: Stack(
          children: [
            Flora121Click(
              onTap: (){
                Flora121RoutersHep.back();
              },
              child: Flora121ImagesView(imagesName: "icon_close",width: 30.w,height: 30.w,),
            ),
            Align(
              child: Flora121TextView(text: baseCon.title, color: "#FFFFFF", size: 14.sp,fontWeight: FontWeight.bold,),
            ),
          ],
        ),
      ),
    ),
  );
}