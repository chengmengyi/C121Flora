import 'package:flora121_base/flora121_base/flora121_base_con.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';

class Flora121CompletedCashTaskDialogCon extends Flora121BaseCon{
  clickOk(Function() dismissCallback){
    Flora121RoutersHep.back();
    dismissCallback.call();
  }
}