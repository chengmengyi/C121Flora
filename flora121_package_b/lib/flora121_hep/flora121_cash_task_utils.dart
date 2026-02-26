import 'dart:convert';
import 'dart:math';

import 'package:flora121_base/flora121_hep/flora121_event/flora121_event_utils.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_firebase_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_local_info.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_sql/flora121_base_sql_utils.dart';
import 'package:flora121_base/flora121_hep/flora121_sql/flora121_sql_name.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_point_enum.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_ttt.dart';
import 'package:flora121_package_b/flora121_bean/flora121_cash_rank_bean.dart';
import 'package:flora121_package_b/flora121_bean/flora121_cash_task_bean.dart';
import 'package:flora121_package_b/flora121_bean/flora121_cash_task_config_bean.dart';
import 'package:flora121_package_b/flora121_bean/flora121_gold_progress_bean.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_cash_success_dialog/flora121_cash_success_dialog.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_cash_task_dialog/flora121_cash_task_dialog.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_completed_cash_task_dialog/flora121_completed_cash_task_dialog.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_donot_worry_dialog/flora121_donot_worry_dialog.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_gold_dialog/flora121_completed_gold_and_diamond_task_dialog/flora121_completed_gold_and_diamond_task_dialog.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_gold_dialog/flora121_completed_gold_task_dialog/flora121_completed_gold_task_dialog.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_gold_dialog/flora121_gold_step1_dialog/flora121_gold_step1_dialog.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_gold_dialog/flora121_gold_step2_dialog/flora121_gold_step2_dialog.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_gold_dialog/flora121_gold_step3_dialog/flora121_gold_step3_dialog.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_gold_dialog/flora121_gold_step4_dialog/flora121_gold_step4_dialog.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_input_email_dialog/flora121_input_email_dialog.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_input_phone_dialog/flora121_input_phone_dialog.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_input_pix_dialog/flora121_input_pix_dialog.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_transfer_funds_dialog/flora121_transfer_funds_dialog.dart';
import 'package:flora121_package_b/flora121_hep/flora121_event_code.dart';
import 'package:flora121_package_b/flora121_hep/flora121_routers.dart';
import 'package:flora121_package_b/flora121_hep/flora121_storage/flora121_storage.dart';
import 'package:flora121_package_b/flora121_hep/flora121_user_info_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_value_utils.dart';
import 'package:flora121_package_b/flora_enum/flora121_cash_task_type.dart';
import 'package:flora121_package_b/flora_enum/flora121_cash_type.dart';

class Flora121GoldMode{
  static const String gold="gold";
  static const String diamond="diamond";
}

class Flora121CashTaskUtils{
  static final Flora121CashTaskUtils _utils=Flora121CashTaskUtils();
  static Flora121CashTaskUtils get instance => _utils;

  Flora121CashTaskConfigBean? _taskConfigBean;

  initCashTaskBean(){
    _startInit();
    Flora121FirebaseHep.instance.initCashTaskConfigCall=(String value){
      if(bCashTaskConfigStr.getData().isEmpty){
        bCashTaskConfigStr.saveData(value);
        _startInit();
      }
    };
  }

  _startInit(){
    try{
      var data = bCashTaskConfigStr.getData();
      if(data.isEmpty){
        data=Flora121LocalInfo.cashTaskStrBase64.base64();
      }
      _taskConfigBean=Flora121CashTaskConfigBean.fromJson(jsonDecode(data));
    }catch(e){
      _taskConfigBean=Flora121CashTaskConfigBean.fromJson(jsonDecode(Flora121LocalInfo.cashTaskStrBase64.base64()));
    }
  }

