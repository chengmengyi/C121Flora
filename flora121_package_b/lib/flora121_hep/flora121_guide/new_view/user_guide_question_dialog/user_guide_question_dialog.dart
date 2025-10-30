import 'package:flora121_base/flora121_base/flora121_base_dialog.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_b/flora121_bean/flora121_user_guide_question_bean.dart';
import 'package:flora121_package_b/flora121_hep/flora121_guide/new_view/user_guide_question_dialog/user_guide_question_controller.dart';
import 'package:flutter/material.dart';

class UserGuideQuestionDialog extends Flora121BaseDialog<UserGuideQuestionController>{
  Function() dismissCallback;
  UserGuideQuestionDialog({
    required this.dismissCallback,
});

  @override
  UserGuideQuestionController initBaseConFlora121() => UserGuideQuestionController();

  @override
  Widget initBaseWidgetFlora121() => Container(
    width: double.infinity,
    margin: EdgeInsets.only(left: 34.w,right: 34.w),
    decoration: BoxDecoration(
      color: "#80B640".toColor(),
      borderRadius: BorderRadius.circular(20.w),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _titleWidget(),
        _contentWidget(),
      ],
    ),
  );

  _contentWidget()=>Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.w),
    decoration: BoxDecoration(
      color: "#F9FFF2".toColor(),
      borderRadius: BorderRadius.circular(20.w),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _question1Widget(),
        SizedBox(height: 20.h,),
        Flora121Click(
          onTap: (){
            baseCon.clickSkip(dismissCallback,"submit");
          },
          child: Container(
            width: double.infinity,
            height: 50.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: "#4C7D0A".toColor(),
              borderRadius: BorderRadius.circular(16.w),
            ),
            child: Flora121TextView(text: "Submit", color: "#FFFFFF", size: 16.sp,fontWeight: FontWeight.bold,),
          ),
        ),
        SizedBox(height: 12.h,),
        Flora121Click(
          onTap: (){
            baseCon.clickSkip(dismissCallback,"skip");
          },
          child: Flora121TextView(
            text: "Skip",
            color: "#4C7D0A",
            size: 12.sp,
            decoration: TextDecoration.underline,
            decorationColor: "#4C7D0A".toColor(),
          ),
        ),
      ],
    ),
  );

  _question1Widget()=>GetBuilder<UserGuideQuestionController>(
    id: "question",
    builder: (_)=>ListView.builder(
      itemCount: baseCon.list.length,
      shrinkWrap: true,
      itemBuilder: (context,index){
        var bean = baseCon.list[index];
        return Container(
          margin: EdgeInsets.only(top: 3.h,bottom: 3.h),
          padding: EdgeInsets.only(left: 8.w,right: 8.w,top: 8.h),
          decoration: BoxDecoration(
            color: "#FFFFFF".toColor(),
            borderRadius: BorderRadius.circular(6.w),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              bean.questionWidget,
              index<2?_answerWidget1(bean):_answerWidget2(bean),
            ],
          ),
        );
      },
    ),
  );

  _answerWidget1(Flora121UserGuideQuestionBean bean)=>SizedBox(
    width: double.infinity,
    height: 25.h,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: bean.answerList.length,
      itemBuilder: (context,index)=>Flora121Click(
        onTap: (){
          baseCon.clickAnswer(bean,index);
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flora121ImagesView(imagesName: bean.chooseIndex==index?"icon_sel3":"icon_uns3",width: 12.w,height: 12.w,),
            SizedBox(width: 4.w,),
            Flora121TextView(text: bean.answerList[index], color: "#323F2C", size: 12.sp,),
            SizedBox(width: 6.w,),
          ],
        ),
      ),
    ),
  );

  _answerWidget2(Flora121UserGuideQuestionBean bean)=>ListView.builder(
    shrinkWrap: true,
    itemCount: bean.answerList.length,
    itemBuilder: (context,index)=>Flora121Click(
      onTap: (){
        baseCon.clickAnswer(bean,index);
      },
      child: Container(
        margin: EdgeInsets.only(top: 1.h,bottom: 1.h),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flora121ImagesView(imagesName: bean.chooseIndex==index?"icon_sel3":"icon_uns3",width: 12.w,height: 12.w,),
            SizedBox(width: 4.w,),
            Expanded(
              child: Flora121TextView(text: bean.answerList[index], color: "#323F2C", size: 12.sp,),
            ),
          ],
        ),
      ),
    ),
  );

  _titleWidget()=>Container(
    margin: EdgeInsets.only(left: 16.w,top: 16.h,bottom: 16.h),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flora121TextView(text: "New user", color: "#0D4611", size: 24.sp,fontWeight: FontWeight.bold,),
        Flora121TextView(text: "Welcome questionnaire", color: "#0D4611", size: 24.sp,fontWeight: FontWeight.bold,),
      ],
    ),
  );
}