import 'package:flora121_base/flora121_base/flora121_base_con.dart';
import 'package:flora121_base/flora121_hep/flora121_event/flora121_event_utils.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_point_enum.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_ttt.dart';
import 'package:flora121_package_b/flora121_hep/flora121_event_code.dart';
import 'package:flora121_package_b/flora121_hep/flora121_routers.dart';
import 'package:flora121_package_b/flora121_hep/flora121_storage/flora121_storage.dart';

class Flora121Money1580TipsDialogCon extends Flora121BaseCon{

  @override
  void onInit() {
    super.onInit();
    Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.remind_pop,);
  }

  clickToDice(){
    Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.remind_pop_c,params: {"from":"dice"});
    Flora121RoutersHep.toHome(str: Flora121RouterNameB.home);
    Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.showHomeTab,flora121IntValue: 1);
  }

  clickCash(){
    Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.remind_pop_c,params: {"from":"cash"});
    Flora121RoutersHep.toHome(str: Flora121RouterNameB.home);
    Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.showHomeTab,flora121IntValue: 3);
  }

  double getPro(){
    var d = bMyMoneyNum.getData()/100;
    if(d<=0){
      return 0.0;
    }else if(d>=1){
      return 1.0;
    }else{
      return d;
    }
  }
}