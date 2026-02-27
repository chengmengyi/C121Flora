import 'package:flora121_base/flora121_base/flora121_base_child.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_spine_animator_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_b/flora121_activty/flora121_home_activity/flora121_home_child/flora121_home_child_con_b.dart';
import 'package:flora121_package_b/flora121_bean/flora121_sign_bean.dart';
import 'package:flora121_package_b/flora121_hep/flora121_energy_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_storage/flora121_storage.dart';
import 'package:flora121_package_b/flora121_view/flora121_cash_record_view.dart';
import 'package:flora121_package_b/flora121_view/flora121_energy_item_widget.dart';
import 'package:flora121_package_b/flora121_view/flora121_health_view.dart';
import 'package:flora121_package_b/flora121_view/flora121_home_top_gold_view.dart';
import 'package:flora121_package_b/flora121_view/flora121_home_top_reward_view.dart';
import 'package:flora121_package_b/flora121_view/flora121_shake_view.dart';
import 'package:flora121_package_b/flora121_view/flora121_user_info_view.dart';
import 'package:flora121_package_b/flora_enum/flora121_energy_type.dart';
import 'package:flutter/material.dart';

class Flora121HomeChildB extends Flora121BaseChild<Flora121HomeChildConB>{
  @override
  Flora121HomeChildConB initBaseConFlora121() => Flora121HomeChildConB();

