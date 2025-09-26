import 'package:flora121_base/flora121_base/flora121_base_stateful.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_view/flora121_spine_animator_view.dart';
import 'package:flora121_package_b/flora121_hep/flora121_event_code.dart';
import 'package:flutter/material.dart';
import 'package:spine_flutter/spine_flutter.dart';

class Flora121MoneyAnimatorWidget extends Flora121BaseStateful{
  bool fromQuiz;
  Flora121MoneyAnimatorWidget({
    required this.fromQuiz,
});
  @override
  State<StatefulWidget> createState() => _Flora121MoneyAnimatorWidgetState();
}

class _Flora121MoneyAnimatorWidgetState extends Flora121BaseStatefulState<Flora121MoneyAnimatorWidget> with TickerProviderStateMixin{
  var showAnimator=false;
  late AnimationController moneyLottieController;

  @override
  void initState() {
    super.initState();
    moneyLottieController=AnimationController(vsync: this,duration: const Duration(milliseconds: 800))..addStatusListener((status) {
      if(status==AnimationStatus.completed){
        showAnimator=false;
        setState(() {});
      }
    });
  }

  @override
  Widget initBaseWidgetFlora121(){
    if(!showAnimator){
      return Container();
    }
    return Lottie.asset(
      "assets/flora121_lottie/money.zip",
      controller: moneyLottieController,
    );
  }

  @override
  bool initFlora121Event() => true;

  @override
  receivedFlora121EventMsg(int flora121Code, int? flora121IntValue, String? flora121StringValue, Map? flora121Map) {
    switch(flora121Code){
      case Flora121EventCode.showMoneyAnimator:
        if(widget.fromQuiz==flora121Map?["bool"]){
          _showMoneyAnimator();
        }
        break;
    }
  }

  _showMoneyAnimator()async{
    setState(() {
      showAnimator=true;
    });
    moneyLottieController..reset()..forward();
  }
}