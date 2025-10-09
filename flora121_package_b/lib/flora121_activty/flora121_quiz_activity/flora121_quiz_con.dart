import 'dart:async';
import 'dart:convert';
import 'package:flora121_base/flora121_base/flora121_base_con.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_local_info.dart';
import 'package:flora121_base/flora121_hep/flora121_music_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_ad_enum.dart';
import 'package:flora121_package_b/flora121_bean/flora121_quiz_bean.dart';
import 'package:flora121_package_b/flora121_bean/flora121_quiz_wheel_reward_bean.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_common_get_dialog/flora121_common_get_dialog.dart';
import 'package:flora121_package_b/flora121_hep/flora121_cash_task_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_quiz_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_value_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_wheel_utils.dart';
import 'package:flora121_package_b/flora_enum/flora121_cash_task_type.dart';
import 'package:flutter/material.dart';

class Flora121QuizCon extends Flora121BaseCon{
  var wheelRewardIndex=-1,canClick=true,answerRightNum=0;
  List<Flora121QuizBean> quizList=[];
  Flora121QuizBean? quizBean;
  List<String> rewardStatusList=[];
  ScrollController scrollController=ScrollController();
  GlobalKey answerAGlobalKey=GlobalKey();
  GlobalKey answerBGlobalKey=GlobalKey();
  Timer? _timer;
  Offset? offset;

  final List<String> _bottomTextList=[
    "Treasure awaits your answer!",
    "Every quiz is a key to rewards!",
    "Crack the question, unlock the gold!",
    "Your brain is the treasure map!",
    "Answer right, claim your fortune!",
    "Spin your knowledge into prizes!",
    "Every tap brings hidden gems!",
    "Quiz your way to glory!",
    "Smart moves unlock treasures!",
    "One answer could change your luck!",
  ];

  @override
  void onInit() {
    super.onInit();
    _initQuiz();
  }

  clickAnswerItem(int index)async{
    if(!canClick){
      return;
    }
    offset=null;
    update(["finger"]);
    _stopTimer();
    canClick=false;
    quizBean?.selectedAnswer=index==0?"a":"b";
    update(["answer_list"]);
    await Future.delayed(Duration(milliseconds: 1000));
    canClick=true;
    var result = quizBean?.selectedAnswer==quizBean?.answer;
    if(result==true){
      Flora121CashTaskUtils.instance.updateCashTaskProgress(Flora121CashTaskType.quiz);
      answerRightNum++;
      if(answerRightNum%3==0){
        Flora121WheelUtils.instance.updateWheelNum(1);
        wheelRewardIndex++;
        try{
          if(rewardStatusList[wheelRewardIndex]==Flora121QuizWheelRewardType.none){
            rewardStatusList[wheelRewardIndex]=Flora121QuizWheelRewardType.unReceived;
            Flora121QuizUtils.instance.updateTodayRecord(rewardStatusList);
            update(["progress"]);
          }
        }catch(e){

        }
      }
      Flora121RoutersHep.dialog(
        child: Flora121CommonGetDialog(
          addNum: Flora121ValueUtils.instance.getQuizAddNum(),
          rvAdEnum: Flora121AdEnum.frfcn_quiz_rv,
          intAdEnum: Flora121AdEnum.frfcn_quiz_int,
          fromQuiz: true,
          dismissCallback: (received){
            _updateNextQuiz(result);
          },
        ),
      );
    }else{
      Flora121MusicHep.instance.playOtherAudio(AudioName.fail);
      _updateNextQuiz(result);
    }
  }

  _updateNextQuiz(bool result){
    quizBean?.selectedAnswer=null;
    quizBean=quizList.random();
    // wheelRewardIndex=(answerRightNum~/3)-1;
    // var lastIndexWhere = rewardStatusList.lastIndexWhere((value)=>value!=Flora121QuizWheelRewardType.none);
    // if(lastIndexWhere>=0){
    //   scrollController.animateTo(
    //     lastIndexWhere*(64.w),
    //     duration: const Duration(milliseconds: 500),
    //     curve: Curves.easeInOut,
    //   );
    // }
    update(["answer_list","quiz_content",]);
    if(result){
      update(["bottom_text"]);
    }
    _startTimer();
  }

  clickWheelItem(int index){
    var status = rewardStatusList[index];
    if(status==Flora121QuizWheelRewardType.unReceived){
      Flora121RoutersHep.dialog(
        child: Flora121CommonGetDialog(
          addNum: Flora121ValueUtils.instance.getQuizWheelAddNum(),
          rvAdEnum: Flora121AdEnum.frfcn_quiz_rv,
          intAdEnum: Flora121AdEnum.frfcn_quiz_int,
          fromQuiz: true,
          dismissCallback: (received){
            if(received){
              rewardStatusList[index]=Flora121QuizWheelRewardType.received;
              Flora121QuizUtils.instance.updateTodayRecord(rewardStatusList);
              update(["progress"]);
            }
          },
        ),
      );
    }
  }

  String getBottomText()=>_bottomTextList.random();

  bool? getAnswerItemResult(int index){
    if(null==quizBean?.selectedAnswer){
      return null;
    }
    var result = quizBean?.selectedAnswer==quizBean?.answer;
    if(quizBean?.selectedAnswer=="a"&&index==0){
      return result;
    }
    if(quizBean?.selectedAnswer=="b"&&index==1){
      return result;
    }
    return null;
  }

  _initQuiz()async{
    try{
      var list = jsonDecode(Flora121LocalInfo.localQuizStrBase64.base64());

      for(var value in list){
        quizList.add(Flora121QuizBean.fromJson(value));
      }
      quizList.shuffle();
      if(quizList.isNotEmpty){
        quizBean=quizList.random();
      }
      var size = quizList.length~/3;
      if(size>0){
        var result = await Flora121QuizUtils.instance.queryTodayRecord();
        rewardStatusList.clear();
        if(result.isEmpty){
          while(rewardStatusList.length<size){
            rewardStatusList.add(Flora121QuizWheelRewardType.none);
          }
        }else{
          rewardStatusList.addAll(result);
        }
        wheelRewardIndex = rewardStatusList.lastIndexWhere((value)=>value!=Flora121QuizWheelRewardType.none);
        Flora121QuizUtils.instance.insertTodayRecord(rewardStatusList);
        update(["progress"]);
      }
      _startTimer();
    }catch(e){

    }
  }

  _startTimer(){
    _timer=Timer(Duration(milliseconds: 2000), (){
      var key = quizBean?.answer=="a"?answerAGlobalKey:answerBGlobalKey;
      var renderBox = key.currentContext?.findRenderObject() as RenderBox;
      offset = renderBox.localToGlobal(Offset.zero);
      update(["finger"]);
    });
  }

  _stopTimer(){
    _timer?.cancel();
    _timer=null;
  }

  @override
  void onClose() {
    _stopTimer();
    scrollController.dispose();
    super.onClose();
  }
}