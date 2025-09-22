import 'dart:convert';

import 'package:flora121_base/flora121_hep/flora121_event/flora121_event_utils.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_package_b/flora121_hep/flora121_event_code.dart';
import 'package:flora121_package_b/flora121_hep/flora121_storage/flora121_storage.dart';

class Flora121WheelUtils{
  static final Flora121WheelUtils _utils=Flora121WheelUtils();
  static Flora121WheelUtils get instance => _utils;

  var wheelNum=3;

  //{"timer":"2022-02-02","num":1}
  initTodayWheelNum(){
    try{
      var json = jsonDecode(bWheelNum.getData());
      if(json["timer"]==getTodayTimeStr()){
        wheelNum=json["num"];
      }
    }catch(e){

    }
  }

  updateWheelNum(int addNum){
    wheelNum+=addNum;
    bWheelNum.saveData(jsonEncode({"timer":getTodayTimeStr(),"num":wheelNum}));
    Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.updateWheelNum);
  }

  updateWheelGiftNum(){
    var i = bWheelGiftNum.getData()+1;
    if(i>5){
      i=5;
    }
    bWheelGiftNum.saveData(i);
  }

  resetGiftNum(){
    bWheelGiftNum.saveData(0);
  }
}