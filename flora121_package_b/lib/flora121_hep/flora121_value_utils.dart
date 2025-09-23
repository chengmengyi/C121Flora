import 'dart:convert';
import 'dart:math';

import 'package:flora121_base/flora121_hep/flora121_firebase_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_local_info.dart';
import 'package:flora121_package_b/flora121_bean/flora121_value_bean.dart';
import 'package:flora121_package_b/flora121_hep/flora121_storage/flora121_storage.dart';

class Flora121ValueUtils{
  static final Flora121ValueUtils _utils = Flora121ValueUtils();
  static Flora121ValueUtils get instance => _utils;

  Flora121ValueBean? _valueBean;

  initValue(){
    _startInit();
    Flora121FirebaseHep.instance.initValueConfigCall=(String value){
      if(bValueConfigStr.getData().isEmpty){
        bValueConfigStr.saveData(value);
        _startInit();
      }
    };
  }

  _startInit(){
    try{
      var data = bValueConfigStr.getData();
      if(data.isEmpty){
        data=Flora121LocalInfo.valueStrBase64.base64();
      }
      _valueBean=Flora121ValueBean.fromJson(jsonDecode(data));
    }catch(e){
      _valueBean=Flora121ValueBean.fromJson(jsonDecode(Flora121LocalInfo.valueStrBase64.base64()));
    }
  }

  double getMoneyEnergyAddNum()=>_getAddReward(_valueBean?.cashBubble?.prize??[]);

  List<int> getCashList()=>[50,80,100,150,200,300];

  int getNewUserGuideStep2AddNum()=>_valueBean?.newUsersAward??10;

  double getDiceAddNum()=>_getAddReward(_valueBean?.diceAward?.prize??[]);

  double getOldUserMoney1()=>_getAddReward(_valueBean?.oldUsersAward?.prize??[]);

  double getOldUserAddNum()=>_getAddReward(_valueBean?.oldUsersAward?.prize??[]);
  double getQuizAddNum()=>_getAddReward(_valueBean?.quizAward?.prize??[]);
  double getQuizWheelAddNum()=>_getAddReward(_valueBean?.quizAward?.prize??[]);
  int getWheelAddNum()=>_getAddReward(_valueBean?.wheelAward?.prize??[]).ceil();
  double getWaterAddNum()=>_getAddReward(_valueBean?.cashBubble?.prize??[]);

  double getUpLevelAddNum()=>_getAddReward(_valueBean?.giveUp?.prize??[]);

  int getUpLevelQuantity()=>_valueBean?.giveUp?.quantity??3;

  List<int> getSignList(){
    var prize = _valueBean?.dayCheckin?.prize??[];
    if(prize.length!=7){
      return [2,2,3,4,3,2,1];
    }
    return prize;
  }

  double _getAddReward(List<Prize> list){
    if(list.isEmpty){
      return 0.0;
    }
    var myMoney = bMyMoneyNum.getData();
    var last = list.last;
    if(myMoney>=(last.endNumber??0)){
      return _randomInRange(last.prize??[]);
    }
    for(var value in list){
      if(myMoney>=(value.firstNumber??0)&&myMoney<(value.endNumber??0)){
        return _randomInRange(value.prize??[]);
      }
    }
    return 0.0;
  }


  double _randomInRange(List<double> list) {
    if(list.isEmpty){
      return 0.0;
    }
    if(list.length==1){
      return list.first;
    }
    var min = list.first;
    var max = list.last;
    final random = Random();
    double value = min + (max - min) * random.nextDouble();
    return double.parse(value.toStringAsFixed(3));
  }
}