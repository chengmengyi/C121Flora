import 'package:flora121_base/flora121_base/flora121_base_con.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_b/flora121_bean/flora121_user_guide_question_bean.dart';
import 'package:flutter/material.dart';

class UserGuideQuestionController extends Flora121BaseCon{
  List<Flora121UserGuideQuestionBean> list=[];

  @override
  void onInit() {
    super.onInit();
    _initList();
  }

  clickAnswer(Flora121UserGuideQuestionBean bean, int index){
    bean.chooseIndex=index;
    update(["question"]);
  }

  clickSkip(Function() dismissCallback){
    Flora121RoutersHep.back();
    dismissCallback.call();
  }
  
  _initList(){
    list.clear();
    list.add(
      Flora121UserGuideQuestionBean(
        questionWidget: Flora121TextView(text: "1.Gender", color: "#000000", size: 14.sp,fontWeight: FontWeight.bold,),
        answerList: ["Female","Male","Other","Secret",],
        chooseIndex: -1,
      ),
    );
    list.add(
      Flora121UserGuideQuestionBean(
        questionWidget: Flora121TextView(text: "2.Age", color: "#000000", size: 14.sp,fontWeight: FontWeight.bold,),
        answerList: ["Under18","18-30","30-50","50+",],
        chooseIndex: -1,
      ),
    );
    list.add(
      Flora121UserGuideQuestionBean(
        questionWidget: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "3.How do you prefer ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 11.sp,
                  color: "#000000".toColor(),
                ),
              ),
              TextSpan(
                text: "earning rewards",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 11.sp,
                  color: "#EB4700".toColor(),
                ),
              ),
              TextSpan(
                text: " in the app",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 11.sp,
                  color: "#000000".toColor(),
                ),
              ),
            ],
          ),
        ),
        answerList: ["Watching short videos to earn instantly 💰","Completing daily tasks","Inviting friends",],
        chooseIndex: -1,
      ),
    );
    list.add(
      Flora121UserGuideQuestionBean(
        questionWidget: RichText(
          text: TextSpan(
            children: [
              //4.Did you know you can earn cash by watching ads?
              TextSpan(
                text: "4.Did you know you can ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 11.sp,
                  color: "#000000".toColor(),
                ),
              ),
              TextSpan(
                text: "earn cash",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 11.sp,
                  color: "#EB4700".toColor(),
                ),
              ),
              TextSpan(
                text: " by watching ads",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 11.sp,
                  color: "#000000".toColor(),
                ),
              ),
            ],
          ),
        ),
        //Yes, that’s awesome!
        // Not yet, tell me more
        // I’m not sure
        answerList: ["Yes, that’s awesome!","Not yet, tell me more","I’m not sure",],
        chooseIndex: -1,
      ),
    );
    list.add(
      Flora121UserGuideQuestionBean(
        questionWidget: RichText(
          text: TextSpan(
            children: [
              //5.Would you like to Earn Money by watching ads?
              TextSpan(
                text: "5.Would you like to ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 11.sp,
                  color: "#000000".toColor(),
                ),
              ),
              TextSpan(
                text: "Earn Money",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 11.sp,
                  color: "#EB4700".toColor(),
                ),
              ),
              TextSpan(
                text: " by watching ads?",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 11.sp,
                  color: "#000000".toColor(),
                ),
              ),
            ],
          ),
        ),
        answerList: ["Fully accept（e.g 30s ad≈\$4）","Conditional acceptance","Not over",],
        chooseIndex: -1,
      ),
    );
  }
}