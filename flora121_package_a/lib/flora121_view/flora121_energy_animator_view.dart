import 'package:flora121_base/flora121_base/flora121_base_stateful.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_package_a/flora121_bean/flora121_energy_bean.dart';
import 'package:flora121_package_a/flora121_hep/flora121_event_code.dart';
import 'package:flora121_package_a/flora121_hep/flora121_hep.dart';
import 'package:flutter/material.dart';

class Flora121EnergyAnimatorView extends Flora121BaseStateful{
  @override
  State<StatefulWidget> createState() => _Flora121EnergyAnimatorViewState();
}

class _Flora121EnergyAnimatorViewState extends Flora121BaseStatefulState<Flora121EnergyAnimatorView> with TickerProviderStateMixin{
  Flora121EnergyBean? energyBean;
  Offset? energyOffset;
  AnimationController? _controller;
  Animation<Offset>? _animation;

  @override
  Widget initBaseWidgetFlora121() {
     if(null==energyBean||null==energyOffset||null==_animation){
       return Container();
     }
     return AnimatedBuilder(
       animation: _animation!,
       builder: (context, child) {
         return Transform.translate(
           offset: _animation!.value,
           child: child,
         );
       },
       child: Flora121ImagesView(imagesName: getEnergyIcon(energyBean!),width: 66.w,height: 66.w,),
     );
  }

  @override
  bool initFlora121Event() => true;

  @override
  receivedFlora121EventMsg(int flora121Code, int? flora121IntValue, String? flora121StringValue, Map? flora121Map) {
    switch(flora121Code){
      case Flora121EventCode.startEnergyAnimator:
        startEnergyAnimator(flora121Map);
        break;
    }
  }

  startEnergyAnimator(Map? flora121map)async{
    energyOffset = flora121map?["energyOffset"];
    Offset treeOffset = flora121map?["treeOffset"];
    energyBean = flora121map?["bean"];
    setState(() {});

    _controller?.dispose();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    const double shakeAmount = 8;

    _animation = TweenSequence<Offset>([
      // 抖动（来回 3 次）
      TweenSequenceItem(
        tween: Tween(begin: energyOffset, end: energyOffset! + Offset(shakeAmount, 0))
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween(begin: energyOffset! + Offset(shakeAmount, 0), end: energyOffset! - Offset(shakeAmount, 0))
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween(begin: energyOffset! - Offset(shakeAmount, 0), end: energyOffset)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 1,
      ),
      // 再飞到终点
      TweenSequenceItem(
        tween: Tween(begin: energyOffset, end: treeOffset)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 5,
      ),
    ]).animate(_controller!);

    setState(() {});
    _controller!.forward(from: 0);
    await Future.delayed(Duration(milliseconds: 800));
    energyBean=null;
    energyOffset=null;
    setState(() {});
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}