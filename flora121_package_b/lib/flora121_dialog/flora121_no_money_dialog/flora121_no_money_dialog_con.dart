import 'package:flora121_base/flora121_base/flora121_base_con.dart';
import 'package:flora121_base/flora121_hep/flora121_event/flora121_event_utils.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_package_b/flora121_hep/flora121_event_code.dart';

class Flora121NoMoneyDialogCon extends Flora121BaseCon{

  clickSpin(){
    Flora121RoutersHep.back();
    Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.showHomeTab,flora121IntValue: 2);
  }

  clickClose(){
    Flora121RoutersHep.back();
  }
}