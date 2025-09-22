import 'package:flora121_base/flora121_base/flora121_base_con.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_package_b/flora121_hep/flora121_routers.dart';

class Flora121NoWheelDialogCon extends Flora121BaseCon{

  clickEarn(){
    Flora121RoutersHep.back();
    Flora121RoutersHep.toNamed(routerName: Flora121RouterNameB.quiz);
  }

  clickClose(){
    Flora121RoutersHep.back();
  }
}