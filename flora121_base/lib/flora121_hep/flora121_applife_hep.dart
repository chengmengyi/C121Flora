import 'package:flora121_base/flora121_hep/flora121_music_hep.dart';
import 'package:flutter_app_lifecycle/app_state_observer.dart';
import 'package:flutter_app_lifecycle/flutter_app_lifecycle.dart';

class Flora121ApplifeHep{
  static final Flora121ApplifeHep _hep=Flora121ApplifeHep();
  static Flora121ApplifeHep get instance => _hep;

  init(){
    FlutterAppLifecycle.instance.setCallObserver(
      AppStateObserver(
        call: (back){
          if(back){
            Flora121MusicHep.instance.pauseBgm();
          }else{
            Flora121MusicHep.instance.playBgm();
          }
        },
      ),
    );
  }
}