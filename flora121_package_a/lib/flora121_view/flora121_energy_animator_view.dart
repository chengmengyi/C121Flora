import 'dart:math';

import 'package:flora121_base/flora121_base/flora121_base_stateful.dart';
import 'package:flora121_base/flora121_hep/flora121_event/flora121_event_utils.dart';
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
  // Offset? energyOffset;
  // Animation<Offset>? _animation;
  AnimationController? _controller;

  late Animation<Offset> _posAnim;
  late Animation<double> _scaleAnim;

  Offset _currentStart = Offset.zero;
  Offset _currentEnd = Offset.zero;

  @override
  Widget initBaseWidgetFlora121() {
     if(null==energyBean||null==_controller){
       return Container();
     }
     return AnimatedBuilder(
       animation: _controller!,
       builder: (context, child) {
         final pos = _posAnim.value;
         final scale = _scaleAnim.value;
         return Positioned(
           left: pos.dx,
           top: pos.dy,
           child: Transform.scale(
             scale: scale,
             child: child,
           ),
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
      case Flora121EventCode.startRepeatAnimator:
        startRepeatAnimator(flora121Map);
        break;
    }
  }

  startEnergyAnimator(Map? flora121map)async{
    energyBean = flora121map?["bean"];
    _currentStart = flora121map?["energyOffset"];
    _currentEnd = flora121map?["treeOffset"];

    _controller?.dispose();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    setState(() {});

    _setupAnimation(_currentStart, _currentEnd, shrink: true);

    // 开始飞向花底部
    _controller!.forward();
    _controller!.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        await Future.delayed(Duration(milliseconds: 2000));
        Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.updateNewEnergyOffset,flora121StringValue: energyBean?.energyType);
      }
    });
  }

  startRepeatAnimator(Map? flora121map){
    var endOffset = flora121map?["offset"];
    _controller?.dispose();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    setState(() {});
    _setupAnimation(_currentEnd, endOffset, shrink: false);
    _controller!.forward();
    _controller!.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.repeatAnimatorStop,flora121StringValue: energyBean?.energyType);
        energyBean=null;
        setState(() {});
      }
    });
  }


  void _setupAnimation(Offset start, Offset end, {required bool shrink}) {
    _posAnim = Tween<Offset>(
      begin: start,
      end: end,
    ).chain(CurveTween(curve: Curves.easeInOut)).animate(_controller!);

    _scaleAnim = Tween<double>(
      begin: shrink ? 1.0 : 0.0,
      end: shrink ? 0.0 : 1.0,
    ).animate(CurvedAnimation(parent: _controller!, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}