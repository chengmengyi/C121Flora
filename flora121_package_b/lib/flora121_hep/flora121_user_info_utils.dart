import 'dart:math';
import 'package:flora121_base/flora121_hep/flora121_event/flora121_event_utils.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_sql/flora121_base_sql_utils.dart';
import 'package:flora121_base/flora121_hep/flora121_sql/flora121_sql_name.dart';
import 'package:flora121_package_b/flora121_bean/flora121_user_info_bean.dart';
import 'package:flora121_package_b/flora121_hep/flora121_event_code.dart';
import 'package:flora121_package_b/flora121_hep/flora121_storage/flora121_storage.dart';

class Flora121UserInfoUtils{
  static final Flora121UserInfoUtils _utils = Flora121UserInfoUtils();
  static Flora121UserInfoUtils get instance => _utils;

  Flora121UserInfoBean? _userInfoBean;

  initUserInfo()async{
    var database = await Flora121BaseSqlUtils.instance.initSql();
    var list = await database.query(Flora121SqlName.aUserInfo);
    if(list.isNotEmpty){
      _userInfoBean=Flora121UserInfoBean.fromJson(list.first);
      return;
    }
    var bean = Flora121UserInfoBean(
      headIcon: ["head1","head2","head3","head4","head5"].random(),
      userId: generateRandomString(9),
      healthNum: 100,
    );
    var id = await database.insert(Flora121SqlName.aUserInfo, bean.toJson());
    bean.id=id;
    _userInfoBean=bean;
  }

  updateHealth(int addNum)async{
    if(addNum==0){
      return;
    }
    _userInfoBean?.healthNum=(_userInfoBean?.healthNum??0)+addNum;
    if((_userInfoBean?.healthNum??0)<=0){
      _userInfoBean?.healthNum=0;
    }
    if((_userInfoBean?.healthNum??0)>100){
      _userInfoBean?.healthNum=100;
    }
    var database = await Flora121BaseSqlUtils.instance.initSql();
    await database.update(Flora121SqlName.aUserInfo, _userInfoBean?.toJson()??{},where: '"id" = ?',whereArgs: [_userInfoBean?.id]);
    Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.updateHealthNum);
  }

  Flora121UserInfoBean? getUserInfo()=>_userInfoBean;

  String generateRandomString(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random.secure();
    return List.generate(length, (index) => chars[random.nextInt(chars.length)]).join();
  }

  updateMyMoney(double addNum){
    if(addNum==0){
      return;
    }
    bMyMoneyNum.saveData((Decimal.fromJson("${bMyMoneyNum.getData()}")+Decimal.fromJson("$addNum")).toDouble());
    Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.updateMyMoney);
  }
}