import 'package:flora121_base/flora121_base/flora121_base_con.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';

class Flora121DonotWorryDialogCon extends Flora121BaseCon{
  clickClose(Function() dismissCallback){
    Flora121RoutersHep.back();
    dismissCallback.call();
  }
}