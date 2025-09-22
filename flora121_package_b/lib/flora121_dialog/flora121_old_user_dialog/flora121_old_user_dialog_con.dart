import 'dart:async';

import 'package:flora121_base/flora121_base/flora121_base_con.dart';
import 'package:flora121_base/flora121_hep/flora121_ad_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_point_enum.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_ttt.dart';
import 'package:flora121_package_b/flora121_hep/flora121_user_info_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_value_utils.dart';

class Flora121OldUserDialogCon extends Flora121BaseCon{
  var progressIndex=0;
  Timer? _timer;
  var addNum=Flora121ValueUtils.instance.getOldUserAddNum();

  @override
  void onInit() {
    super.onInit();
    Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.old_users_award);
    _startTimer();
  }

  clickDouble(){
    Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.old_users_award_c);
    Flora121UserInfoUtils.instance.updateMyMoney(addNum);
    Flora121RoutersHep.back();
  }

  clickClose(){
    Flora121RoutersHep.back();
  }

  _startTimer(){
    _timer=Timer.periodic(Duration(milliseconds: 2000), (t){
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