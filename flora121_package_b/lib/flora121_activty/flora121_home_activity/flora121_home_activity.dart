import 'package:flora121_base/flora121_base/flora121_base_activity.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_package_b/flora121_activty/flora121_home_activity/flora121_home_con.dart';
import 'package:flora121_package_b/flora121_view/flora121_top_money_view.dart';
import 'package:flutter/material.dart';

class Flora121HomeActivity extends Flora121BaseActivity<Flora121HomeCon>{
  @override
  Flora121HomeCon initBaseConFlora121() => Flora121HomeCon();

  @override
  Widget initBaseWidgetFlora121() => Stack(
    children: [
      GetBuilder<Flora121HomeCon>(
        id: "page",
        builder: (_)=>IndexedStack(
          index: baseCon.tabIndex,
          children: baseCon.page,
        ),
      ),
      _bottomWidget(),
      GetBuilder<Flora121HomeCon>(
        id: "top_view",
        builder: (_)=>Visibility(
          visible: baseCon.tabIndex!=2,
          child: Flora121TopMoneyView(),
        ),
      ),
    ],
  );
  
  _bottomWidget()=>Align(
    alignment: Alignment.bottomCenter,
    child: SizedBox(
      width: double.infinity,
      height: 80.h,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Flora121ImagesView(imagesName: "home2",width: double.infinity,height: 47.h,),
          Row(
            children: [
              _bottomItemWidget("tab_home",0),
              _bottomItemWidget("tab_dice",1),
              _bottomItemWidget("tab_wheel",2),
              _bottomItemWidget("tab_cash",3),
            ],
          ),
        ],
      ),
    ),
  );
  
  _bottomItemWidget(String icon,int index)=>Expanded(
    child: Center(
      child: Flora121Click(
        onTap: (){
          baseCon.clickBottom(index);
        },
        child: Flora121ImagesView(imagesName: icon,width: 75.w,height: 70.h,),
      ),
    ),
  );
}