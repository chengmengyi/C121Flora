import 'dart:convert';

import 'package:flora121_base/flora121_hep/flora121_event/flora121_event_utils.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_local_info.dart';
import 'package:flora121_base/flora121_hep/flora121_sql/flora121_base_sql_utils.dart';
import 'package:flora121_base/flora121_hep/flora121_sql/flora121_sql_name.dart';
import 'package:flora121_package_b/flora121_bean/flora121_cash_task_bean.dart';
import 'package:flora121_package_b/flora121_bean/flora121_cash_task_config_bean.dart';
import 'package:flora121_package_b/flora121_hep/flora121_event_code.dart';
import 'package:flora121_package_b/flora121_hep/flora121_storage/flora121_storage.dart';
import 'package:flora121_package_b/flora_enum/flora121_cash_task_type.dart';

class Flora121CashTaskUtils{
  static final Flora121CashTaskUtils _utils=Flora121CashTaskUtils();
  static Flora121CashTaskUtils get instance => _utils;

  Flora121CashTaskConfigBean? _taskConfigBean;

  initCashTaskBean(){
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

  Future<bool> createCashTask({
    required int cashMoney,
    required String cashType,
    required String account,
  })async{
    var database = await Flora121BaseSqlUtils.instance.initSql();
    var list = await database.query(Flora121SqlName.bCashTask,where: '"cashMoney" = ? AND "cashType" = ?',whereArgs: [cashMoney,cashType]);
    if(list.isNotEmpty){
      return false;
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
    return true;
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
    var database = await Flora121BaseSqlUtils.instance.initSql();
    var list = await database.query(Flora121SqlName.bCashTask);
    if(list.isEmpty){
      return;
    }
    for (var value in list) {
      var taskBean = Flora121CashTaskBean.fromJson(value);
      var totalList = getCashTaskTotalList(taskBean);
      var totalIndex = totalList.indexWhere((value)=>value.taskName==taskName);
      var currentList = getCashTaskCurrentList(taskBean);
      var currentIndex = currentList.indexWhere((value)=>value.taskName==taskName);
      if(totalIndex>=0&&currentIndex>=0){
        var totalTask = totalList[totalIndex];
        var currentTask = currentList[currentIndex];
        if(taskBean.cashTaskIndex==Flora121CashTaskIndex.tasks5&&checkCompletedCurrentTask(currentList, totalList)){
          continue;
        }
        currentTask.taskNum=(currentTask.taskNum??0)+1;
        if((currentTask.taskNum??0)>(totalTask.taskNum??0)){
          currentTask.taskNum=totalTask.taskNum;
        }
        if(checkCompletedCurrentTask(currentList, totalList)){
          if(taskBean.cashTaskIndex==Flora121CashTaskIndex.tasks5){
            taskBean.currentProgress=jsonEncode(currentList);
          }else{
            var nextCashTaskIndex = getNextCashTaskIndex(taskBean.cashTaskIndex);
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
  }

  deleteCashTask(Flora121CashTaskBean? taskBean)async{
    var database = await Flora121BaseSqlUtils.instance.initSql();
    var list = await database.query(Flora121SqlName.bCashTask,where: '"cashMoney" = ? AND "cashType" = ?',whereArgs: [taskBean?.cashMoney,taskBean?.cashType]);
    if(list.isEmpty){
      return;
    }
    await database.delete(Flora121SqlName.bCashTask,where: '"id" = ?',whereArgs: [list.first["id"]]);
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
      case Flora121CashTaskIndex.tasks3: return _taskConfigBean?.task3;
      case Flora121CashTaskIndex.tasks4: return _taskConfigBean?.task4;
      default: return _taskConfigBean?.task5;
    }
  }

  String getNextCashTaskIndex(String? currentIndex){
    switch(currentIndex){
      case Flora121CashTaskIndex.tasks1: return Flora121CashTaskIndex.tasks2;
      case Flora121CashTaskIndex.tasks2: return Flora121CashTaskIndex.tasks3;
      case Flora121CashTaskIndex.tasks3: return Flora121CashTaskIndex.tasks4;
      case Flora121CashTaskIndex.tasks4: return Flora121CashTaskIndex.tasks5;
      default: return Flora121CashTaskIndex.tasks5;
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
}