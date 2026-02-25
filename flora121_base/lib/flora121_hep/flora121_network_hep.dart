import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flora121_base/flora121_dialog/flora121_network_dialog/flora121_network_dialog.dart';
import 'package:flora121_base/flora121_hep/flora121_af_utils.dart';
import 'package:flora121_base/flora121_hep/flora121_firebase_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_ttt.dart';

class Flora121NetworkHep{
  static final Flora121NetworkHep _hep = Flora121NetworkHep();
  static Flora121NetworkHep get instance => _hep;

  var _showing=false;
  StreamSubscription<List<ConnectivityResult>>? _subscription;
  bool _isFirstEvent = true;

  init(){
    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
      if (_isFirstEvent) {
        _isFirstEvent = false;
        return;
      }
      if(!result.contains(ConnectivityResult.mobile)&&!result.contains(ConnectivityResult.wifi)){
        _showDialog();
      }
    });
  }

  initApp(){
    _subscription = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
      if(result.contains(ConnectivityResult.mobile)||result.contains(ConnectivityResult.wifi)){
        _subscription?.cancel();
        Flora121AfUtils.instance.initAf();
        Flora121FirebaseHep.instance.initFlora121Firebase();
        Flora121Ttt.instance.uploadInstallEvent();
      }
    });
  }

  _showDialog(){
    if(_showing){
      return;
    }
    Flora121RoutersHep.dialog(
      child: Flora121NetworkDialog(
        dismissCall: (){
          _showing=false;
        },
      ),
    );
  }
}