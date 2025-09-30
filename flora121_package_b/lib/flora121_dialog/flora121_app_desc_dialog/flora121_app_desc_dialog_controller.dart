import 'package:flora121_base/flora121_base/flora121_base_con.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';

class Flora121AppDescDialogController extends Flora121BaseCon{

  click(Function() clickCallback){
    Flora121RoutersHep.back();
    clickCallback.call();
  }
}