  Future<Flora121CashTaskBean?> createCashTask({
    required int cashMoney,
    required String cashType,
    required String account,
  })async{
    var database = await Flora121BaseSqlUtils.instance.initSql();
    var list = await database.query(Flora121SqlName.bCashTask,where: '"cashMoney" = ? AND "cashType" = ?',whereArgs: [cashMoney,cashType]);
    if(list.isNotEmpty){
      return null;
    }
    var task1 = _taskConfigBean?.task1??[];
    List<Task1> currentProgressList=[];
    for (var value in task1) {
      currentProgressList.add(Task1(taskName: value.taskName,taskNum: 0));
    }
    var bean = Flora121CashTaskBean(
      cashMoney: cashMoney,
      cashType: cashType,
      cashTaskIndex: Flora121CashTaskIndex.tasks1,
      currentProgress: jsonEncode(currentProgressList),
      totalProgress: jsonEncode(task1),
      cashAccount: account,
    );
    await database.insert(Flora121SqlName.bCashTask, bean.toJson());
    Flora121UserInfoUtils.instance.updateMyMoney(-(cashMoney.toDouble()));
    return bean;
  }

  Future<Flora121CashTaskBean?> queryCashTaskByMoneyAndType({
    required int cashMoney,
    required String cashType,
  })async{
    var database = await Flora121BaseSqlUtils.instance.initSql();
    var list = await database.query(Flora121SqlName.bCashTask,where: '"cashMoney" = ? AND "cashType" = ?',whereArgs: [cashMoney,cashType]);
    if(list.isEmpty){
      return null;
    }
    return Flora121CashTaskBean.fromJson(list.first);
  }

