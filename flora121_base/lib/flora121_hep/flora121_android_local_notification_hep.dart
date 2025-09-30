import 'dart:io';

import 'package:birdsong/birdsong.dart';
import 'package:flora121_base/flora121_dialog/flora121_open_notification_dialog/flora121_open_notification_dialog.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_point_enum.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_ttt.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_ad_ios_plugins/hep/ad_num_hep.dart';
import 'package:permission_handler/permission_handler.dart';

StorageData<String> bLastTimeShowNotificationTimer=StorageData<String>(key: "bLastTimeShowNotificationTimer", defaultValue: "");


class Flora121AndroidLocalNotificationHep{
  static final Flora121AndroidLocalNotificationHep _hep=Flora121AndroidLocalNotificationHep();
  static Flora121AndroidLocalNotificationHep get instance => _hep;

  final List<BirdsongText> _localNotificationList1=[
    BirdsongText(title: "Last Chance! \$30 Vanish in 60 Mins!", body: "Your cash bonus Tap NOW to rescue it!"),
    BirdsongText(title: "Roll the dice to unlock \$20", body: "Your magical move: roll the dice → receive instant cash!"),
    BirdsongText(title: "Ding Dong, wealth has arrived", body: "Just click and get \$10 easily"),
    BirdsongText(title: "Bubble popping = coins waiting! ", body: "Wealth accumulation has reached its peak, claim it now"),
    BirdsongText(title: "Ready to Cash Out?", body: "Click here to transfer your earnings instantly to PayPal or your bank account."),
    BirdsongText(title: "\$10 wealth bubbles to collect", body: "Pop bubbles to unlock and win cash prizes."),
    BirdsongText(title: "Quick! Spots Are Filling Up!", body: "The unmissable wealth reward is about to disappear!"),
    BirdsongText(title: "Your Free Spin is Ready!", body: "Feel lucky? Tap to spin the prize wheel and win instant cash."),
  ];

  final List<BirdsongText> _lockNotificationList=[
    BirdsongText(title: "\$100!Claim!", body: "Congrats! Your \$100 Spectacular ticket is activated!"),
    BirdsongText(title: "\$50 Fast – Boost activated!", body: "Your \$50 Fast ticket is ready!"),
    BirdsongText(title: "Test Rewards Available!", body: "24-Hour Special: Visible to 50% of Users Only")
  ];


  initNotification()async{
    if(Platform.isIOS){
      return;
    }
    var status = await Permission.notification.request();
    if(!status.isGranted){
      Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.noti_req_refuse);
      // if(showOpenDialog){
      //   Flora121RoutersHep.dialog(
      //     child: Flora121OpenNotificationDialog(),
      //   );
      // }
      return;
    }
    Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.noti_req_allow);

    await Birdsong.instance.initialize(
      image: BirdsongImage(big: "flora_large", small: "flora_small"),
      button: "Claim",
    );
    _initLocalNotification();
    _initLockScreenNotification();
    _initFcmNotification();
    _setShowListener();
    _setClickListener();
  }

  checkHasNotification()async{
    if(bLastTimeShowNotificationTimer.getData()==getTodayTimeStr()){
      return;
    }
    final status = await Permission.notification.status;
    if (!status.isGranted) {
      bLastTimeShowNotificationTimer.saveData(getTodayTimeStr());
      Flora121RoutersHep.dialog(
        child: Flora121OpenNotificationDialog(),
      );
    }
  }

  _initLocalNotification()async{
    Birdsong.instance.repeat(content: _localNotificationList1, duration: kDebugMode?Duration(minutes: 1):Duration(minutes: 30));
  }

  _initLockScreenNotification()async{
    Birdsong.instance.present(content: _lockNotificationList, duration: kDebugMode?Duration(minutes: 1):Duration(minutes: 30));
  }

  _initFcmNotification(){
    Birdsong.instance.subscribe(topic: "C121_us_data_fcm");
    Birdsong.instance.subscribe(topic: "C121_us_normal_fcm");
  }

  _setShowListener(){
    Birdsong.instance.onTrigger.listen((e){
      _uploadShowNotification(e.source);
    });
  }

  _setClickListener(){
    Birdsong.instance.onTap.listen((e){
      _uploadClickNotification(e.source);
    });
  }

  _uploadClickNotification(String source){
    var type=source;
    switch(source){
      case "firebase":
        type="fcm";
        break;
      case "repeat":
        type="noti";
        break;
      case "present":
        type="unlock";
        break;
    }
    Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.all_noti_c,params: {"type":type});
  }

  _uploadShowNotification(String source)async{
    var type=source;
    switch(source){
      case "firebase":
        type="fcm";
        break;
      case "repeat":
        type="noti";
        break;
      case "present":
        type="unlock";
        break;
    }
    Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.all_noti_t,params: {"type":type});
  }
}