import 'package:flora121_base/flora121_base/flora121_base_child.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_b/flora121_activty/flora121_home_activity/flora121_home_child/flora121_home_child_con.dart';
import 'package:flora121_package_b/flora121_bean/flora121_sign_bean.dart';
import 'package:flora121_package_b/flora121_hep/flora121_energy_utils.dart';
import 'package:flora121_package_b/flora121_view/flora121_cash_record_view.dart';
import 'package:flora121_package_b/flora121_view/flora121_energy_item_widget.dart';
import 'package:flora121_package_b/flora121_view/flora121_health_view.dart';
import 'package:flora121_package_b/flora121_view/flora121_home_top_reward_view.dart';
import 'package:flora121_package_b/flora121_view/flora121_user_info_view.dart';
import 'package:flora121_package_b/flora_enum/flora121_energy_type.dart';
import 'package:flutter/material.dart';

class Flora121HomeChild extends Flora121BaseChild<Flora121HomeChildCon>{
  @override
  Flora121HomeChildCon initBaseConFlora121() => Flora121HomeChildCon();

  @override
  Widget initBaseWidgetFlora121() => Stack(
    children: [
      Flora121ImagesView(imagesName: "home1",width: double.infinity,height: double.infinity,),
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 150.h,),
          Flora121HomeTopRewardView(),
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
    margin: EdgeInsets.only(bottom: 100.h),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _flowerWidget(),
        SizedBox(height: 10.h,),
        _flowerLevelWidget(),
        SizedBox(height: 10.h,),
        _bottomCardWidget(),
      ],
    ),
  );

  _flowerWidget()=>Stack(
    alignment: Alignment.bottomCenter,
    children: [
      Flora121ImagesView(imagesName: "home15",width: 200.w,height: 65.h,),
      Container(
        width: double.infinity,
        height: 280.h,
        margin: EdgeInsets.only(bottom: 30.h),
        child: Stack(
          children: [
            GetBuilder<Flora121HomeChildCon>(
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
                        child: Flora121ImagesView(imagesName: baseCon.getFlowerImage(),width: 100.w,),
                        // child: Flora121SpineAnimatorView(
                        //   atlasFile: "flower5",
                        //   skeletonFile: "skeleton",
                        //   animatorName: "animation",
                        //   folder: "flower5",
                        //   width: 100.w,
                        //   height: 200.h,
                        // ),
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
                    bottom: 130.h,
                    child: _energyItemWidget(
                      Flora121EnergyType.money,
                      key: baseCon.treeGlobalKey,
                    ),
                  ),
                  Positioned(
                    top: 30.h,
                    left: 90.w,
                    child: _energyItemWidget(Flora121EnergyType.water),
                  ),
                  Positioned(
                    top: 20.h,
                    right: 100.w,
                    child: _energyItemWidget(Flora121EnergyType.dice),
                  ),
                  Positioned(
                    top: 80.h,
                    right: 36.w,
                    child: _energyItemWidget(Flora121EnergyType.quiz),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      Flora121CashRecordView(),
    ],
  );

  _energyItemWidget(Flora121EnergyType type,{GlobalKey? key})=>Flora121EnergyItemWidget(
    flora121energyType: type,
    treeGlobalKey: key,
    clickItem: (){
      baseCon.clickEnergy(type);
    },
  );

  _flowerLevelWidget()=>GetBuilder<Flora121HomeChildCon>(
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
                  child: Flora121ImagesView(imagesName: "home16",width: 51.w,height: 51.w,),
                ),
              ],
            ),
            Flora121TextView(text: "Collect ${Flora121EnergyUtils.instance.getCollectSurplusNum()} bubbles to upgrade", color: "#313831", size: 12.sp,fontWeight: FontWeight.bold,),
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
      width: double.infinity,
      height: 62.h,
      margin: EdgeInsets.only(left: 12.w,right: 12.w),
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
                        Flora121ImagesView(imagesName: "icon_money",width: 20.w,height: 20.w,),
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
                    width: 16.w,
                    height: 16.w,
                    alignment: Alignment.center,
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
                    child: Flora121TextView(text: "x${bean.addNum??0}", color: "#0D4611", size: 10.sp,fontWeight: FontWeight.bold,),
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

  _rewardTipsWidget()=>GetBuilder<Flora121HomeChildCon>(
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
    child: GetBuilder<Flora121HomeChildCon>(
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
                            child: Flora121ImagesView(imagesName: bean.head??"",width: 46.w,height: 46.w,),
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