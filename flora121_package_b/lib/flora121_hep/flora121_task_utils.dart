import 'package:flora121_base/flora121_hep/flora121_event/flora121_event_utils.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_sql/flora121_base_sql_utils.dart';
import 'package:flora121_base/flora121_hep/flora121_sql/flora121_sql_name.dart';
import 'package:flora121_package_b/flora121_bean/flora121_energy_bean.dart';
import 'package:flora121_package_b/flora121_bean/flora121_sign_bean.dart';
import 'package:flora121_package_b/flora121_bean/flora121_task_bean.dart';
import 'package:flora121_package_b/flora121_hep/flora121_event_code.dart';

class TaskType{
  static const water="water";
  static const fertilizer="fertilizer";
  static const suns="suns";
}

class Flora121TaskUtils{
  static final Flora121TaskUtils _utils = Flora121TaskUtils();
  static Flora121TaskUtils get instance => _utils;

  final List<Flora121TaskBean> _taskList=[
    Flora121TaskBean(taskText: "💧 Water 3 times today = +10 Health!",currentPro: 0,totalPro: 3,healthReward: 10,taskType: TaskType.water),
    Flora121TaskBean(taskText: "Water Wizard Challenge: 💧x5 = +15 Health!",currentPro: 0,totalPro: 5,healthReward: 15,taskType: TaskType.water),
    Flora121TaskBean(taskText: "Apply Fertilizer 🌱 2 times = +20 Health!",currentPro: 0,totalPro: 2,healthReward: 20,taskType: TaskType.fertilizer),
    Flora121TaskBean(taskText: "Feed Your Plant 2 Times 🌱 Reward: +20 Health",currentPro: 0,totalPro: 2,healthReward: 20,taskType: TaskType.fertilizer),
    Flora121TaskBean(taskText: "Challenge: Bask in 2 Suns ☀️ Reward: 30 Health",currentPro: 0,totalPro: 2,healthReward: 30,taskType: TaskType.suns),
    Flora121TaskBean(taskText: "Good Morning! ☀️ Give 3 suns = +30 Plant Power!",currentPro: 0,totalPro: 3,healthReward: 30,taskType: TaskType.suns),
  ];

  randomTodayTask()async{
    var timeStr = getTodayTimeStr();
    var database = await Flora121BaseSqlUtils.instance.initSql();
    var list = await database.query(Flora121SqlName.aTask,where: 'timeStr = ?',whereArgs: [timeStr]);
    if(list.isEmpty){
      Flora121TaskBean bean = _taskList.random();
      bean.timeStr=timeStr;
      var i = await database.insert(Flora121SqlName.aTask, bean.toJson());
    }
  }

  Future<Flora121TaskBean?> getTodayTask()async{
    var timeStr = getTodayTimeStr();
    var database = await Flora121BaseSqlUtils.instance.initSql();
    var list = await database.query(Flora121SqlName.aTask,where: 'timeStr = ?',whereArgs: [timeStr]);
    if(list.isEmpty){
      return null;
    }
    return Flora121TaskBean.fromJson(list.first);
  }

  updateTaskByEnergy(Flora121EnergyBean bean)async{
    var todayTask = await getTodayTask();
    if(null==todayTask){
      return;
    }
    if(bean.taskType!=todayTask.taskType){
      return;
    }
    todayTask.currentPro=(todayTask.currentPro??0)+1;
    if((todayTask.currentPro??0)>(todayTask.totalPro??0)){
      todayTask.currentPro=todayTask.totalPro;
    }
    var timeStr = getTodayTimeStr();
    var database = await Flora121BaseSqlUtils.instance.initSql();
    var list = await database.query(Flora121SqlName.aTask,where: 'timeStr = ?',whereArgs: [timeStr]);
    if(list.isEmpty){
      return;
    }
    await database.update(Flora121SqlName.aTask,todayTask.toJson(),where: 'timeStr = ?',whereArgs: [timeStr]);
    print("kk======updateTaskByEnergy=");
    Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.updateTask);
  }

  updateTaskBySign(Flora121SignBean bean)async{
    var todayTask = await getTodayTask();
    if(null==todayTask){
      return;
    }
    if(bean.signType!=todayTask.taskType){
      return;
    }
    todayTask.currentPro=(todayTask.currentPro??0)+(bean.addNum??0);
    if((todayTask.currentPro??0)>(todayTask.totalPro??0)){
      todayTask.currentPro=todayTask.totalPro;
    }
    var timeStr = getTodayTimeStr();
    var database = await Flora121BaseSqlUtils.instance.initSql();
    var list = await database.query(Flora121SqlName.aTask,where: 'timeStr = ?',whereArgs: [timeStr]);
    if(list.isEmpty){
      return;
    }
    await database.update(Flora121SqlName.aTask,todayTask.toJson(),where: 'timeStr = ?',whereArgs: [timeStr]);
    print("kk======updateTaskBySign=");
    Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.updateTask);
  }

  updateTaskByType(String taskType,int addNum)async{
    var todayTask = await getTodayTask();
    if(null==todayTask){
      return;
    }
    if(taskType!=todayTask.taskType){
      return;
    }
    todayTask.currentPro=(todayTask.currentPro??0)+addNum;
    if((todayTask.currentPro??0)>(todayTask.totalPro??0)){
      todayTask.currentPro=todayTask.totalPro;
    }
    var timeStr = getTodayTimeStr();
    var database = await Flora121BaseSqlUtils.instance.initSql();
    var list = await database.query(Flora121SqlName.aTask,where: 'timeStr = ?',whereArgs: [timeStr]);
    if(list.isEmpty){
      return;
    }
    await database.update(Flora121SqlName.aTask,todayTask.toJson(),where: 'timeStr = ?',whereArgs: [timeStr]);
    print("kk======updateTaskByType=");
    Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.updateTask);
  }

  resetTodayTask()async{
    var timeStr = getTodayTimeStr();
    var database = await Flora121BaseSqlUtils.instance.initSql();
    Flora121TaskBean bean = _taskList.random();
    bean.timeStr=timeStr;
    await database.update(Flora121SqlName.aTask, bean.toJson(),where: 'timeStr = ?',whereArgs: [timeStr]);
  }
}