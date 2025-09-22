import 'package:flora121_base/flora121_base/flora121_base_con.dart';
import 'package:flora121_base/flora121_hep/flora121_event/flora121_event_utils.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';

class Flora121ShowAdFailDialogCon extends Flora121BaseCon{

  clickTry(Function() clickTryCall){
    Flora121RoutersHep.back();
    clickTryCall.call();
  }

  clickClose(){
    Flora121RoutersHep.back();
  }
}