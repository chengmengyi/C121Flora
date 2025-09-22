import 'dart:async';
import 'dart:math';
import 'package:flora121_base/flora121_base/flora121_base_stateful.dart';
import 'package:flora121_base/flora121_hep/flora121_event/flora121_event_utils.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_common_get_dialog/flora121_common_get_dialog.dart';
import 'package:flora121_package_b/flora121_hep/flora121_energy_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_event_code.dart';
import 'package:flora121_package_b/flora121_hep/flora121_guide/flora121_user_guide_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_hep.dart';
import 'package:flora121_package_b/flora121_hep/flora121_routers.dart';
import 'package:flora121_package_b/flora121_hep/flora121_storage/flora121_storage.dart';
import 'package:flora121_package_b/flora121_hep/flora121_value_utils.dart';
import 'package:flora121_package_b/flora_enum/flora121_energy_type.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Flora121EnergyItemWidget extends Flora121BaseStateful{
  Flora121EnergyType flora121energyType;
  GlobalKey? treeGlobalKey;
  Function() clickItem;
  Flora121EnergyItemWidget({
    required this.flora121energyType,
    required this.clickItem,
    this.treeGlobalKey,
});
  @override
  State<StatefulWidget> createState() => _Flora121EnergyItemWidgetState();
}

class _Flora121EnergyItemWidgetState extends Flora121BaseStatefulState<Flora121EnergyItemWidget> with SingleTickerProviderStateMixin{
  var showEnergy=true,addNum=0.0;
  late AnimationController _controller;
  late Animation<double> _animation;
  GlobalKey globalKey=GlobalKey();
  Timer? _waterTimer;

  @override
  void initState() {
    super.initState();
    if(widget.flora121energyType==Flora121EnergyType.money){
      addNum=Flora121ValueUtils.instance.getMoneyEnergyAddNum();
    }
    if(widget.flora121energyType==Flora121EnergyType.water){
      addNum=Flora121ValueUtils.instance.getWaterAddNum();
    }
    _initAnimator();
    _startWaterTimer();
  }

  @override
  Widget initBaseWidgetFlora121(){
    if(!showEnergy){
      return Container();
    }
    return Flora121Click(
      onTap: (){
        _clickItem();
      },
      child: ScaleTransition(
        scale: _animation,
        child: Stack(
          key: globalKey,
          alignment: Alignment.bottomCenter,
          children: [
            Flora121ImagesView(imagesName: getEnergyIcon(widget.flora121energyType),width: 66.w,height: 66.w,),
            _getNameWidget(),
          ],
        ),
      ),
    );
  }

