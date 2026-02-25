import 'dart:io';
import 'package:flora121_base/flora121_dialog/flora121_open_notification_dialog/flora121_open_notification_dialog.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_point_enum.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_ttt.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_ios_ad_plugins/hep/ad_num_hep.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

StorageData<String> bLastTimeShowNotificationTimer=StorageData<String>(key: "bLastTimeShowNotificationTimer", defaultValue: "");


class Flora121AndroidLocalNotificationHep{
  static final Flora121AndroidLocalNotificationHep _hep=Flora121AndroidLocalNotificationHep();
  static Flora121AndroidLocalNotificationHep get instance => _hep;

  var plugin=FlutterLocalNotificationsPlugin();

  final List<BirdsongText> _localNotificationList1=[
    BirdsongText(id: 1,title: "Last Chance! \$30 Vanish in 60 Mins!", body: "Your cash bonus Tap NOW to rescue it!"),
    BirdsongText(id: 2,title: "Roll the dice to unlock \$20", body: "Your magical move: roll the dice → receive instant cash!"),
    BirdsongText(id: 3,title: "Ding Dong, wealth has arrived", body: "Just click and get \$10 easily"),
    BirdsongText(id: 4,title: "Bubble popping = coins waiting! ", body: "Wealth accumulation has reached its peak, claim it now"),
    BirdsongText(id: 5,title: "Ready to Cash Out?", body: "Click here to transfer your earnings instantly to PayPal or your bank account."),
    BirdsongText(id: 6,title: "\$10 wealth bubbles to collect", body: "Pop bubbles to unlock and win cash prizes."),
    BirdsongText(id: 7,title: "Quick! Spots Are Filling Up!", body: "The unmissable wealth reward is about to disappear!"),
    BirdsongText(id: 8,title: "Your Free Spin is Ready!", body: "Feel lucky? Tap to spin the prize wheel and win instant cash."),
  ];


  initNotification()async{
    var success = await plugin.initialize(
      onDidReceiveNotificationResponse: (
          NotificationResponse notificationResponse) {
        switch (notificationResponse.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            _uploadClickNotification(notificationResponse.id);
            break;
          case NotificationResponseType.selectedNotificationAction:
            _uploadClickNotification(notificationResponse.id);
            break;
        }
      },
      settings: InitializationSettings(
        iOS: DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        ),
      ),
    );
    if(success==true){
      for(var index=0;index<_localNotificationList1.length;index++){
        _show(_localNotificationList1[index], kDebugMode?Duration(minutes: 1):Duration(minutes: (index+1)*23));
      }
    }
  }

  _show(BirdsongText txt,Duration repeatDurationInterval){
    plugin.periodicallyShowWithDuration(
      id: txt.id,
      title: txt.title,
      body: txt.body,
      repeatDurationInterval: repeatDurationInterval,
      notificationDetails: NotificationDetails(),
    );
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

  _uploadClickNotification(int? id){
    Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.all_noti_c,params: {"id":id});
  }

  checkClickByLaunchApp()async{
    if(!Platform.isIOS){
      return;
    }
    var launchDetails = await plugin.getNotificationAppLaunchDetails();
    if(launchDetails?.didNotificationLaunchApp==true){
      var id = launchDetails?.notificationResponse?.id;
      _uploadClickNotification(id);
    }
  }
}

class BirdsongText{
  int id;
  String title;
  String body;
  BirdsongText({
    required this.id,
    required this.title,
    required this.body,
});
}