import 'package:flora121_base/flora121_base/flora121_base_stateful.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_view/flora121_spine_animator_view.dart';
import 'package:flora121_package_b/flora121_hep/flora121_cash_task_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_event_code.dart';
import 'package:flora121_package_b/flora121_hep/flora121_storage/flora121_storage.dart';
import 'package:flutter/material.dart';
import 'package:spine_flutter/spine_flutter.dart';

class Flora121GoldDiamondGetAnimatorView extends Flora121BaseStateful{
  @override
  State<StatefulWidget> createState() => _Flora121GoldDiamondGetAnimatorViewState();
}

class _Flora121GoldDiamondGetAnimatorViewState extends Flora121BaseStatefulState<Flora121GoldDiamondGetAnimatorView>{
  var showAnimator=false,goldMode="";
  late SpineWidgetController spineWidgetController1;
  late SpineWidgetController spineWidgetController2;

  @override
  void initState() {
    super.initState();
    spineWidgetController1=SpineWidgetController(
      onInitialized: (controller) {

      },
    );
    spineWidgetController2=SpineWidgetController(
      onInitialized: (controller) {

      },
    );
  }


  @override
  Widget initBaseWidgetFlora121() => Offstage(
    offstage: !showAnimator,
    child: Container(
      // margin: EdgeInsets.only(top: 150.h),
      child: Stack(
        children: [
          Offstage(
            offstage: goldMode!=Flora121GoldMode.gold,
            child: Flora121SpineAnimatorView(
              atlasFile: "skeleton",
              skeletonFile: "skeleton",
              animatorName: "animation",
              folder: "gold",
              width: 300.w,
              height: 400.h,
              controller: spineWidgetController1,
            ),
          ),
          Offstage(
            offstage: goldMode!=Flora121GoldMode.diamond,
            child: Flora121SpineAnimatorView(
              atlasFile: "skeleton",
              skeletonFile: "skeleton",
              animatorName: "animation",
              folder: "diamond",
              width: 300.w,
              height: 400.h,
              controller: spineWidgetController2,
            ),
          ),
        ],
      ),
    ),
  );

  @override
  bool initFlora121Event() => true;

  @override
  receivedFlora121EventMsg(int flora121Code, int? flora121IntValue, String? flora121StringValue, Map? flora121Map) {
    switch(flora121Code){
      case Flora121EventCode.showGoldDiamondAnimator:
        _showMoneyAnimator();
        break;
    }
  }

  _showMoneyAnimator()async{
    setState(() {
      showAnimator=true;
    });
    goldMode=bGoldMode.getData();
    if(goldMode==Flora121GoldMode.gold){
      spineWidgetController1.animationState.setAnimationByName(0, "animation", false);
    }else if(goldMode==Flora121GoldMode.diamond){
      spineWidgetController2.animationState.setAnimationByName(0, "animation", false);
    }
    await Future.delayed(Duration(milliseconds: 1000));
    if (!mounted){
      return;
    }
    setState(() {
      showAnimator=false;
    });
  }
}