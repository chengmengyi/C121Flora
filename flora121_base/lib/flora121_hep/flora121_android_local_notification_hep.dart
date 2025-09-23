import 'dart:io';

import 'package:flora121_base/flora121_dialog/flora121_open_notification_dialog/flora121_open_notification_dialog.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_point_enum.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_ttt.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class Flora121AndroidLocalNotificationHep{
  static final Flora121AndroidLocalNotificationHep _hep=Flora121AndroidLocalNotificationHep();
  static Flora121AndroidLocalNotificationHep get instance => _hep;

  AndroidFlutterLocalNotificationsPlugin plugin=AndroidFlutterLocalNotificationsPlugin();
  
  final List<AndroidLocalNotificationBean> _localNotificationList1=[
    AndroidLocalNotificationBean(code:1,title: "Time to water your plants and earn coins! 💰", content: "Time to water your plants and earn coins! 💰"),
    AndroidLocalNotificationBean(code:2,title: "Spin the wheel for big rewards! 🌟", content: "Spin the wheel for big rewards! 🌟"),
    AndroidLocalNotificationBean(code:3,title: "Your plants miss you! Come back and play. 🌸", content: "Your plants miss you! Come back and play. 🌸"),
  ];

  final List<AndroidLocalNotificationBean> _localNotificationList2=[
    AndroidLocalNotificationBean(code:4,title: "Answer quick quizzes and win coins! 🎯", content: "Answer quick quizzes and win coins! 🎯"),
    AndroidLocalNotificationBean(code:5,title: "Don’t forget your daily reward! 🌼", content: "Don’t forget your daily reward! 🌼"),
    AndroidLocalNotificationBean(code:6,title: "Bubble popping = coins waiting! 🫧", content: "Bubble popping = coins waiting! 🫧"),
  ];

  final List<AndroidLocalNotificationBean> _localNotificationList3=[
    AndroidLocalNotificationBean(code:7,title: "Roll the dice and grow your garden! 🎲", content: "Roll the dice and grow your garden! 🎲"),
    AndroidLocalNotificationBean(code:8,title: "Special bonus inside – open now! 🎁", content: "Special bonus inside – open now! 🎁"),
  ];

  final List<AndroidLocalNotificationBean> _lockScreenNotificationList=[
    AndroidLocalNotificationBean(code:7,title: "Complete tasks and level up! ⬆️", content: "Complete tasks and level up! ⬆️"),
    AndroidLocalNotificationBean(code:8,title: "Keep your garden happy and earn more! 💐", content: "Keep your garden happy and earn more! 💐"),
  ];


  init(bool showOpenDialog)async{
    if(Platform.isIOS){
      return;
    }
    var status = await Permission.notification.request();
    if(!status.isGranted){
      Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.noti_req_refuse);
      if(showOpenDialog){
        Flora121RoutersHep.dialog(
          child: Flora121OpenNotificationDialog(),
        );
      }
      return;
    }
    Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.noti_req_allow);
    var success = await plugin.initialize(
      AndroidInitializationSettings("logo"),
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        _uploadClickNotification(response.payload);
      },
    );
    if(success==true){
      _initLocalNotification();
      _initLockScreenNotification();
    }
  }

  _initLocalNotification()async{
    for (var value in _localNotificationList1) {
      AndroidNotificationDetails details = AndroidNotificationDetails(
        'flora_channel1',
        'flora_channel_name1',
        styleInformation: BeautyStyleInformation(
          value.title,
          value.content,
          'local_bg',
          'Claim',
          'logo',
        ),
        priority: Priority.high,
        importance: Importance.high,
        groupKey: "${value.code}",
      );
      await plugin.periodicallyShowWithDuration(
        value.code,
        value.title,
        value.content,
        kDebugMode?Duration(minutes: 1):Duration(minutes: 30),
        notificationDetails: details,
        scheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        payload: "noti1",
      );
    }
    for (var value in _localNotificationList2) {
      AndroidNotificationDetails details = AndroidNotificationDetails(
        'flora_channel2',
        'flora_channel_name2',
        styleInformation: BeautyStyleInformation(
          value.title,
          value.content,
          'local_bg',
          'Claim',
          'logo',
        ),
        priority: Priority.high,
        importance: Importance.high,
        groupKey: "${value.code}",
      );
      await plugin.periodicallyShowWithDuration(
        value.code,
        value.title,
        value.content,
        kDebugMode?Duration(minutes: 1):Duration(hours: 1),
        notificationDetails: details,
        scheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        payload: "noti2",
      );
    }
    for (var value in _localNotificationList3) {
      AndroidNotificationDetails details = AndroidNotificationDetails(
        'flora_channel3',
        'flora_channel_name3',
        styleInformation: BeautyStyleInformation(
          value.title,
          value.content,
          'local_bg',
          'Claim',
          'logo',
        ),
        priority: Priority.high,
        importance: Importance.high,
        groupKey: "${value.code}",
      );
      await plugin.periodicallyShowWithDuration(
        value.code,
        value.title,
        value.content,
        kDebugMode?Duration(minutes: 1):Duration(hours: 2),
        notificationDetails: details,
        scheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        payload: "noti3",
      );
    }
  }

  _initLockScreenNotification()async{
    AndroidLocalNotificationBean bean = _lockScreenNotificationList.random();
    await plugin.showBroadcastNotification(
      bean.code,
      bean.title,
      bean.content,
      kDebugMode?Duration(minutes: 1):Duration(minutes: 30),
      'android.intent.action.USER_PRESENT',
      AndroidNotificationDetails(
        'flora_channel_lock',
        'flora_channel_name_lock',
        priority: Priority.high,
        importance: Importance.high,
        styleInformation: BeautyStyleInformation(
          bean.title,
          bean.content,
          'local_bg',
          'Claim',
          'logo',
        ),
        groupKey: "${bean.code}",
      ),
      'lock',
    );
  }

  launchApp()async{
    if(Platform.isIOS){
      return;
    }
    var launchDetails = await plugin.getNotificationAppLaunchDetails();
    var fromNotification = launchDetails?.didNotificationLaunchApp==true;
    if(fromNotification){
      _uploadClickNotification(launchDetails?.notificationResponse?.payload);
    }
    uploadShowNotification();
  }

  _uploadClickNotification(String? payload){
    Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.all_noti_c,params: {"type":payload});
  }

  uploadShowNotification()async{
    var noti1 = await plugin.extractMessageReceivedNum("noti1");
    if(noti1>0){
      for(var index=0;index<noti1;index++){
        Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.all_noti_t,params: {"type":"noti1"});
      }
    }
    var noti2 = await plugin.extractMessageReceivedNum("noti2");
    if(noti2>0){
      for(var index=0;index<noti2;index++){
        Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.all_noti_t,params: {"type":"noti2"});
      }
    }
    var noti3 = await plugin.extractMessageReceivedNum("noti3");
    if(noti3>0){
      for(var index=0;index<noti3;index++){
        Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.all_noti_t,params: {"type":"noti3"});
      }
    }
    var lock = await plugin.extractMessageReceivedNum("lock");
    if(lock>0){
      for(var index=0;index<lock;index++){
        Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.all_noti_t,params: {"type":"lock"});
      }
    }
  }
}


class AndroidLocalNotificationBean{
  int code;
  String title;
  String content;
  AndroidLocalNotificationBean({
    required this.code,
    required this.title,
    required this.content,
  });
}