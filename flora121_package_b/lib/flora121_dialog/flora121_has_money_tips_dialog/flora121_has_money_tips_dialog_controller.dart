import 'package:flora121_base/flora121_base/flora121_base_con.dart';
import 'package:flora121_base/flora121_hep/flora121_event/flora121_event_utils.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_package_b/flora121_hep/flora121_event_code.dart';
import 'package:flora121_package_b/flora121_hep/flora121_routers.dart';

class Flora121HasMoneyTipsDialogController extends Flora121BaseCon{
  clickOk(){
    Flora121RoutersHep.toHome(str: Flora121RouterNameB.home);
    Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.showHomeTab,flora121IntValue: 3);
  }

  clickClose(){
    Flora121RoutersHep.back();
  }
}