import 'package:flora121_base/flora121_base/flora121_base_child.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_spine_animator_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_b/flora121_activty/flora121_home_activity/flora121_dice_child/flora121_dice_con_b.dart';
import 'package:flora121_package_b/flora121_hep/flora121_storage/flora121_storage.dart';
import 'package:flora121_package_b/flora121_hep/flora121_value_utils.dart';
import 'package:flora121_package_b/flora121_view/flora121_home_top_gold_view.dart';
import 'package:flutter/material.dart';

class Flora121DiceChildB extends Flora121BaseChild<Flora121DiceConB>{
  @override
  Flora121DiceConB initBaseConFlora121() => Flora121DiceConB();

  @override
  Widget initBaseWidgetFlora121() => Stack(
    children: [
      Flora121ImagesView(imagesName: "dice_bg",width: double.infinity,height: double.infinity,),
      Column(
        children: [
          SizedBox(height: 140.h,),
          GetBuilder<Flora121DiceConB>(
            id: "gold_view",
            builder: (_)=>Visibility(
              visible: bGoldMode.getData().isNotEmpty,
              child: Flora121HomeTopGoldView(),
            ),
          ),
          SizedBox(height: 6.h,),
          _listWidget(),
          SizedBox(height: 12.h,),
          _bottomWidget(),
          SizedBox(height: 90.h,),
        ],
      ),
    ],
  );

  _listWidget()=>Expanded(
    child: GetBuilder<Flora121DiceConB>(
      id: "list",
      builder: (_)=>ListView.builder(
        reverse: true,
        itemCount: 300,
        shrinkWrap: true,
        controller: baseCon.scrollController,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context,index)=>_listItemWidget(index),
      ),
    ),
  );

  _listItemWidget(index)=>Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              _diceItemWidget(index,19, "dice_flower"),
              SizedBox(width: 252.w,),
            ],
          ),
          Row(
            children: [
              _diceItemWidget(index,18, "dice_box"),
              _diceItemWidget(index,17, "dice_money"),
              _diceItemWidget(index,16, "dice_money"),
              _diceItemWidget(index,15, "dice_box"),
            ],
          ),
          Row(
            children: [
              SizedBox(width: 252.w,),
              _diceItemWidget(index,14, "dice_money"),
            ],
          ),
          Row(
            children: [
              _diceItemWidget(index,10, "dice_money"),
              _diceItemWidget(index,11, "dice_money"),
              _diceItemWidget(index,12, "dice_money"),
              _diceItemWidget(index,13, "dice_box"),
            ],
          ),
          Row(
            children: [
              _diceItemWidget(index,9, "dice_box"),
              SizedBox(width: 252.w,),
            ],
          ),
          Row(
            children: [
              _diceItemWidget(index,8, "dice_box"),
              _diceItemWidget(index,7, "dice_money"),
              _diceItemWidget(index,6, "dice_flower"),
              _diceItemWidget(index,5, "dice_left"),
            ],
          ),
          Row(
            children: [
              SizedBox(width: 252.w,),
              _diceItemWidget(index,4, "dice_money"),
            ],
          ),
          Row(
            children: [
              _diceItemWidget(index,0, index==0?"dice_begin":"dice_money"),
              _diceItemWidget(index,1, "dice_money"),
              _diceItemWidget(index,2, "dice_box"),
              _diceItemWidget(index,3, "dice_money"),
            ],
          ),
        ],
      )
    ],
  );

  _diceItemWidget(int largeIndex,int smallIndex,icon)=>SizedBox(
    width: 84.w,
    height: 84.w,
    child: Stack(
      alignment: Alignment.center,
      children: [
        Opacity(
          opacity: baseCon.currentDiceLargeIndex>=largeIndex&&baseCon.currentDiceSmallIndex>smallIndex?0.5:1,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Flora121ImagesView(imagesName: icon,width: 70.w,height: 70.w,),
              Visibility(
                visible: icon=="dice_money",
                child: Flora121TextView(
                  text: "\$${baseCon.getOtherAddNum(largeIndex, smallIndex)}",
                  color: "#844F13",
                  size: 10.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: baseCon.currentDiceLargeIndex==largeIndex&&baseCon.currentDiceSmallIndex==smallIndex,
          child: Flora121SpineAnimatorView(
            atlasFile: "touzi-light",
            skeletonFile: "skeleton",
            animatorName: "animation",
            folder: "dice",
            width: 84.w,
            height: 84.w,
          ),
        ),
      ],
    ),
  );

  _bottomWidget()=>Stack(
    alignment: Alignment.topCenter,
    children: [
      Container(
        width: 96.w,
        height: 96.w,
        key: baseCon.diceGlobalKey,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: "#386309".toColor(),
          borderRadius: BorderRadius.circular(48.w),
        ),
        child: AnimatedBuilder(
          animation: baseCon.getAnimationListenable(),
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, baseCon.getOffsetY()),
              child: Transform.rotate(
                angle: baseCon.getAngle(),
                child: GetBuilder<Flora121DiceConB>(
                  id: "dice_result",
                  builder: (_)=>Flora121ImagesView(imagesName: baseCon.getDiceIcon(),width: 68.w,height: 68.w,),
                ),
              ),
            );
          },
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 70.h),
        child: Flora121Click(
          onTap: (){
            baseCon.clickStart();
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Flora121ImagesView(imagesName: "btn1",width: 214.w,height: 50.h,),
              Flora121TextView(text: "Roll The Dice", color: "#FFFFFF", size: 16.sp,outlineColor: "#774005",),
            ],
          ),
        ),
      ),
    ],
  );
}