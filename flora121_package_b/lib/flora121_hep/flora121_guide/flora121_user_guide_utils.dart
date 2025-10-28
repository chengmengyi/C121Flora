import 'dart:async';
import 'package:flora121_base/flora121_hep/flora121_ad_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_android_local_notification_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_event/flora121_event_utils.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_ad_enum.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_old_user_dialog/flora121_old_user_dialog.dart';
import 'package:flora121_package_b/flora121_hep/flora121_event_code.dart';
import 'package:flora121_package_b/flora121_hep/flora121_guide/new_view/user_guide_step4/flora121_user_guide_step4_view.dart';
import 'package:flora121_package_b/flora121_hep/flora121_guide/new_view/user_guide_question_dialog/user_guide_question_dialog.dart';
import 'package:flora121_package_b/flora121_hep/flora121_guide/new_view/user_guide_step1/user_guide_step1_dialog.dart';
import 'package:flora121_package_b/flora121_hep/flora121_guide/new_view/user_guide_step2/user_guide_step2_dialog.dart';
import 'package:flora121_package_b/flora121_hep/flora121_guide/new_view/user_guide_step3/user_guide_step3_dialog.dart';
import 'package:flora121_package_b/flora121_hep/flora121_guide/new_view/user_guide_step5/user_guide_step5_dialog.dart';
import 'package:flora121_package_b/flora121_hep/flora121_guide/new_view/user_guide_step6/user_guide_step6_dialog.dart';
import 'package:flora121_package_b/flora121_hep/flora121_guide/new_view/user_guide_step7/user_guide_step7_view.dart';
import 'package:flora121_package_b/flora121_hep/flora121_guide/new_view/user_guide_step8/user_guide_step8_view.dart';
import 'package:flora121_package_b/flora121_hep/flora121_storage/flora121_storage.dart';
import 'package:flora121_package_b/flora121_hep/flora121_user_info_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_value_utils.dart';
import 'package:flutter/foundation.dart';
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
          child: Flora121OldUserDialog(
            dismissCall: (){
              Flora121AndroidLocalNotificationHep.instance.checkHasNotification();
            },
          ),
        );
      }else{
        Flora121AndroidLocalNotificationHep.instance.checkHasNotification();
      }
      return;
    }
    Flora121RoutersHep.dialog(
      child: UserGuideQuestionDialog(
        dismissCallback: (){
          bShowNewUserGuideTimer.saveData(getTodayTimeStr());
          _showStep1Dialog();
        },
      ),
    );
  }

  _showStep1Dialog(){
    Flora121RoutersHep.dialog(
      child: UserGuideStep1Dialog(
        dismissCallback: (){
          _showStep2Dialog();
        },
      ),
    );
  }

  _showStep2Dialog(){
    Flora121RoutersHep.dialog(
      child: UserGuideStep2Dialog(
        dismissCallback: (){
          _showStep3Dialog();
        },
      ),
    );
  }

  _showStep3Dialog(){
    Flora121RoutersHep.dialog(
      child: UserGuideStep3Dialog(
        dismissCallback: (){
          Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.showNewUerStep4Guide);
        },
      ),
    );
  }

  showStep4Overlay(BuildContext context,Offset moneyOffset,Offset treeOffset){
    showOverlay(
      context: context,
      widget: Flora121UserGuideStep4View(
        moneyOffset: moneyOffset,
        treeOffset: treeOffset,
        clickCallback: (){
          hideOverlay();
          Flora121AdHep.instance.showFlora121BBBBBBB(
            adType: AdType.reward,
            showAd: true,
            isMoneyGuide: true,
            adEnum: Flora121AdEnum.frfcn_cash_rv,
            closeAd: (give){
              var guideAddNum = Flora121ValueUtils.instance.getMoneyGuideAddNum();
              if(give){
                Flora121UserInfoUtils.instance.updateMyMoney(guideAddNum.toDouble());
              }
              _showStep5Dialog(guideAddNum);
            },
          );
        },
      ),
    );
  }

  _showStep5Dialog(int guideAddNum){
    Flora121RoutersHep.dialog(
      child: UserGuideStep5Dialog(
        addNum: guideAddNum,
        dismissCallback: (){
          _showStep6Dialog();
        },
      ),
    );
  }

  _showStep6Dialog(){
    Flora121RoutersHep.dialog(
      child: UserGuideStep6Dialog(
        dismissCallback: (){
          Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.showNewUserStep7DiceGuide);
        },
      ),
    );
  }

  showStep7Overlay(BuildContext context,Offset offset){
    showOverlay(
      context: context,
      widget: UserGuideStep7View(
        offset: offset,
        clickCallback: (){
          hideOverlay();
          Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.showHomeTab,flora121IntValue: 1);
          Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.showNewUserStep8DiceBtn);
        },
      ),
    );
  }

  showStep8Guide({
    required BuildContext context,
    required Offset offset,
    required Function() dismissCallback,
  }){
    showOverlay(
      context: context,
      widget: UserGuideStep8View(
        offset: offset,
        clickCallback: (){
          hideOverlay();
          dismissCallback.call();
          Flora121AndroidLocalNotificationHep.instance.checkHasNotification();
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