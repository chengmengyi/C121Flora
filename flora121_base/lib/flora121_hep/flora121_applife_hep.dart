import 'dart:async';

import 'package:flora121_base/flora121_hep/flora121_ad_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_android_local_notification_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_music_hep.dart';
import 'package:flutter_ios_ad_plugins/hep/ad_type.dart';
import 'package:flutter_app_lifecycle/app_state_observer.dart';
import 'package:flutter_app_lifecycle/flutter_app_lifecycle.dart';

import 'flora121_export.dart';
import 'flora121_ttt/flora121_ad_enum.dart';

class Flora121ApplifeHep{
  static final Flora121ApplifeHep _hep=Flora121ApplifeHep();
  static Flora121ApplifeHep get instance => _hep;

  var _back=false,toOpenNotification=false;
  Timer? _timer;

  init(){
    FlutterAppLifecycle.instance.setCallObserver(
      AppStateObserver(
        call: (back){
          _callback(back);
        },
      ),
    );
  }

  _callback(bool back)async{
    if(back){
      Flora121MusicHep.instance.pauseBgm();
      _timer=Timer(Duration(milliseconds: 3000), () {
        _back=true;
      });
    }else{
      Flora121MusicHep.instance.playBgm();
      _timer?.cancel();
      _timer=null;
      if(toOpenNotification){
        await Future.delayed(Duration(milliseconds: 1000));
        Flora121AndroidLocalNotificationHep.instance.initNotification();
        toOpenNotification=false;
      }
      await Future.delayed(Duration(milliseconds: 200));
      if(_back&&!FlutterIosAdPlugins.instance.adShowing()){
        Flora121AdHep.instance.showFlora121BBBBBBB(
          adType: AdType.interstitial,
          showAd: true,
          adEnum: Flora121AdEnum.frfcn_launch,
          isOpen: true,
          closeAd: (giveReward){

          },
        );
      }
      _back=false;
    }
  }
}