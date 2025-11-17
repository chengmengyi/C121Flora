import 'package:flora121_base/flora121_base/flora121_base_con.dart';
import 'package:flora121_base/flora121_hep/flora121_event/flora121_event_utils.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_point_enum.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_ttt.dart';
import 'package:flora121_package_b/flora121_hep/flora121_cash_task_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_event_code.dart';
import 'package:flora121_package_b/flora121_hep/flora121_routers.dart';

class Flora121HasMoneyTipsCon extends Flora121BaseCon{
  int cashMoney=0;
  String cashType="";
  @override
  void onInit() {
    super.onInit();
    var map = Flora121RoutersHep.getParams();
    cashMoney=map["cashMoney"];
    cashType=map["cashType"];
    Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.meet_withdraw);
  }

  clickClose(){
    Flora121RoutersHep.back();
    // Flora121RoutersHep.toHome(str: Flora121RouterNameB.home);
    // Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.showHomeTab,flora121IntValue: 3);
    Flora121CashTaskUtils.instance.hasMoneyPageClickSure(cashMoney, cashType);
  }
}