  Widget _getNameWidget(){
    switch(widget.flora121energyType){
      case Flora121EnergyType.dice:
        return Container();
      case Flora121EnergyType.water:
        var data = bHomeWaterItemCD.getData();
        if(data>0){
          return Flora121TextView(text: formatDuration(data), color: "#095E05", size: 10.sp,fontWeight: FontWeight.bold,);
        }
        return Flora121TextView(text: "+\$$addNum", color: "#095E05", size: 10.sp,fontWeight: FontWeight.bold,);
      case Flora121EnergyType.money:
        return Flora121TextView(text: "+\$$addNum", color: "#095E05", size: 10.sp,fontWeight: FontWeight.bold,);
      case Flora121EnergyType.wheel:
        return Flora121TextView(text: "Wheel", color: "#FFFFFF", size: 10.sp,outlineColor: "#A14220",fontWeight: FontWeight.bold,);
      case Flora121EnergyType.quiz:
        return Flora121TextView(text: "Quiz Cash", color: "#FFFFFF", size: 10.sp,outlineColor: "#1F7802",fontWeight: FontWeight.bold,);
    }
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

  _clickItem()async{
    if(widget.flora121energyType==Flora121EnergyType.water){
      _clickWater();
      return;
    }
    widget.clickItem.call();
    setState(() {
      showEnergy=false;
    });
    switch(widget.flora121energyType){
      case Flora121EnergyType.wheel:
        Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.showHomeTab,flora121IntValue: 2);
        break;
      case Flora121EnergyType.money:
        Flora121RoutersHep.dialog(
          child: Flora121CommonGetDialog(
            addNum: addNum,
            dismissCallback: (received){},
          ),
        );
        break;
      case Flora121EnergyType.water:

        break;
      case Flora121EnergyType.dice:
        Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.showHomeTab,flora121IntValue: 1);
        break;
      case Flora121EnergyType.quiz:
        Flora121RoutersHep.toNamed(routerName: Flora121RouterNameB.quiz);
        break;

    }
    await Future.delayed(Duration(milliseconds: 3000));
    setState(() {
      showEnergy=true;
      if(widget.flora121energyType==Flora121EnergyType.money){
        addNum=Flora121ValueUtils.instance.getMoneyEnergyAddNum();
      }
    });
  }

  _clickWater(){
    if(bHomeWaterItemCD.getData()>0){
      "Hourly sips, double rewards - health and wealth!".showToast();
      return;
    }
    if(kDebugMode){
      bHomeWaterItemCD.saveData(10);
    }else{
      bHomeWaterItemCD.saveData(3600);
    }
    widget.clickItem.call();
    _startWaterTimer();
    Flora121RoutersHep.dialog(
      child: Flora121CommonGetDialog(
        addNum: addNum,
        dismissCallback: (received){},
      ),
    );
  }
  
  _startWaterTimer(){
    if(widget.flora121energyType==Flora121EnergyType.water&&bHomeWaterItemCD.getData()>0){
      _waterTimer=Timer.periodic(Duration(seconds: 1), (t){
        setState(() {
          bHomeWaterItemCD.saveData(bHomeWaterItemCD.getData()-1);
        });
        if(bHomeWaterItemCD.getData()<=0){
          setState(() {
            addNum=Flora121ValueUtils.instance.getWaterAddNum();
          });
          _stopWaterTimer();
        }
      });
    }
  }

  _stopWaterTimer(){
    _waterTimer?.cancel();
    _waterTimer=null;
  }

  @override
  bool initFlora121Event() => true;

  @override
  receivedFlora121EventMsg(int flora121Code, int? flora121IntValue, String? flora121StringValue, Map? flora121Map) {
    switch(flora121Code){
      case Flora121EventCode.showNewUerStep1Guide:
        showNewUerStep1Guide(flora121Map);
        break;
      case Flora121EventCode.showNewUerStep3Guide:
        showNewUerStep3Guide(flora121Map);
        break;
      case Flora121EventCode.showNewUserStep9QuizGuide:
        showNewUserStep9QuizGuide(flora121Map);
        break;
    }
  }

  showNewUerStep1Guide(Map? flora121map){
    if(widget.flora121energyType!=Flora121EnergyType.money){
      return;
    }
    var moneyRenderBox = globalKey.currentContext!.findRenderObject() as RenderBox;
    var moneyOffset = moneyRenderBox.localToGlobal(Offset.zero);
    var treeRenderBox = widget.treeGlobalKey?.currentContext?.findRenderObject() as RenderBox;
    var treeOffset = treeRenderBox.localToGlobal(Offset.zero);
    Flora121UserGuideUtils.instance.showStep1Overlay(context, moneyOffset, treeOffset);
  }

  showNewUerStep3Guide(Map? flora121map){
    if(widget.flora121energyType!=Flora121EnergyType.dice){
      return;
    }
    var renderBox = globalKey.currentContext!.findRenderObject() as RenderBox;
    var offset = renderBox.localToGlobal(Offset.zero);
    Flora121UserGuideUtils.instance.showStep3Overlay(context, offset);
  }

  showNewUserStep9QuizGuide(Map? flora121map){
    if(widget.flora121energyType!=Flora121EnergyType.quiz){
      return;
    }
    var renderBox = globalKey.currentContext!.findRenderObject() as RenderBox;
    var offset = renderBox.localToGlobal(Offset.zero);
    Flora121UserGuideUtils.instance.showStep9Guide(context, offset);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}