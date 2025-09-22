import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_sql/flora121_base_sql_utils.dart';
import 'package:flora121_base/flora121_hep/flora121_sql/flora121_sql_name.dart';
import 'package:flora121_package_b/flora121_bean/flora121_sign_bean.dart';
import 'package:flora121_package_b/flora121_hep/flora121_task_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_value_utils.dart';

class Flora121SignUtils{
  static final Flora121SignUtils _utils = Flora121SignUtils();
  static Flora121SignUtils get instance => _utils;

  initSignList()async{
    var database = await Flora121BaseSqlUtils.instance.initSql();
    var list = await database.query(Flora121SqlName.bSign);
    if(list.isNotEmpty){
      return;
    }
    var signList = Flora121ValueUtils.instance.getSignList();
    for(var index=0;index<signList.length;index++){
      database.insert(Flora121SqlName.bSign, Flora121SignBean(signedTimer: "",addNum: signList[index],day: index+1).toJson());
    }
  }

  updateSignConfigList()async{
    var database = await Flora121BaseSqlUtils.instance.initSql();
    var list = await database.query(Flora121SqlName.bSign);
    if(list.isEmpty){
      initSignList();
    }else{
      var signList = Flora121ValueUtils.instance.getSignList();
      if(signList.length!=list.length){
        return;
      }
      for(var index=0;index<list.length;index++){
        var value = list[index];
        var bean = Flora121SignBean.fromJson(value);
        bean.addNum=signList[index];
        database.update(Flora121SqlName.bSign, bean.toJson(),where: '"id" = ?',whereArgs: [value["id"]]);
      }
    }
  }

  Future<List<Flora121SignBean>> getSignList()async{
    var database = await Flora121BaseSqlUtils.instance.initSql();
    var list = await database.query(Flora121SqlName.bSign);
    if(list.length!=7){
      return [];
    }
    List<Flora121SignBean> resultList=[];
    for (var value in list) {
      resultList.add(Flora121SignBean.fromJson(value));
    }
    return resultList;
  }

  Future<bool> checkCanSign(Flora121SignBean bean)async{
    var timeStr = getTodayTimeStr();
    var database = await Flora121BaseSqlUtils.instance.initSql();
    var list = await database.query(Flora121SqlName.bSign,where: '"signedTimer" = ?',whereArgs: [timeStr]);
    if(list.isNotEmpty){
      return false;
    }
    return true;
  }

  Future<bool> sign(Flora121SignBean bean)async{
    var timeStr = getTodayTimeStr();
    var database = await Flora121BaseSqlUtils.instance.initSql();
    var list = await database.query(Flora121SqlName.bSign,where: '"signedTimer" = ?',whereArgs: [timeStr]);
    if(list.isNotEmpty){
      return false;
    }
    bean.signedTimer=timeStr;
    await database.update(Flora121SqlName.bSign, bean.toJson(),where: '"day" = ?',whereArgs: [bean.day]);
    return true;
  }
}