  @override
  Widget initBaseWidgetFlora121() => Stack(
    children: [
      Flora121ImagesView(imagesName: "home1",width: double.infinity,height: double.infinity,),
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 140.h,),
          GetBuilder<Flora121HomeChildConB>(
            id: "top_reward_view",
            builder: (_){
              var hasGold = bGoldMode.getData().isNotEmpty;
              if(hasGold){
                return Flora121HomeTopGoldView();
              }
              return Flora121HomeTopRewardView();
            },
          ),
        ],
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: _bottomWidget(),
      ),
      _rewardTipsWidget(),
    ],
  );

  _bottomWidget()=>Container(
    margin: EdgeInsets.only(bottom: 80.h),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GetBuilder<Flora121HomeChildConB>(
          id: "bottom_widget",
          builder: (_){
            var hasGold = bGoldMode.getData().isNotEmpty;
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: hasGold?20.h:90.h),
                  child: _flowerWidget(hasGold),
                ),
                Visibility(
                  visible: !hasGold,
                  child: Container(
                    width: double.infinity,
                    height: 120.h,
                    alignment: Alignment.center,
                    child: _flowerLevelWidget(),
                  ),
                ),
              ],
            );
          },
        ),
        _bottomCardWidget(),
      ],
    ),
  );

  _flowerWidget(bool hasGold)=>Stack(
    alignment: Alignment.bottomCenter,
    children: [
      Flora121ImagesView(imagesName: "home15",width: 200.w,height: 65.h,),
      Container(
        width: double.infinity,
        height: 260.h,
        margin: EdgeInsets.only(bottom: 30.h),
        child: Stack(
          children: [
            GetBuilder<Flora121HomeChildConB>(
              id: "flower",
              builder: (_)=>Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      key: baseCon.treeGlobalKey,
                      child: Flora121Click(
                        onTap: (){
                          baseCon.test();
                        },
                        child: Flora121ImagesView(imagesName: baseCon.getFlowerImage(),width: hasGold?150.w:100.w,),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 80.w,
                    bottom: 80.h,
                    child: _energyItemWidget(Flora121EnergyType.wheel,),
                  ),
                  Positioned(
                    left: 20.w,
                    bottom: 150.h,
                    child: _energyItemWidget(
                      Flora121EnergyType.money,
                      key: baseCon.treeGlobalKey,
                    ),
                  ),
                  Positioned(
                    top: 20.h,
                    left: 100.w,
                    child: _energyItemWidget(Flora121EnergyType.water),
                  ),
                  Positioned(
                    top: 10.h,
                    right: 100.w,
                    child: _energyItemWidget(Flora121EnergyType.dice),
                  ),
                  Positioned(
                    top: 80.h,
                    right: 36.w,
                    child: _energyItemWidget(Flora121EnergyType.quiz),
                  ),
                  Positioned(
                    left: 20.w,
                    bottom: 30.h,
                    child: _energyItemWidget(Flora121EnergyType.money,floraMoneyEnergyType: FloraMoneyEnergyType.video1),
                  ),
                  Positioned(
                    right: 40.w,
                    bottom: 30.h,
                    child: _energyItemWidget(Flora121EnergyType.money,floraMoneyEnergyType: FloraMoneyEnergyType.video2),
                  ),
                  Positioned(
                    top: 0,
                    left: 16.w,
                    child: Flora121Click(
                      onTap: (){
                        baseCon.clickMoreFun();
                      },
                      child: Flora121ImagesView(imagesName: "more_fun",width: 52.w,height: 52.w,),
                    ),
                  ),
                  // Positioned(
                  //   top: 0,
                  //   right: 16.w,
                  //   child: Flora121Click(
                  //     onTap: (){
                  //       baseCon.clickGame();
                  //     },
                  //     child: Flora121ImagesView(imagesName: "icon_game",width: 52.w,height: 52.w,),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
      Flora121CashRecordView(),
    ],
  );

  _energyItemWidget(Flora121EnergyType type,{GlobalKey? key,FloraMoneyEnergyType floraMoneyEnergyType=FloraMoneyEnergyType.normal})=>Flora121EnergyItemWidget(
    flora121energyType: type,
    treeGlobalKey: key,
    floraMoneyEnergyType: floraMoneyEnergyType,
    clickItem: (){
      baseCon.clickEnergy(type);
    },
  );

  _flowerLevelWidget()=>GetBuilder<Flora121HomeChildConB>(
    id: "level",
    builder: (_){
      var levelNum = Flora121EnergyUtils.instance.getLevelNum();
      if(levelNum<5){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  width: 228.w,
                  height: 27.h,
                  margin: EdgeInsets.only(bottom: 10.h),
                  child: Stack(
                    children: [
                      Container(
                        width: 228.w,
                        height: 27.h,
                        decoration: BoxDecoration(
                          color: "#82381A".toColor(),
                          borderRadius: BorderRadius.circular(20.w),
                          border: Border.all(
                            width: 2.w,
                            color: "#FFE100".toColor(),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: (222.w)*Flora121EnergyUtils.instance.getLevelPro(),
                          height: 21.h,
                          margin: EdgeInsets.only(left: 3.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.w),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: ["#FFE100".toColor(),"#E57300".toColor()],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Flora121TextView(text: "LV.${Flora121EnergyUtils.instance.getLevelNum()}", color: "#FFFFFF", size: 12.sp,outlineColor: "#682409",fontWeight: FontWeight.bold,),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  key: baseCon.rewardGlobalKey,
                  child: GetBuilder<Flora121HomeChildConB>(
                    id: "level_money",
                    builder: (_){
                      if(baseCon.showLevelMoneyAnimator){
                        return Flora121Click(
                          onTap: (){
                            baseCon.clickLevelMoney();
                          },
                          child: RotateShakeWidget(
                            angle: 0.2,
                            duration: Duration(milliseconds: 600),
                            child: Flora121ImagesView(imagesName: "home16",width: 51.w,height: 51.w,),
                          ),
                        );
                      }
                      return Flora121ImagesView(imagesName: "home16",width: 51.w,height: 51.w,);
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flora121TextView(text: "Collect ", color: "#313831", size: 12.sp,fontWeight: FontWeight.bold,),
                Flora121TextView(text: "${Flora121EnergyUtils.instance.getCollectSurplusNum()}", color: "#FFFFFF", size: 12.sp,fontWeight: FontWeight.bold,outlineColor: "#82381A",),
                Flora121TextView(text: " bubbles to upgrade", color: "#313831", size: 12.sp,fontWeight: FontWeight.bold,),
              ],
            ),
          ],
        );
      }
      return _signWidget();
    },
  );

  _signWidget(){
    if(baseCon.signList.length!=7){
      return Container();
    }
    return Container(
      margin: EdgeInsets.only(left: 12.w,right: 12.w,),
      child: Stack(
        children: [
          Container(
            width: 85.w,
            height: 56.h,
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
              color: "#66B918".toColor(),
              borderRadius: BorderRadius.circular(10.w),
            ),
            child: Container(
              width: 85.w,
              height: 26.h,
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flora121ImagesView(imagesName: "home20",width: 23.w,height: 23.h,),
                  SizedBox(width: 2.w,),
                  Flora121TextView(text: "Sign In", color: "#FFFFFF", size: 12.sp,fontWeight: FontWeight.bold,),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 62.h,
            margin: EdgeInsets.only(top: 26.h),
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Flora121ImagesView(imagesName: "home14",width: double.infinity,height: double.infinity,),
                Container(
                  margin: EdgeInsets.only(left: 5.w,right: 5.w),
                  child: MasonryGridView.count(
                    padding: const EdgeInsets.all(0),
                    itemCount: 7,
                    shrinkWrap: true,
                    crossAxisCount: 7,
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 0,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return _signItemWidget(index,baseCon.signList[index]);
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _signItemWidget(int index, Flora121SignBean bean)=>Flora121Click(
    onTap: (){
      baseCon.clickSignItem(index,bean);
    },
    child: Container(
      margin: EdgeInsets.only(top: 8.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              height: 6.h,
              margin: EdgeInsets.only(top: 20.h),
              color: index==0?Colors.transparent:"#FFFFFF".toColor(),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    width: 30.w,
                    height: 30.w,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 8.w),
                    decoration: BoxDecoration(
                      color: "#FFFFFF".toColor(),
                      borderRadius: BorderRadius.circular(15.w),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Visibility(
                          visible: bean.signedTimer?.isNotEmpty==true,
                          child: Container(
                            width: 28.w,
                            height: 28.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14.w),
                              color: "#FFE524".toColor(),
                            ),
                          ),
                        ),
                        Flora121ImagesView(imagesName: "icon_money",width: 30.w,height: 30.w,),
                        Visibility(
                          visible: bean.signedTimer?.isNotEmpty==true,
                          child: Container(
                            width: 26.w,
                            height: 26.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13.w),
                              color: "#020202".toColor().withOpacity(0.4),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: bean.signedTimer?.isNotEmpty==true,
                          child: Flora121ImagesView(imagesName: "icon_gou",width: 10.w,height: 8.h,),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 16.w,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 2.w,right: 2.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.w),
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: ["#F0FF8C".toColor(),"#CAE60E".toColor(),]
                      ),
                      border: Border.all(
                        width: 1.w,
                        color: "#FFFFFF".toColor(),
                      ),
                    ),
                    child: Flora121TextView(text: "\$${bean.addNum??0}", color: "#0D4611", size: 10.sp,fontWeight: FontWeight.bold,),
                  ),
                ],
              ),
              Flora121TextView(text: "Day${bean.day}", color: "#FFFFFF", size: 10.sp,outlineColor: "#924230",),
            ],
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              height: 6.h,
              margin: EdgeInsets.only(top: 20.h),
              color: index==6?Colors.transparent:"#FFFFFF".toColor(),
            ),
          ),
        ],
      ),
    ),
  );

  _rewardTipsWidget()=> GetBuilder<Flora121HomeChildConB>(
    id: "reward_tips",
    builder: (_){
      if(null==baseCon.rewardTipsOffset){
        return Container();
      }
      var dx = baseCon.rewardTipsOffset?.dx??0;
      var dy = baseCon.rewardTipsOffset?.dy??0;
      return Container(
        margin: EdgeInsets.only(left: dx,top: dy-20.h),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Flora121ImagesView(imagesName: "home9",width: 90.w,height: 19.h,),
            Flora121TextView(text: "Reward ready to claim", color: "#0D4611", size: 8.sp,fontWeight: FontWeight.bold,),
          ],
        ),
      );
    },
  );

  _bottomCardWidget()=>Container(
    width: double.infinity,
    height: 110.h,
    margin: EdgeInsets.only(left: 12.w,right: 12.w),
    child: GetBuilder<Flora121HomeChildConB>(
      id: "store",
      builder: (_)=>ListView.builder(
        itemCount: baseCon.storeList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context,index){
          var bean = baseCon.storeList[index];
          return Flora121Click(
            onTap: (){
              baseCon.clickStore(bean);
            },
            child: Container(
              width: 216.w,
              height: 110.h,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(right: 16.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.w),
                color: "#F8FFF8".toColor(),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 72.w,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 72.w,
                          height: 50.w,
                          alignment: Alignment.centerRight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(30.w),
                              topRight: Radius.circular(30.w),
                            ),
                            color: "#80B640".toColor(),
                          ),
                          child: Container(
                            width: 46.w,
                            height: 46.w,
                            margin: EdgeInsets.only(right: 2.w),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1.w,
                                color: "#FFFFFF".toColor(),
                              ),
                              borderRadius: BorderRadius.circular(23.w),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(23.w),
                              child: Flora121ImagesView(imagesName: bean.head??"",width: 46.w,height: 46.w,ext: "png",),
                            ),
                          ),
                        ),
                        SizedBox(height: 6.h,),
                        Container(
                          margin: EdgeInsets.only(left: 6.w),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flora121TextView(text: bean.name??"", color: "#0D4611", size: 14.sp,fontWeight: FontWeight.bold,),
                              Flora121TextView(text: bean.type??"", color: "#8DB990", size: 10.sp,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis,)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(6.w),
                      child: Flora121TextView(text: bean.storyEn??"", color: "#313831", size: 10.sp,overflow: TextOverflow.ellipsis,maxLines: 6,),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ),
  );

  _topUserInfoWidget()=>Row(
    children: [
      SizedBox(width: 26.w,),
      Flora121UserInfoView(),
      Spacer(),
      Flora121HealthView(),
    ],
  );
}