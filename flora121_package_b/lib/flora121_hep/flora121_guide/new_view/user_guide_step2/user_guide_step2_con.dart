import 'package:flora121_base/flora121_base/flora121_base_con.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';

class UserGuideStep2Con extends Flora121BaseCon with GetSingleTickerProviderStateMixin{

  @override
  void onInit() {
    super.onInit();

  }

  clickNext(Function() dismissCallback){
    Flora121RoutersHep.back();
    dismissCallback.call();
  }
}