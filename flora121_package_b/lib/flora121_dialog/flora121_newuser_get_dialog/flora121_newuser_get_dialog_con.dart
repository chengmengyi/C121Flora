import 'dart:async';

import 'package:flora121_base/flora121_base/flora121_base_con.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_package_b/flora121_hep/flora121_user_info_utils.dart';

class Flora121NewuserGetDialogCon extends Flora121BaseCon{
  var progressIndex=0;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    _startTimer();
  }

  clickDouble(double addNum,Function(bool received) dismissCallback){
    Flora121UserInfoUtils.instance.updateMyMoney(addNum);
    Flora121RoutersHep.back();
    dismissCallback.call(true);
  }

  clickClose(double addNum,Function(bool received) dismissCallback){
    Flora121RoutersHep.back();
    dismissCallback.call(false);
  }

  _startTimer(){
    _timer=Timer.periodic(Duration(milliseconds: 800), (t){
      progressIndex++;
      update(["progress"]);
      if(progressIndex>=2){
        _stopTimer();
      }
    });
  }

  _stopTimer(){
    _timer?.cancel();
    _timer=null;
  }

  @override
  void onClose() {
    _stopTimer();
    super.onClose();
  }
}