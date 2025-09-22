import 'package:flora121_base/flora121_hep/flora121_event/flora121_event_utils.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_package_b/flora121_bean/flora121_task_bean.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_change_cash_type_dialog/flora121_change_cash_type_dialog.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_common_get_dialog/flora121_common_get_dialog.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_old_user_dialog/flora121_old_user_dialog.dart';
import 'package:flora121_package_b/flora121_hep/flora121_event_code.dart';
import 'package:flora121_package_b/flora121_hep/flora121_guide/view/flora121_new_user_step1_view.dart';
import 'package:flora121_package_b/flora121_hep/flora121_guide/view/flora121_new_user_step2_view.dart';
import 'package:flora121_package_b/flora121_hep/flora121_guide/view/flora121_new_user_step3_view.dart';
import 'package:flora121_package_b/flora121_hep/flora121_guide/view/flora121_new_user_step4_view.dart';
import 'package:flora121_package_b/flora121_hep/flora121_guide/view/flora121_new_user_step5_view.dart';
import 'package:flora121_package_b/flora121_hep/flora121_guide/view/flora121_new_user_step6_view.dart';
import 'package:flora121_package_b/flora121_hep/flora121_guide/view/flora121_new_user_step7_view.dart';
import 'package:flora121_package_b/flora121_hep/flora121_guide/view/flora121_new_user_step8_view.dart';
import 'package:flora121_package_b/flora121_hep/flora121_guide/view/flora121_new_user_step9_view.dart';
import 'package:flora121_package_b/flora121_hep/flora121_storage/flora121_storage.dart';
import 'package:flora121_package_b/flora121_hep/flora121_value_utils.dart';
import 'package:flutter/material.dart';

class Flora121UserGuideUtils{
  static final Flora121UserGuideUtils _utils = Flora121UserGuideUtils();
  static Flora121UserGuideUtils get instance => _utils;

  OverlayEntry? _overlayEntry;

  checkShowNewUserGuide(){
    var newTime = bShowNewUserGuideTimer.getData();
    if(newTime.isNotEmpty){
      var oldTime = bShowOldUserGuideTimer.getData();
      var todayTimeStr = getTodayTimeStr();
      if(newTime!=todayTimeStr&&oldTime!=todayTimeStr){
        bShowOldUserGuideTimer.saveData(todayTimeStr);
        Flora121RoutersHep.dialog(
          child: Flora121OldUserDialog(),
        );
      }
      return;
    }
    bShowNewUserGuideTimer.saveData(getTodayTimeStr());
    Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.showNewUerStep1Guide);
  }

  showStep1Overlay(BuildContext context,Offset moneyOffset,Offset treeOffset){
    showOverlay(
      context: context,
      widget: Flora121NewUserStep1View(
        moneyOffset: moneyOffset,
        treeOffset: treeOffset,
        clickCallback: (){
          hideOverlay();
          Flora121RoutersHep.dialog(
            child: Flora121CommonGetDialog(
              addNum: Flora121ValueUtils.instance.getNewUserGuideStep2AddNum().toDouble(),
              dismissCallback: (received){
                _showStep2Guide(context);
              },
            ),
          );
        },
      ),
    );
  }

  _showStep2Guide(BuildContext context){
    showOverlay(
      context: context,
      widget: Flora121NewUserStep2View(
        addNum: Flora121ValueUtils.instance.getNewUserGuideStep2AddNum().toDouble(),
        dismissCallback: (){
          hideOverlay();
          Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.showNewUerStep3Guide);
        },
      ),
    );
  }

  showStep3Overlay(BuildContext context,Offset offset){
    showOverlay(
      context: context,
      widget: Flora121NewUserStep3View(
        offset: offset,
        clickCallback: (){
          hideOverlay();
          Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.showHomeTab,flora121IntValue: 1);
          Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.showNewUserStep4DiceBtn);
        },
      ),
    );
  }

  showStep4Overlay({
    required BuildContext context,
    required Offset offset,
    required Function() dismissCallback,
  }){
    showOverlay(
      context: context,
      widget: Flora121NewUserStep4View(
        offset: offset,
        clickCallback: (){
          hideOverlay();
          dismissCallback.call();
        },
      ),
    );
  }

  showStep5Guide(BuildContext context){
    showOverlay(
      context: context,
      widget: Flora121NewUserStep5View(
        dismissCallback: (){
          hideOverlay();
          Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.showHomeTab,flora121IntValue: 3);
          Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.showNewUserStep6GuideFirstCashAmount);
        },
      ),
    );
  }

  showStep6Guide(BuildContext context,Offset firstOffset,Size firstSize,Offset cashBtnOffset){
    showOverlay(
      context: context,
      widget: Flora121NewUserStep6View(
        firstOffset: firstOffset,
        cashBtnOffset: cashBtnOffset,
        firstSize: firstSize,
        dismissCallback: (){
          hideOverlay();
          Flora121RoutersHep.dialog(
            child: Flora121ChangeCashTypeDialog(
              fromNewUserGuide: true,
            ),
          );
        },
      ),
    );
  }

  showStep7Guide({
    required BuildContext context,
    required Offset offset,
    required Size size,
    required Function() dismissCallback,
}){
    showOverlay(
      context: context,
      widget: Flora121NewUserStep7View(
        offset: offset,
        size: size,
        dismissCallback: (){
          hideOverlay();
          dismissCallback.call();
          Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.showHomeTab,flora121IntValue: 0);
          Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.showNewUserStep8HomeProgressGuide);
        },
      ),
    );
  }

  showStep8Guide(BuildContext context,Offset offset, Flora121TaskBean? taskBean){
    showOverlay(
      context: context,
      widget: Flora121NewUserStep8View(
        offset: offset,
        taskBean: taskBean,
        dismissCallback: (){
          hideOverlay();
          Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.showNewUserStep9QuizGuide);
        },
      ),
    );
  }

  showStep9Guide(BuildContext context,Offset offset){
    showOverlay(
      context: context,
      widget: Flora121NewUserStep9View(
        offset: offset,
        dismissCallback: (){
          hideOverlay();
        },
      ),
    );
  }


  showOverlay({
    required BuildContext context,
    required Widget widget,
  }){
    _overlayEntry=OverlayEntry(builder: (_)=>widget);
    Overlay.of(context).insert(_overlayEntry!);
  }

  hideOverlay(){
    _overlayEntry?.remove();
    _overlayEntry=null;
  }
}