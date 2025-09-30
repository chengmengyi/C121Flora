import 'dart:async';
import 'package:flora121_base/flora121_hep/flora121_android_local_notification_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_event/flora121_event_utils.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_point_enum.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_ttt.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_app_desc_dialog/flora121_app_desc_dialog.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_change_cash_type_dialog/flora121_change_cash_type_dialog.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_newuser_get_dialog/flora121_newuser_get_dialog.dart';
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
  Timer? _timer;

  checkShowNewUserGuide(){
    Flora121RoutersHep.dialog(
      child: Flora121AppDescDialog(
        clickCallback: (){
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
          bShowNewUserGuideTimer.saveData(getTodayTimeStr());
          Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.showNewUerStep1Guide);
        },
      ),
    );
  }

  test(){
    Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.showNewUerStep1Guide);
  }

  showStep1Overlay(BuildContext context,Offset moneyOffset,Offset treeOffset){
    Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.new_guide,params: {"pop_step":"pop1"});
    showOverlay(
      context: context,
      widget: Flora121NewUserStep1View(
        moneyOffset: moneyOffset,
        treeOffset: treeOffset,
        clickCallback: (){
          Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.new_guide_c,params: {"pop_step":"pop1"});
          hideOverlay();
          Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.new_guide,params: {"pop_step":"pop2"});
          Flora121RoutersHep.dialog(
            child: Flora121NewuserGetDialog(
              addNum: Flora121ValueUtils.instance.getNewUserGuideStep2AddNum().toDouble(),
              dismissCallback: (received){
                Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.new_guide_c,params: {"pop_step":"pop2"});
                _showStep2Guide(context);
              },
            ),
          );
        },
      ),
    );
  }

  _showStep2Guide(BuildContext context)async{
    await Future.delayed(Duration(milliseconds: 1200));
    _timer=Timer(Duration(milliseconds: 3000), (){
      hideOverlay();
      Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.showNewUerStep3Guide);
    });
    showOverlay(
      context: context,
      widget: Flora121NewUserStep2View(
        addNum: Flora121ValueUtils.instance.getNewUserGuideStep2AddNum().toDouble(),
        dismissCallback: (){
          _timer?.cancel();
          _timer=null;
          hideOverlay();
          Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.showNewUerStep3Guide);
        },
      ),
    );
  }

  showStep3Overlay(BuildContext context,Offset offset){
    Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.new_guide,params: {"pop_step":"pop3"});
    showOverlay(
      context: context,
      widget: Flora121NewUserStep9View(
        offset: offset,
        dismissCallback: (){
          hideOverlay();
          Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.new_guide_c,params: {"pop_step":"pop3"});
          Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.showHomeTab,flora121IntValue: 3);
          Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.showNewUserStep4GuideFirstCashAmount);
        },
      ),
    );
  }

  showStep4Overlay(BuildContext context,Offset firstOffset,Size firstSize,Offset cashBtnOffset){
    Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.new_guide,params: {"pop_step":"pop4"});
    showOverlay(
      context: context,
      widget: Flora121NewUserStep6View(
        firstOffset: firstOffset,
        cashBtnOffset: cashBtnOffset,
        firstSize: firstSize,
        dismissCallback: (){
          hideOverlay();
          Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.new_guide_c,params: {"pop_step":"pop4"});
          Flora121RoutersHep.dialog(
            child: Flora121ChangeCashTypeDialog(
              fromNewUserGuide: true,
            ),
          );
        },
      ),
    );
  }

  showStep5Guide({
    required BuildContext context,
    required Offset offset,
    required Size size,
    required Function() dismissCallback,
  }){
    Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.new_guide,params: {"pop_step":"pop5"});
    showOverlay(
      context: context,
      widget: Flora121NewUserStep7View(
        offset: offset,
        size: size,
        dismissCallback: (){
          Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.new_guide_c,params: {"pop_step":"pop5"});
          hideOverlay();
          dismissCallback.call();
          Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.showHomeTab,flora121IntValue: 0);
          Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.showNewUserStep6HomeProgressGuide);
        },
      ),
    );
  }

  showStep6Guide(BuildContext context,Offset offset){
    Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.new_guide,params: {"pop_step":"pop6"});
    showOverlay(
      context: context,
      widget: Flora121NewUserStep8View(
        offset: offset,
        dismissCallback: (){
          hideOverlay();
          Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.new_guide_c,params: {"pop_step":"pop6"});
          Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.showNewUserStep7DiceGuide);
        },
      ),
    );
  }

  showStep7Guide(BuildContext context,Offset offset){
    Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.new_guide,params: {"pop_step":"pop7"});
    showOverlay(
      context: context,
      widget: Flora121NewUserStep3View(
        offset: offset,
        clickCallback: (){
          hideOverlay();
          Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.new_guide_c,params: {"pop_step":"pop7"});
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
    Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.new_guide,params: {"pop_step":"pop8"});
    showOverlay(
      context: context,
      widget: Flora121NewUserStep4View(
        offset: offset,
        clickCallback: (){
          hideOverlay();
          Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.new_guide_c,params: {"pop_step":"pop8"});
          dismissCallback.call();
          Flora121AndroidLocalNotificationHep.instance.checkHasNotification();
        },
      ),
    );
  }

  // showStep9Guide(BuildContext context){
  //   Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.new_guide,params: {"pop_step":"pop9"});
  //   _timer=Timer(Duration(milliseconds: 3000), (){
  //     hideOverlay();
  //     Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.new_guide,params: {"pop_step":"pop9"});
  //     Flora121AndroidLocalNotificationHep.instance.checkHasNotification();
  //   });
  //   showOverlay(
  //     context: context,
  //     widget: Flora121NewUserStep5View(
  //       dismissCallback: (){
  //         _timer?.cancel();
  //         _timer=null;
  //         hideOverlay();
  //         Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.new_guide,params: {"pop_step":"pop9"});
  //         Flora121AndroidLocalNotificationHep.instance.checkHasNotification();
  //       },
  //     ),
  //   );
  // }


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