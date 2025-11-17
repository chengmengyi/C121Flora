import 'package:flora121_base/flora121_base/flora121_base_con.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_point_enum.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_ttt.dart';

class Flora121GoldStep2DialogCon extends Flora121BaseCon{

  @override
  void onInit() {
    super.onInit();
    Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.gold_upgrade);
  }

  clickClose(){
    Flora121RoutersHep.back();
  }

  clickOk(Function() clickOkCallback){
    Flora121RoutersHep.back();
    clickOkCallback.call();
  }
}