  //Flora121CashTaskType
  updateCashTaskProgress(String taskName)async{
    if(bGoldMode.getData().isNotEmpty){
      return;
    }
    var database = await Flora121BaseSqlUtils.instance.initSql();
    var list = await database.query(Flora121SqlName.bCashTask);
    if(list.isEmpty){
      return;
    }
    Flora121CashTaskBean? completeTask1TaskBean;
    Flora121CashTaskBean? completeTask2TaskBean;
    for (var value in list) {
      var taskBean = Flora121CashTaskBean.fromJson(value);
      var totalList = getCashTaskTotalList(taskBean);
      var totalIndex = totalList.indexWhere((value)=>value.taskName==taskName);
      var currentList = getCashTaskCurrentList(taskBean);
      var currentIndex = currentList.indexWhere((value)=>value.taskName==taskName);
      if(totalIndex>=0&&currentIndex>=0){
        var totalTask = totalList[totalIndex];
        var currentTask = currentList[currentIndex];
        if(taskBean.cashTaskIndex==Flora121CashTaskIndex.tasks2&&checkCompletedCurrentTask(currentList, totalList)){
          continue;
        }
        currentTask.taskNum=(currentTask.taskNum??0)+1;
        if((currentTask.taskNum??0)>(totalTask.taskNum??0)){
          currentTask.taskNum=totalTask.taskNum;
        }
        if(checkCompletedCurrentTask(currentList, totalList)){
          if(taskBean.cashTaskIndex==Flora121CashTaskIndex.tasks2){
            taskBean.currentProgress=jsonEncode(currentList);
            completeTask2TaskBean=taskBean;
          }else{
            var nextCashTaskIndex = getNextCashTaskIndex(taskBean.cashTaskIndex);
            if(nextCashTaskIndex==Flora121CashTaskIndex.tasks2){
              completeTask1TaskBean=taskBean;
            }
            taskBean.cashTaskIndex=nextCashTaskIndex;
            var taskListByIndex = getTaskListByIndex(nextCashTaskIndex)??[];
            List<Task1> currentProgressList=[];
            for (var value in taskListByIndex) {
              currentProgressList.add(Task1(taskName: value.taskName,taskNum: 0));
            }
            taskBean.currentProgress=jsonEncode(currentProgressList);
            taskBean.totalProgress=jsonEncode(taskListByIndex);
          }
        }else{
          taskBean.currentProgress=jsonEncode(currentList);
        }
        await database.update(Flora121SqlName.bCashTask, taskBean.toJson(),where: '"id" = ?',whereArgs: [value["id"]]);
      }
    }
    Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.updateCashTask,);
    if(null!=completeTask1TaskBean){
      Flora121RoutersHep.dialog(
        child: Flora121TransferFundsDialog(
          bean: completeTask1TaskBean,
          dismissCallback: (){
            Flora121RoutersHep.dialog(
              child: Flora121DonotWorryDialog(
                dismissCallback: (){
                  Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.diamond_progress);
                  Flora121RoutersHep.dialog(
                    child: Flora121CompletedGoldTaskDialog(
                      cashMoney: completeTask1TaskBean?.cashMoney??0,
                      dismissCallback: (){
                        bGoldMode.saveData(Flora121GoldMode.diamond);
                        Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.changeToGoldMode);
                      },
                    ),
                  );
                },
              ),
            );
          },
        ),
      );
    }else if (null!=completeTask2TaskBean){
      Flora121RoutersHep.dialog(
        child: Flora121CompletedCashTaskDialog(
          dismissCallback: (){
            createRankInfo(completeTask2TaskBean?.cashMoney??0,completeTask2TaskBean?.cashType??"");
          },
        ),
      );
    }
  }

  createRankInfo(int cashMoney,String cashType)async{
    Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.cash_queue);
    var database = await Flora121BaseSqlUtils.instance.initSql();
    var list = await database.query(Flora121SqlName.bCashRankInfo,where: '"cashMoney" = ? AND "cashType" = ?',whereArgs: [cashMoney,cashType]);
    if(list.isNotEmpty){
      return;
    }
    var flora121cashRankBean = Flora121CashRankBean(cashType: cashType,cashMoney: cashMoney,currentProgress: Random().nextInt(100)+400,totalProgress: 500);
    await database.insert(Flora121SqlName.bCashRankInfo, flora121cashRankBean.toJson());
    Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.createCashRankSuccess);
    Flora121RoutersHep.toHome(str: Flora121RouterNameB.home);
    Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.showHomeTab,flora121IntValue: 3);
  }

  Future<Flora121CashRankBean?> queryRankInfo()async{
    var database = await Flora121BaseSqlUtils.instance.initSql();
    var list = await database.query(Flora121SqlName.bCashRankInfo);
    if(list.isEmpty){
      return null;
    }
    return Flora121CashRankBean.fromJson(list.first);
  }

  updateRankInfo(int cashMoney,String cashType)async{
    var database = await Flora121BaseSqlUtils.instance.initSql();
    var list = await database.query(Flora121SqlName.bCashRankInfo,where: '"cashMoney" = ? AND "cashType" = ?',whereArgs: [cashMoney,cashType]);
    if(list.isEmpty){
      return;
    }
    var first = list.first;
    var bean = Flora121CashRankBean.fromJson(first);
    var currentNum = (bean.currentProgress??0)-Flora121ValueUtils.instance.getRandomRankReduceNum();
    bean.currentProgress=currentNum<0?0:currentNum;
    await database.update(Flora121SqlName.bCashRankInfo, bean.toJson(),where: '"id" = ?',whereArgs: [first["id"]]);
  }

  deleteCashTask(Flora121CashTaskBean? taskBean)async{
    var database = await Flora121BaseSqlUtils.instance.initSql();
    var cashMoney = taskBean?.cashMoney;
    var cashType = taskBean?.cashType;
    var cashTaskList = await database.query(Flora121SqlName.bCashTask,where: '"cashMoney" = ? AND "cashType" = ?',whereArgs: [cashMoney,cashType]);
    if(cashTaskList.isNotEmpty){
      await database.delete(Flora121SqlName.bCashTask,where: '"id" = ?',whereArgs: [cashTaskList.first["id"]]);
    }
    var rankList = await database.query(Flora121SqlName.bCashRankInfo,where: '"cashMoney" = ? AND "cashType" = ?',whereArgs: [cashMoney,cashType]);
    if(rankList.isNotEmpty){
      await database.delete(Flora121SqlName.bCashRankInfo,where: '"id" = ?',whereArgs: [rankList.first["id"]]);
    }
    Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.updateCashTask,);
  }

  bool checkCompletedCurrentTask(List<Task1> currentList, List<Task1> totalList){
    if(currentList.length!=totalList.length){
      return false;
    }
    for(var index=0;index<currentList.length;index++){
      var currentTaskNum = currentList[index].taskNum??0;
      var totalTaskNum = totalList[index].taskNum??0;
      if(currentTaskNum<totalTaskNum){
        return false;
      }
    }
    return true;
  }

  List<Task1>? getTaskListByIndex(String? currentIndex){
    switch(currentIndex){
      case Flora121CashTaskIndex.tasks1: return _taskConfigBean?.task1;
      case Flora121CashTaskIndex.tasks2: return _taskConfigBean?.task2;
      default: return _taskConfigBean?.task2;
    }
  }

  String getNextCashTaskIndex(String? currentIndex){
    switch(currentIndex){
      case Flora121CashTaskIndex.tasks1: return Flora121CashTaskIndex.tasks2;
      case Flora121CashTaskIndex.tasks2: return Flora121CashTaskIndex.tasks1;
      default: return Flora121CashTaskIndex.tasks2;
    }
  }

  List<Task1> getCashTaskTotalList(Flora121CashTaskBean? taskBean){
    try{
      var s = taskBean?.totalProgress??"";
      //[{"taskName":"bubbles","taskNum":10},{"taskName":"water","taskNum":2}]
      if(s.isEmpty){
        return [];
      }
      List<Task1> list=[];
      jsonDecode(s).forEach((v) {
        list.add(Task1.fromJson(v));
      });
      return list;
    }catch(e){
      return [];
    }
  }

  List<Task1> getCashTaskCurrentList(Flora121CashTaskBean? taskBean){
    try{
      var s = taskBean?.currentProgress??"";
      //[{"taskName":"bubbles","taskNum":10},{"taskName":"water","taskNum":2}]
      if(s.isEmpty){
        return [];
      }
      List<Task1> list=[];
      jsonDecode(s).forEach((v) {
        list.add(Task1.fromJson(v));
      });
      return list;
    }catch(e){
      return [];
    }
  }

  String getCashTaskTitleStr(Task1 task){
    switch(task.taskName){
      case Flora121CashTaskType.water: return "${task.taskNum??0} water drinking";
      case Flora121CashTaskType.quiz: return "Answer ${task.taskNum??0} questions";
      case Flora121CashTaskType.dice: return "Roll the Dice ${task.taskNum??0} Times";
      case Flora121CashTaskType.wheel: return "Spin the Wheel ${task.taskNum??0} times";
      case Flora121CashTaskType.sign: return "Sign in for ${task.taskNum??0} days";
      case Flora121CashTaskType.bubbles: return "Get ${task.taskNum??0} bubbles";
      default: return "";
    }
  }

  String getCashTaskIcon(Task1 task){
    switch(task.taskName){
      case Flora121CashTaskType.water: return "task_water";
      case Flora121CashTaskType.quiz: return "task_quiz";
      case Flora121CashTaskType.dice: return "task_dice";
      case Flora121CashTaskType.wheel: return "task_wheel";
      case Flora121CashTaskType.sign: return "task_sign";
      case Flora121CashTaskType.bubbles: return "task_bubble";
      default: return "task_water";
    }
  }

  String getCashTaskPro(Task1 task,List<Task1> currentList){
    var indexWhere = currentList.indexWhere((value)=>value.taskName==task.taskName);
    if(indexWhere>=0){
      return "${currentList[indexWhere].taskNum??0}/${task.taskNum??0}";
    }
    return "0/${task.taskNum??0}";
  }

  bool showTaskCompletedIcon(Task1 task,List<Task1> currentList){
    var indexWhere = currentList.indexWhere((value)=>value.taskName==task.taskName);
    if(indexWhere>=0){
      var current=currentList[indexWhere].taskNum??0;
      var all = task.taskNum??0;
      return current>=all;
    }
    return false;
  }

  List<String> getCashTypeList()=>[Flora121CashType.paypal,Flora121CashType.cashApp];

  saveCashAccount(String cashType,String cashAccount)async{
    var database = await Flora121BaseSqlUtils.instance.initSql();
    var list = await database.query(Flora121SqlName.bCashAccount,where: '"cashType" = ?',whereArgs: [cashType]);
    if(list.isNotEmpty){
      return;
    }
    await database.insert(Flora121SqlName.bCashAccount, {"cashType":cashType,"cashAccount":cashAccount});
  }

  Future<String> getCashAccountByCashType(String cashType)async{
    var database = await Flora121BaseSqlUtils.instance.initSql();
    var list = await database.query(Flora121SqlName.bCashAccount,where: '"cashType" = ?',whereArgs: [cashType]);
    if(list.isEmpty){
      return "";
    }
    return list.first["cashAccount"] as String;
  }

  showAccountInputDialog({
    required int cashMoney,
    required String cashType,
    required Function(Flora121CashTaskBean? bean) createCashTaskSuccessCallback,
})async{
    var cashAccount = await Flora121CashTaskUtils.instance.getCashAccountByCashType(cashType);
    if(cashAccount.isNotEmpty){
      _inputAccountResult(cashAccount,cashMoney,cashType,createCashTaskSuccessCallback);
      return;
    }

    switch(cashType){
      case Flora121CashType.pagBank:
      case Flora121CashType.paypal:
        Flora121RoutersHep.dialog(
          child: Flora121InputEmailDialog(
            cashType: cashType,
            sureCallback: (account){
              _inputAccountResult(account,cashMoney,cashType,createCashTaskSuccessCallback);
            },
          ),
        );
        break;
      case Flora121CashType.cashApp:
        Flora121RoutersHep.dialog(
          child: Flora121InputPhoneDialog(
            cashType: cashType,
            sureCallback: (account){
              _inputAccountResult(account,cashMoney,cashType,createCashTaskSuccessCallback);
            },
          ),
        );
        break;
      case Flora121CashType.pix:
        Flora121RoutersHep.dialog(
          child: Flora121InputPixDialog(
            sureCallback: (account){
              _inputAccountResult(account,cashMoney,cashType,createCashTaskSuccessCallback);
            },
          ),
        );
        break;
    }
  }

  _inputAccountResult(String account, int money, String cashType,Function(Flora121CashTaskBean? bean) createCashTaskSuccessCallback)async{
    var bean = await Flora121CashTaskUtils.instance.createCashTask(cashMoney: money, cashType: cashType, account: account,);
    createCashTaskSuccessCallback.call(bean);
  }

  showCashTaskDialog(Flora121CashTaskBean? taskBean){
    var totalList = Flora121CashTaskUtils.instance.getCashTaskTotalList(taskBean);
    var currentList = Flora121CashTaskUtils.instance.getCashTaskCurrentList(taskBean);
    var completedCurrentTask = Flora121CashTaskUtils.instance.checkCompletedCurrentTask(currentList, totalList);
    if(completedCurrentTask){
      Flora121RoutersHep.dialog(
        child: Flora121CompletedCashTaskDialog(
          dismissCallback: (){
            createRankInfo(taskBean?.cashMoney??0,taskBean?.cashType??"");
          },
        ),
      );
      return;
    }
    Flora121RoutersHep.dialog(
      child: Flora121CashTaskDialog(
        taskBean: taskBean,
      ),
    );
  }

  showGoldStepDialog(int cashMoney){
    Flora121RoutersHep.dialog(
      child: Flora121GoldStep1Dialog(
        dismissCallback: (){
          _showGoldStep2Dialog(cashMoney);
        },
      ),
    );
  }

  _showGoldStep2Dialog(int cashMoney){
    Flora121RoutersHep.dialog(
      child: Flora121GoldStep2Dialog(
        cashMoney: cashMoney,
        clickOkCallback: (){
          _showGoldStep3Dialog(cashMoney);
        },
      ),
    );
  }

  _showGoldStep3Dialog(int cashMoney){
    Flora121RoutersHep.dialog(
      child: Flora121GoldStep3Dialog(
        cashMoney: cashMoney,
        clickOkCallback: (){
          _showGoldStep4Dialog(cashMoney);
        },
        clickCloseCallback: (){
          _showGoldStep2Dialog(cashMoney);
        },
      ),
    );
  }
  _showGoldStep4Dialog(int cashMoney){
    Flora121RoutersHep.dialog(
      child: Flora121GoldStep4Dialog(
        clickNextCallback: (){
          _changeMoneyToGold(cashMoney);
        },
        clickCloseCallback: (){
          _showGoldStep2Dialog(cashMoney);
        },
      ),
    );
  }

  //把页面所有的地方都切换为金块
  _changeMoneyToGold(int cashMoney)async{
    await insertGoldProgressData(cashMoney);
    bGoldMode.saveData(Flora121GoldMode.gold);
    Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.changeToGoldMode);
    //点击随机跳转至答题或者骰子
    Flora121RoutersHep.toHome(str: Flora121RouterNameB.home);
    if(Random().nextBool()){
      Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.showHomeTab,flora121IntValue: 1);
    }else{
      Flora121RoutersHep.toNamed(routerName: Flora121RouterNameB.quiz);
    }
  }

  insertGoldProgressData(int cashMoney)async{
    var cashType = bSelectCashType.getData();
    var database = await Flora121BaseSqlUtils.instance.initSql();
    var list = await database.query(Flora121SqlName.bGoldInfo,where: '"cashMoney" = ? AND "cashType" = ?',whereArgs: [cashMoney,cashType]);
    if(list.isNotEmpty){
      return;
    }
    var flora121goldProgressBean = Flora121GoldProgressBean(
      goldType: Flora121GoldMode.gold,
      cashMoney: cashMoney,
      cashType: cashType,
      currentProgress: 0.0,
      totalProgress: Flora121ValueUtils.instance.getGoldTotal(),
    );
    await database.insert(Flora121SqlName.bGoldInfo, flora121goldProgressBean.toJson());
  }

  Future<Flora121GoldProgressBean?> queryGoldProgress()async{
    var database = await Flora121BaseSqlUtils.instance.initSql();
    var list = await database.query(Flora121SqlName.bGoldInfo,where: '"cashType" = ?',whereArgs: [bSelectCashType.getData()]);
    if(list.isEmpty){
      return null;
    }
    return Flora121GoldProgressBean.fromJson(list.first);
  }

  updateGoldProgress(double addNum,String goldMode)async{
    var database = await Flora121BaseSqlUtils.instance.initSql();
    var list = await database.query(Flora121SqlName.bGoldInfo,where: '"goldType" = ?',whereArgs: [goldMode]);
    if(list.isEmpty){
      return;
    }
    var bean = Flora121GoldProgressBean.fromJson(list.first);
    var total = (Decimal.parse("${bean.currentProgress??0.0}")+Decimal.parse("$addNum")).toDouble();
    bool completedDiamondTask=false;
    bool completedGoldTask=false;
    if(total>=(bean.totalProgress??0.0)){
      //完成了金块任务
      if(goldMode==Flora121GoldMode.gold){
        completedGoldTask=true;
        bean.currentProgress=0.0;
        bean.totalProgress=Flora121ValueUtils.instance.getDiamondTotal();
        bean.goldType=Flora121GoldMode.diamond;
        bGoldMode.saveData("");
        Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.changeToGoldMode);
      }else{//完成了钻石任务
        completedDiamondTask=true;
      }
    }else{
      bean.currentProgress=total;
    }
    if(completedDiamondTask){
      bGoldMode.saveData("");
      Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.changeToGoldMode);
      await database.delete(Flora121SqlName.bGoldInfo,where: '"id" = ?',whereArgs: [list.first["id"]]);
      var flora121cashTaskBean = await queryCashTaskByMoneyAndType(cashMoney: bean.cashMoney??0, cashType: bean.cashType??"");
      showCashTaskDialog(flora121cashTaskBean);
    }else{
      if(completedGoldTask){
        Flora121RoutersHep.dialog(
          child: Flora121CompletedGoldAndDiamondTaskDialog(
            dismissCallback: (){
              Flora121RoutersHep.toNamed(
                routerName: Flora121RouterNameB.hasMoneyTips,
                params: {
                  "cashMoney":bean.cashMoney??0,
                  "cashType":bean.cashType??"",
                },
              );
            },
          ),
        );
      }
      await database.update(Flora121SqlName.bGoldInfo,bean.toJson(),where: '"id" = ?',whereArgs: [list.first["id"]]);
      Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.changeToGoldMode);
    }
  }

  //金额足够的页面，点击信息确认
  hasMoneyPageClickSure(int cashMoney,String cashType){
    showAccountInputDialog(
      cashMoney: cashMoney,
      cashType: cashType,
      createCashTaskSuccessCallback: (bean){
        showCashTaskDialog(bean);
      },
    );
  }
}