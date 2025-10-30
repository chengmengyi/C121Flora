import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flora121_base/flora121_hep/flora121_ad_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_fengkong_hep.dart';

class Flora121FirebaseHep{
  static final Flora121FirebaseHep _hep=Flora121FirebaseHep();
  static Flora121FirebaseHep get instance => _hep;

  FirebaseRemoteConfig? _remoteConfig;
  Function(String value)? initAdConfigCall;
  Function(String value)? initValueConfigCall;
  Function(String value)? initCashTaskConfigCall;

  initFlora121Firebase()async{
    try{
      await Firebase.initializeApp();
      _remoteConfig=FirebaseRemoteConfig.instance;
      await _remoteConfig?.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(seconds: 1),
      ));
      await _remoteConfig?.fetchAndActivate();
      _getConfig();
    }catch(e){
      await Future.delayed(const Duration(milliseconds: 1000));
      initFlora121Firebase();
    }
  }

  _getConfig(){
    var c121_ad_int = _remoteConfig?.getString("c121_ad_int")??"";
    if(c121_ad_int.isNotEmpty){
      initAdConfigCall?.call(c121_ad_int);
    }
    var winup_number = _remoteConfig?.getString("winup_number")??"";
    if(winup_number.isNotEmpty){
      initValueConfigCall?.call(winup_number);
    }
    var c121_task = _remoteConfig?.getString("c121_task")??"";
    if(c121_task.isNotEmpty){
      initCashTaskConfigCall?.call(c121_task);
    }
    var risk_control = _remoteConfig?.getString("risk_control")??"";
    if(risk_control.isNotEmpty){
      flora121FengKongConfigStr.saveData(risk_control);
      Flora121FengkongHep.instance.initFengkong();
    }
    var frfcn_ad_config = _remoteConfig?.getString("frfcn_ad_config")??"";
    print('kk=frfcn_ad_config====${frfcn_ad_config}');
    if(frfcn_ad_config.isNotEmpty){
      flora121AdConfigStr.saveData(frfcn_ad_config);
      Flora121AdHep.instance.updateAdData();
    }
  }
}