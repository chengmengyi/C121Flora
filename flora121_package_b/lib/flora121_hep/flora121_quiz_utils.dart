import 'dart:convert';

import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_sql/flora121_base_sql_utils.dart';
import 'package:flora121_base/flora121_hep/flora121_sql/flora121_sql_name.dart';

class Flora121QuizUtils{
  static final Flora121QuizUtils _utils=Flora121QuizUtils();
  static Flora121QuizUtils get instance => _utils;

  insertTodayRecord(List<String> rewardList)async{
    var database = await Flora121BaseSqlUtils.instance.initSql();
    var timeStr = getTodayTimeStr();
    var list = await database.query(Flora121SqlName.bQuizRecord,where: ' "timer" = ? ',whereArgs: [timeStr]);
    print("kk==insertTodayRecord=${list}");
    if(list.isNotEmpty){
      return;
    }
    await database.insert(Flora121SqlName.bQuizRecord, {"timer":timeStr,"list":jsonEncode(rewardList)});
  }

  Future<List<String>> queryTodayRecord()async{
    var database = await Flora121BaseSqlUtils.instance.initSql();
    var timeStr = getTodayTimeStr();
    var list = await database.query(Flora121SqlName.bQuizRecord,where: ' "timer" = ? ',whereArgs: [timeStr]);
    if(list.isEmpty){
      return [];
    }
    var first = list.first["list"] as String;
    var json = jsonDecode(first);
    List<String> result=[];
    for(var value in json){
      if(value is String){
        result.add(value);
      }
    }
    return result;
  }

  updateTodayRecord(List<String> rewardList)async{
    var database = await Flora121BaseSqlUtils.instance.initSql();
    var timeStr = getTodayTimeStr();
    var list = await database.query(Flora121SqlName.bQuizRecord,where: ' "timer" = ? ',whereArgs: [timeStr]);
    if(list.isEmpty){
      return;
    }
    await database.update(Flora121SqlName.bQuizRecord,{"timer":timeStr,"list":jsonEncode(rewardList)},where: ' "timer" = ? ',whereArgs: [timeStr]);
  }
}