import 'dart:async';
import 'dart:math';
import 'package:flora121_base/flora121_base/flora121_base_stateful.dart';
import 'package:flora121_base/flora121_hep/flora121_ad_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_event/flora121_event_utils.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_music_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_ad_enum.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_point_enum.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_ttt.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_common_get_dialog/flora121_common_get_dialog.dart';
import 'package:flora121_package_b/flora121_hep/flora121_ad_probability_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_cash_task_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_energy_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_event_code.dart';
import 'package:flora121_package_b/flora121_hep/flora121_guide/flora121_user_guide_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_hep.dart';
import 'package:flora121_package_b/flora121_hep/flora121_routers.dart';
import 'package:flora121_package_b/flora121_hep/flora121_storage/flora121_storage.dart';
import 'package:flora121_package_b/flora121_hep/flora121_user_info_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_value_utils.dart';
import 'package:flora121_package_b/flora_enum/flora121_cash_task_type.dart';
import 'package:flora121_package_b/flora_enum/flora121_energy_type.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum FloraMoneyEnergyType{
  normal,video1,video2,
}

class Flora121EnergyItemWidget extends Flora121BaseStateful{
  Flora121EnergyType flora121energyType;
  GlobalKey? treeGlobalKey;
  Function() clickItem;
  FloraMoneyEnergyType floraMoneyEnergyType;
  Flora121EnergyItemWidget({
    required this.flora121energyType,
    required this.clickItem,
    this.treeGlobalKey,
    this.floraMoneyEnergyType=FloraMoneyEnergyType.normal,
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
      _getMoneyAddNum();
    }
    if(widget.flora121energyType==Flora121EnergyType.water){
      _getWaterAddNum();
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
        child: SizedBox(
          width: 66.w,
          height: 66.w,
          child: Stack(
            key: globalKey,
            children: [
              Flora121ImagesView(imagesName: getEnergyIcon(widget.flora121energyType),width: 66.w,height: 66.w,),
              Align(
                alignment: Alignment.bottomCenter,
                child: _getNameWidget(),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Visibility(
                  visible: widget.floraMoneyEnergyType!=FloraMoneyEnergyType.normal,
                  child: Flora121ImagesView(imagesName: "icon_video",width: 26.w,height: 26.w,),
                ),
              ),
            ],
          ),
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
        var noGold = bGoldMode.getData().isEmpty;
        if(widget.floraMoneyEnergyType!=FloraMoneyEnergyType.normal){
          if(widget.floraMoneyEnergyType==FloraMoneyEnergyType.video1){
            return Flora121TextView(text: noGold?"+\$$addNum":"+$addNum", color: "#095E05", size: 10.sp,fontWeight: FontWeight.bold,);
          }
          return Flora121TextView(text: noGold?"+\$??":"+??", color: "#095E05", size: 10.sp,fontWeight: FontWeight.bold,);
        }else{
          var data = bHomeMoneyItemCD.getData();
          if(data>0){
            return Flora121TextView(text: formatDuration(data), color: "#095E05", size: 10.sp,fontWeight: FontWeight.bold,);
          }
          return Flora121TextView(text: noGold?"+\$$addNum":"+$addNum", color: "#095E05", size: 10.sp,fontWeight: FontWeight.bold,);
        }
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
    Flora121MusicHep.instance.playOtherAudio(AudioName.clickPaoPao);
    if(widget.flora121energyType==Flora121EnergyType.water){
      _clickWater();
      return;
    }
    Flora121CashTaskUtils.instance.updateCashTaskProgress(Flora121CashTaskType.bubbles);
    widget.clickItem.call();
    if(widget.flora121energyType==Flora121EnergyType.money){
      if(widget.floraMoneyEnergyType==FloraMoneyEnergyType.normal&&bHomeMoneyItemCD.getData()>0){
        "Hourly sips, double rewards - health and wealth!".showToast();
        return;
      }
      if(widget.floraMoneyEnergyType!=FloraMoneyEnergyType.normal){
        Flora121AdHep.instance.showFlora121BBBBBBB(
          adType: AdType.reward,
          adEnum: Flora121AdEnum.frfcn_cash_rv,
          showAd: Flora121AdProbabilityUtils.instance.showAd(AdType.reward),
          closeAd: (giveReward)async{
            if(giveReward){
              Flora121UserInfoUtils.instance.updateMyMoney(addNum);
              setState(() {
                showEnergy=false;
              });
              await Future.delayed(Duration(milliseconds: 3000));
              _getMoneyAddNum();
              setState(() {
                showEnergy=true;
              });
            }
          },
        );
      }else{
        Flora121AdHep.instance.showFlora121BBBBBBB(
          adType: AdType.interstitial,
          adEnum: Flora121AdEnum.frfcn_cash_int,
          showAd: Flora121AdProbabilityUtils.instance.showAd(AdType.interstitial),
          closeAd: (giveReward)async{
            Flora121UserInfoUtils.instance.updateMyMoney(addNum);
            bHomeMoneyItemCD.saveData(600);
            _startWaterTimer();
          },
        );
      }
      return;
    }
    setState(() {
      showEnergy=false;
    });
    switch(widget.flora121energyType){
      case Flora121EnergyType.wheel:
        Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.showHomeTab,flora121IntValue: 2);
        break;
      case Flora121EnergyType.money:
        break;
      case Flora121EnergyType.water:

        break;
      case Flora121EnergyType.dice:
        Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.showHomeTab,flora121IntValue: 1);
        break;
      case Flora121EnergyType.quiz:
        Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.quiz_c);
        Flora121RoutersHep.toNamed(routerName: Flora121RouterNameB.quiz);
        break;

    }
    await Future.delayed(Duration(milliseconds: 3000));
    setState(() {
      showEnergy=true;
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
    Flora121RoutersHep.dialog(
      child: Flora121CommonGetDialog(
        addNum: addNum,
        fromWater: true,
        rvAdEnum: Flora121AdEnum.frfcn_drink_rv,
        intAdEnum: Flora121AdEnum.frfcn_drink_int,
        dismissCallback: (received){
          Flora121CashTaskUtils.instance.updateCashTaskProgress(Flora121CashTaskType.water);
          _startWaterTimer();
        },
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
            _getWaterAddNum();
          });
          _stopWaterTimer();
        }
      });
    }
    if(widget.flora121energyType==Flora121EnergyType.money&&widget.floraMoneyEnergyType==FloraMoneyEnergyType.normal&&bHomeMoneyItemCD.getData()>0){
      _waterTimer=Timer.periodic(Duration(seconds: 1), (t){
        setState(() {
          bHomeMoneyItemCD.saveData(bHomeMoneyItemCD.getData()-1);
        });
        if(bHomeMoneyItemCD.getData()<=0){
          setState(() {
            _getMoneyAddNum();
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
      case Flora121EventCode.showNewUerStep4Guide:
        showNewUerStep4Guide(flora121Map);
        break;
      // case Flora121EventCode.showNewUerStep3Guide:
      //   showNewUerStep3Guide(flora121Map);
      //   break;
      case Flora121EventCode.showNewUserStep7DiceGuide:
        showNewUserStep7DiceGuide(flora121Map);
        break;
      case Flora121EventCode.updateMyMoney:
        _updateMyMoney();
        break;
      case Flora121EventCode.changeToGoldMode:
        _updateMyMoney();
        setState(() {});
        break;
    }
  }

  _updateMyMoney(){
    if(widget.flora121energyType==Flora121EnergyType.money){
      _getMoneyAddNum();
    }
    if(widget.flora121energyType==Flora121EnergyType.water){
      _getWaterAddNum();
    }
    setState(() {});
  }

  _getMoneyAddNum()async{
    var data = bGoldMode.getData();
    if(data==Flora121GoldMode.gold){
      addNum=await Flora121ValueUtils.instance.getGoldAddReward();
    }else if(data==Flora121GoldMode.diamond){
      addNum=await  Flora121ValueUtils.instance.getDiamondAddReward();
    }else{
      addNum=Flora121ValueUtils.instance.getMoneyEnergyAddNum();
    }
    setState(() {});
  }

  _getWaterAddNum()async{
    var data = bGoldMode.getData();
    if(data==Flora121GoldMode.gold){
      addNum=await Flora121ValueUtils.instance.getGoldAddReward();
    }else if(data==Flora121GoldMode.diamond){
      addNum=await Flora121ValueUtils.instance.getDiamondAddReward();
    }else{
      addNum=Flora121ValueUtils.instance.getWaterAddNum();
    }
    setState(() {});
  }

  showNewUerStep4Guide(Map? flora121map){
    if(widget.flora121energyType!=Flora121EnergyType.money){
      return;
    }
    var moneyRenderBox = globalKey.currentContext!.findRenderObject() as RenderBox;
    var moneyOffset = moneyRenderBox.localToGlobal(Offset.zero);
    var treeRenderBox = widget.treeGlobalKey?.currentContext?.findRenderObject() as RenderBox;
    var treeOffset = treeRenderBox.localToGlobal(Offset.zero);
    Flora121UserGuideUtils.instance.showStep4Overlay(context, moneyOffset, treeOffset,addNum);
  }

  // showNewUerStep3Guide(Map? flora121map){
  //   if(widget.flora121energyType!=Flora121EnergyType.quiz){
  //     return;
  //   }
  //   var renderBox = globalKey.currentContext!.findRenderObject() as RenderBox;
  //   var offset = renderBox.localToGlobal(Offset.zero);
  //   Flora121UserGuideUtils.instance.showStep3Overlay(context, offset);
  // }
  //
  showNewUserStep7DiceGuide(Map? flora121map){
    if(widget.flora121energyType!=Flora121EnergyType.dice){
      return;
    }
    var renderBox = globalKey.currentContext!.findRenderObject() as RenderBox;
    var offset = renderBox.localToGlobal(Offset.zero);
    Flora121UserGuideUtils.instance.showStep7Overlay(context, offset);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}