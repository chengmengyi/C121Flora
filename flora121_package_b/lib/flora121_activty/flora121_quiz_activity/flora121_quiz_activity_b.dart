import 'package:flora121_base/flora121_base/flora121_base_activity.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_b/flora121_activty/flora121_quiz_activity/flora121_quiz_con_b.dart';
import 'package:flora121_package_b/flora121_bean/flora121_quiz_wheel_reward_bean.dart';
import 'package:flora121_package_b/flora121_view/flora121_finger_view.dart';
import 'package:flora121_package_b/flora121_view/flora121_money_animator_widget.dart';
import 'package:flora121_package_b/flora121_view/flora121_top_money_view.dart';
import 'package:flutter/material.dart';

class Flora121QuizActivityB extends Flora121BaseActivity<Flora121QuizConB>{
  @override
  Flora121QuizConB initBaseConFlora121() => Flora121QuizConB();

  @override
  Widget initBaseWidgetFlora121() => Stack(
    children: [
      Container(
        width: double.infinity,
        height: double.infinity,
        color: "#000000".toColor().withOpacity(0.7),
      ),
      Column(
        children: [
          Flora121TopMoneyView(),
          _quizWidget(),
        ],
      ),
      Align(
        alignment: Alignment.topCenter,
        child: Flora121MoneyAnimatorWidget(
          fromQuiz: true,
        ),
      ),
      _fingerWidget(),
    ],
  );

