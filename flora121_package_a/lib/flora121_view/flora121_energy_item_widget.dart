import 'dart:math';

import 'package:flora121_base/flora121_base/flora121_base_stateful.dart';
import 'package:flora121_base/flora121_hep/flora121_event/flora121_event_utils.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_a/flora121_bean/flora121_energy_bean.dart';
import 'package:flora121_package_a/flora121_hep/flora121_event_code.dart';
import 'package:flora121_package_a/flora121_hep/flora121_hep.dart';
import 'package:flutter/material.dart';

class Flora121EnergyItemWidget extends Flora121BaseStateful{
  Flora121EnergyBean bean;
  Function(Flora121EnergyBean bean) clickItem;
  Flora121EnergyItemWidget({
    required this.bean,
    required this.clickItem,
});
  @override
  State<StatefulWidget> createState() => _Flora121EnergyItemWidgetState();
}

class _Flora121EnergyItemWidgetState extends Flora121BaseStatefulState<Flora121EnergyItemWidget> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<double> _animation;
  var showEnergy=true;
  GlobalKey globalKey=GlobalKey();

  @override
  void initState() {
    super.initState();
    _initAnimator();
  }

  @override
  Widget initBaseWidgetFlora121(){
    var currentTime = widget.bean.currentTime??0;
    return Positioned(
      left: (widget.bean.offset?.dx??0),
      top: (widget.bean.offset?.dy??0)-33.w,
      child: Visibility(
        visible: showEnergy,
        maintainAnimation: true,
        maintainState: true,
        maintainSize: true,
        key: globalKey,
        child: Flora121Click(
          onTap: (){
            widget.clickItem.call(widget.bean);
          },
          child: ScaleTransition(
            scale: _animation,
            child: Stack(
              key: widget.bean.globalKey,
              alignment: Alignment.bottomCenter,
              children: [
                Flora121ImagesView(imagesName: getEnergyIcon(widget.bean),width: 66.w,height: 66.w,),
                currentTime<=0?Container():Flora121TextView(text: formatDuration(currentTime), color: "#FFFFFF", size: 10.sp,outlineColor: getEnergyOutlineColor(),)
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getEnergyOutlineColor(){
    switch(widget.bean.energyType){
      case EnergyType.sun: return "#8F6E00";
      case EnergyType.fertilizer1:
      case EnergyType.fertilizer2:
        return "#1F7802";
      case EnergyType.water1:
      case EnergyType.water2:
        return "#00698F";
    }
    return "#00698F";
  }

  _initAnimator()async{
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _animation = Tween<double>(begin: 0.8, end: 1.0)
        .animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    await Future.delayed(Duration(milliseconds: Random().nextInt(500)));
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  bool initFlora121Event() => true;

  @override
  receivedFlora121EventMsg(int flora121Code, int? flora121IntValue, String? flora121StringValue, Map? flora121Map) {
    switch(flora121Code){
      case Flora121EventCode.updateNewEnergyOffset:
        _updateNewEnergyOffset(flora121StringValue);
        break;
      case Flora121EventCode.repeatAnimatorStop:
        _repeatAnimatorStop(flora121StringValue);
        break;
      case Flora121EventCode.startEnergyAnimator:
        _startEnergyAnimator(flora121Map);
        break;
    }
  }

  _startEnergyAnimator(Map? flora121map){
    Flora121EnergyBean flora121energyBean=flora121map?["bean"];
    if(flora121energyBean.energyType!=widget.bean.energyType){
      return;
    }
    showEnergy=false;
    setState(() {});
  }

  _repeatAnimatorStop(String? flora121stringValue){
    if(flora121stringValue!=widget.bean.energyType){
      return;
    }
    showEnergy=true;
    setState(() {});
  }

  _updateNewEnergyOffset(String? flora121stringValue)async{
    if(flora121stringValue!=widget.bean.energyType){
      return;
    }
    final random = Random();
    var value = widget.bean.baseOffset??Offset.zero;
    final dx = value.dx + (random.nextInt(61) - 30).toDouble();
    final dy = value.dy + (random.nextInt(61) - 30).toDouble();
    widget.bean.offset = (widget.bean.flowerCenter??Offset.zero) + Offset(dx, dy);
    showEnergy=false;
    setState(() {});
    await Future.delayed(Duration(milliseconds: 200));
    var renderBox = globalKey.currentContext!.findRenderObject() as RenderBox;
    var offset = renderBox.localToGlobal(Offset.zero);
    Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.startRepeatAnimator,flora121Map: {"offset":offset});
  }
}