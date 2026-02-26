import 'dart:convert';
import 'dart:math';

import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_firebase_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_local_info.dart';
import 'package:flora121_package_b/flora121_bean/flora121_ad_probability_bean.dart';
import 'package:flora121_package_b/flora121_hep/flora121_storage/flora121_storage.dart';
import 'package:flutter/foundation.dart';

class Flora121AdProbabilityUtils{
  static final Flora121AdProbabilityUtils _utils=Flora121AdProbabilityUtils();
  static Flora121AdProbabilityUtils get instance => _utils;

  Flora121AdProbabilityBean? _probabilityBean;

  initValue(){
    _startInit();
    Flora121FirebaseHep.instance.initAdConfigCall=(String value){
      bAdProbabilityConfigStr.saveData(value);
      _startInit();
    };
  }

  _startInit(){
    try{
      var data = bAdProbabilityConfigStr.getData();
      if(data.isEmpty){
        data=Flora121LocalInfo.adProbabilityBase64.base64();
      }
      _probabilityBean=Flora121AdProbabilityBean.fromJson(jsonDecode(data));
    }catch(e){
      _probabilityBean=Flora121AdProbabilityBean.fromJson(jsonDecode(Flora121LocalInfo.adProbabilityBase64.base64()));
    }
  }

  bool showAd(AdType type){
    if(kDebugMode){
      return false;
    }
    if(type==AdType.reward){
      return true;
    }
    var list = _probabilityBean?.intAd??[];
    if(list.isEmpty){
      return false;
    }
    var last = list.last;
    var myMoney = bTotalMoneyToAdProbability.getData();
    if(myMoney>=(last.endNumber??1000)){
      return Random().nextInt(100)<(last.point??60);
    }
    for (var value in list) {
      if(myMoney>=(value.firstNumber??0)&&myMoney<(value.endNumber??0)){
        return Random().nextInt(100)<(value.point??60);
      }
    }
    return true;
  }
}