  _quizWidget()=>Expanded(
    child: Container(
      width: double.infinity,
      height: double.infinity,
      margin: EdgeInsets.only(top: 66.h),
      decoration: BoxDecoration(
        color: "#F3FFE5".toColor(),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.w),
          topRight: Radius.circular(20.w),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flora121Click(
                onTap: (){
                  Flora121RoutersHep.back();
                },
                child: Container(
                  width: 44.w,
                  height: 44.w,
                  alignment: Alignment.center,
                  child: Flora121ImagesView(imagesName: "icon_close2",width: 14.w,height: 14.w,),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 15.w,right: 15.w,bottom: 15.h),
              child: Column(
                children: [
                  _progressWidget(),
                  SizedBox(height: 18.h,),
                  _quizContentWidget(),
                  SizedBox(height: 30.h,),
                  _bottomWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );

  _progressWidget()=>Container(
    width: double.infinity,
    height: 50.h,
    alignment: Alignment.centerLeft,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.w),
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: ["#F8FF92".toColor(),"#B8DE60".toColor(),]
      ),
    ),
    child: GetBuilder<Flora121QuizConB>(
      id: "progress",
      builder: (_)=>ListView.builder(
        itemCount: baseCon.rewardStatusList.length,
        scrollDirection: Axis.horizontal,
        controller: baseCon.scrollController,
        itemBuilder: (context,index)=>_progressItemWidget(index,baseCon.rewardStatusList[index]),
      ),
    ),
  );

  _progressItemWidget(index, String bean,){
    var isFirst = index==0;
    var isLast = index==baseCon.rewardStatusList.length-1;
    return Flora121Click(
      onTap: (){
        baseCon.clickWheelItem(index);
      },
      child: Stack(
        // key: bean.globalKey,
        alignment: Alignment.center,
        children: [
          Container(
            width: 64.w,
            height: 13.h,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: index==0?1.w:0,right:isLast?1.w:0),
            decoration: BoxDecoration(
              color: "#52473C".toColor(),
              borderRadius: BorderRadius.only(
                topLeft: isFirst?Radius.circular(10.w,):Radius.zero,
                bottomLeft: isFirst?Radius.circular(10.w,):Radius.zero,
                topRight: isLast?Radius.circular(10.w,):Radius.zero,
                bottomRight: isLast?Radius.circular(10.w,):Radius.zero,
              ),
            ),
            child: Container(
              width: double.infinity,
              height: 11.h,
              decoration: BoxDecoration(
                gradient: baseCon.wheelRewardIndex>=index?
                LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    "#FFE100".toColor(),
                    "#D46708".toColor(),
                  ]
                ):null,
                borderRadius: BorderRadius.only(
                  topLeft: isFirst?Radius.circular(10.w,):Radius.zero,
                  bottomLeft: isFirst?Radius.circular(10.w,):Radius.zero,
                  topRight: isLast?Radius.circular(10.w,):Radius.zero,
                  bottomRight: isLast?Radius.circular(10.w,):Radius.zero,
                ),
              ),
            ),
          ),
          Flora121ImagesView(imagesName: bean==Flora121QuizWheelRewardType.unReceived?"icon_wheel_sel":"icon_wheel_uns",width: 47.w,height: 47.h,),
        ],
      ),
    );
  }

  _quizContentWidget()=>Expanded(
    child: Stack(
      children: [
        Flora121ImagesView(imagesName: "quiz1",width: double.infinity,height: double.infinity,),
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(left: 23.w,right: 23.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flora121ImagesView(imagesName: "quiz2",width: 180.w,height: 34.h,),
              SizedBox(height: 20.h,),
              Stack(
                children: [
                  Flora121ImagesView(imagesName: "quiz3",width: double.infinity,height: 133.h,),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    margin: EdgeInsets.only(left: 10.w,right: 10.w,top: 10.h),
                    decoration: BoxDecoration(
                      color: "#FFFFFF".toColor().withOpacity(0.9),
                      borderRadius: BorderRadius.circular(10.w),
                    ),
                    child: GetBuilder<Flora121QuizConB>(
                      id: "quiz_content",
                      builder: (_)=>Flora121TextView(text: baseCon.quizBean?.question??"", color: "#284702", size: 16.sp,fontWeight: FontWeight.bold,),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h,),
              MediaQuery.removePadding(
                removeTop: true,
                context: baseCon.context,
                child: GetBuilder<Flora121QuizConB>(
                  id: "answer_list",
                  builder: (_)=>ListView.builder(
                    itemCount: 2,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context,index){
                      var result = baseCon.getAnswerItemResult(index);
                      return Flora121Click(
                        onTap: (){
                          baseCon.clickAnswerItem(index);
                        },
                        child: Container(
                          width: double.infinity,
                          height: 50.h,
                          key: index==0?baseCon.answerAGlobalKey:baseCon.answerBGlobalKey,
                          margin: EdgeInsets.only(top: 6.h,bottom: 6.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.w),
                          ),
                          child: Stack(
                            children: [
                              Flora121ImagesView(imagesName: result==null?"quiz4":result==true?"quiz5":"quiz6",width: double.infinity,height: 50.h,),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  margin: EdgeInsets.only(left: 16.w),
                                  child: Flora121TextView(text: index==0?"A":"B", color: null==result?"#886A32":"#FFFFFF", size: 24.sp,fontWeight: FontWeight.bold,),
                                ),
                              ),
                              Align(
                                child: Flora121TextView(text: (index==0?baseCon.quizBean?.a:baseCon.quizBean?.b)??"", color: null==result?"#886A32":"#FFFFFF", size: 16.sp,),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  margin: EdgeInsets.only(right: 20.w),
                                  child: Visibility(
                                    visible: null!=result,
                                    child: Flora121ImagesView(imagesName: result==true?"quiz7":"quiz8",height: 23.h,fit: BoxFit.fitHeight,),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    ),
  );
  
  _bottomWidget()=>GetBuilder<Flora121QuizConB>(
    id: "bottom_text",
    builder: (_)=>Flora121TextView(
      text: baseCon.getBottomText(),
      color: "#F9BC03",
      size: 17.sp,
      fontFamily: "saf",
      outlineColor: "#253D04",
    ),
  );

  _fingerWidget()=>GetBuilder<Flora121QuizConB>(
    id: "finger",
    builder: (_){
      var offset = baseCon.offset;
      if(null==offset){
        return Container();
      }
      var dx = offset.dx+200.w;
      var dy = offset.dy+25.h;
      return Container(
        margin: EdgeInsets.only(top: dy,left: dx),
        child: Flora121Click(
          onTap: (){
            baseCon.clickAnswerItem(baseCon.quizBean?.answer=="a"?0:1);
          },
          child: Flora121FingerView(),
        ),
      );
    },
  );
}