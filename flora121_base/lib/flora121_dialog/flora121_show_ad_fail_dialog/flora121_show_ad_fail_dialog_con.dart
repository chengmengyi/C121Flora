import 'package:flora121_base/flora121_base/flora121_base_con.dart';
import 'package:flora121_base/flora121_hep/flora121_event/flora121_event_utils.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_point_enum.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_ttt.dart';

class Flora121ShowAdFailDialogCon extends Flora121BaseCon{
  @override
  void onInit() {
    super.onInit();
    Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.ad_fail);
  }

  clickTry(Function() clickTryCall){
    Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.ad_fail_c);
    Flora121RoutersHep.back();
    clickTryCall.call();
  }

  clickClose(Function()? clickClose){
    Flora121RoutersHep.back();
    clickClose?.call();
  }
}