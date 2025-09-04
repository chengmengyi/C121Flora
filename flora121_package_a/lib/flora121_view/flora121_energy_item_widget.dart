import 'dart:math';

import 'package:flora121_base/flora121_base/flora121_base_stateful.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_a/flora121_bean/flora121_energy_bean.dart';
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

  @override
  void initState() {
    super.initState();
    _initAnimator();
  }

  @override
  Widget initBaseWidgetFlora121(){
    var currentTime = widget.bean.currentTime??0;
    return Flora121Click(
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
}