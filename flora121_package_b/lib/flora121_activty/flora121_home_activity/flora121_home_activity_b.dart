import 'package:flora121_base/flora121_base/flora121_base_activity.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_package_b/flora121_activty/flora121_home_activity/flora121_home_con_b.dart';
import 'package:flora121_package_b/flora121_bean/flora121_home_tab_bean.dart';
import 'package:flora121_package_b/flora121_view/flora121_banner_view.dart';
import 'package:flora121_package_b/flora121_view/flora121_gold_diamond_get_animator_view.dart';
import 'package:flora121_package_b/flora121_view/flora121_money_animator_widget.dart';
import 'package:flora121_package_b/flora121_view/flora121_top_money_view.dart';
import 'package:flutter/material.dart';

class Flora121HomeActivityB extends Flora121BaseActivity<Flora121HomeConB>{
  @override
  Flora121HomeConB initBaseConFlora121() => Flora121HomeConB();

  @override
  Widget initBaseWidgetFlora121() => Stack(
    children: [
      GetBuilder<Flora121HomeConB>(
        id: "page",
        builder: (_)=>IndexedStack(
          index: baseCon.tabIndex,
          children: baseCon.page,
        ),
      ),
      _bottomWidget(),
      GetBuilder<Flora121HomeConB>(
        id: "top_view",
        builder: (_)=>Visibility(
          visible: baseCon.tabIndex!=2,
          child: Flora121TopMoneyView(),
        ),
      ),
      Align(
        alignment: Alignment.center,
        child: Flora121MoneyAnimatorWidget(
          fromQuiz: false,
        ),
      ),
      Align(
        alignment: Alignment.topCenter,
        child: Flora121BannerView(),
      ),
      Align(
        alignment: Alignment.center,
        child: Flora121GoldDiamondGetAnimatorView(),
      ),
    ],
  );
  
  _bottomWidget()=>Align(
    alignment: Alignment.bottomCenter,
    child: SizedBox(
      width: double.infinity,
      height: 70.h,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Flora121ImagesView(imagesName: "home2",width: double.infinity,height: 47.h,),
          GetBuilder<Flora121HomeConB>(
            id: "bottom_tab",
            builder: (_)=>Row(
              children: [
                _bottomItemWidget(baseCon.tabList[0],0),
                _bottomItemWidget(baseCon.tabList[1],1),
                _bottomItemWidget(baseCon.tabList[2],2),
                _bottomItemWidget(baseCon.tabList[3],3),
              ],
            ),
          ),
        ],
      ),
    ),
  );
  
  _bottomItemWidget(Flora121HomeTabBean tabBean,int index)=>Expanded(
    child: Center(
      child: Flora121Click(
        onTap: (){
          baseCon.clickBottom(index);
        },
        child: Flora121ImagesView(imagesName: baseCon.tabIndex==index?tabBean.selIcon:tabBean.unsIcon,width: 75.w,height: 70.h,),
      ),
    ),
  );
}