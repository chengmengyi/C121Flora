import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_point_enum.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_ttt.dart';
import 'package:spine_flutter/spine_flutter.dart';
import 'package:flora121_base/flora121_base/flora121_base_con.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';

class Flora121GoldStep1DialogCon extends Flora121BaseCon{
  late Function() dismissCallback;
  late SpineWidgetController spineWidgetController;

  Flora121GoldStep1DialogCon(this.dismissCallback);

  @override
  void onInit() {
    super.onInit();
    Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.gold_progress);
    spineWidgetController=SpineWidgetController(
      onInitialized: (controller) {
        controller.animationState.setAnimationByName(0, "animation", false);
        _delay();
      },
    );
  }

  _delay()async{
    await Future.delayed(Duration(milliseconds: 4000));
    Flora121RoutersHep.back();
    dismissCallback.call();
  }
}