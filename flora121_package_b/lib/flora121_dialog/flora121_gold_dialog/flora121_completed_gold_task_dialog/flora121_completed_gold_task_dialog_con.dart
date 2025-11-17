import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_point_enum.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_ttt.dart';
import 'package:spine_flutter/spine_flutter.dart';
import 'package:flora121_base/flora121_base/flora121_base_con.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';

class Flora121CompletedGoldTaskDialogCon extends Flora121BaseCon{

  @override
  void onInit() {
    super.onInit();
    Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.diamond_upgrade);
  }

  clickNext(Function() clickNextCallback){
    Flora121RoutersHep.back();
    clickNextCallback.call();
  }

  clickClose(Function() clickCloseCallback){
    Flora121RoutersHep.back();
    clickCloseCallback.call();
  }
}