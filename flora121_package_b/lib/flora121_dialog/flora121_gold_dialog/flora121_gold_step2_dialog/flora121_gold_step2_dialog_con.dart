import 'package:flora121_base/flora121_base/flora121_base_con.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';

class Flora121GoldStep2DialogCon extends Flora121BaseCon{
  clickClose(){
    Flora121RoutersHep.back();
  }

  clickOk(Function() clickOkCallback){
    Flora121RoutersHep.back();
    clickOkCallback.call();
  }
}