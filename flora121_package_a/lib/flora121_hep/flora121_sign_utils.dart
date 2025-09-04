import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_sql/flora121_base_sql_utils.dart';
import 'package:flora121_base/flora121_hep/flora121_sql/flora121_sql_name.dart';
import 'package:flora121_package_a/flora121_bean/flora121_sign_bean.dart';
import 'package:flora121_package_a/flora121_hep/flora121_task_utils.dart';

class Flora121SignUtils{
  static final Flora121SignUtils _utils = Flora121SignUtils();
  static Flora121SignUtils get instance => _utils;

  initSignList()async{
    var database = await Flora121BaseSqlUtils.instance.initSql();
    var list = await database.query(Flora121SqlName.aSign);
    if(list.isNotEmpty){
      return;
    }
    database.insert(Flora121SqlName.aSign, Flora121SignBean(signType: TaskType.water,signedTimer: "",addNum: 1,day: 1).toJson());
    database.insert(Flora121SqlName.aSign, Flora121SignBean(signType: TaskType.water,signedTimer: "",addNum: 2,day: 2).toJson());
    database.insert(Flora121SqlName.aSign, Flora121SignBean(signType: TaskType.water,signedTimer: "",addNum: 3,day: 3).toJson());
    database.insert(Flora121SqlName.aSign, Flora121SignBean(signType: TaskType.fertilizer,signedTimer: "",addNum: 2,day: 4).toJson());
    database.insert(Flora121SqlName.aSign, Flora121SignBean(signType: TaskType.fertilizer,signedTimer: "",addNum: 2,day: 5).toJson());
    database.insert(Flora121SqlName.aSign, Flora121SignBean(signType: TaskType.fertilizer,signedTimer: "",addNum: 2,day: 6).toJson());
    database.insert(Flora121SqlName.aSign, Flora121SignBean(signType: TaskType.suns,signedTimer: "",addNum: 2,day: 7).toJson());
  }

  Future<List<Flora121SignBean>> getSignList()async{
    var database = await Flora121BaseSqlUtils.instance.initSql();
    var list = await database.query(Flora121SqlName.aSign);
    if(list.length!=7){
      return [];
    }
    List<Flora121SignBean> resultList=[];
    for (var value in list) {
      resultList.add(Flora121SignBean.fromJson(value));
    }
    return resultList;
  }

  Future<bool> sign(Flora121SignBean bean)async{
    var timeStr = getTodayTimeStr();
    var database = await Flora121BaseSqlUtils.instance.initSql();
    var list = await database.query(Flora121SqlName.aSign,where: '"signedTimer" = ?',whereArgs: [timeStr]);
    if(list.isNotEmpty){
      return false;
    }
    bean.signedTimer=timeStr;
    await database.update(Flora121SqlName.aSign, bean.toJson(),where: '"day" = ?',whereArgs: [bean.day]);
    return true;
  }
}