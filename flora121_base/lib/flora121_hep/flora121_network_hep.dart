import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flora121_base/flora121_dialog/flora121_network_dialog/flora121_network_dialog.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';

class Flora121NetworkHep{
  static final Flora121NetworkHep _hep = Flora121NetworkHep();
  static Flora121NetworkHep get instance => _hep;

  var _showing=false;
  init(){
    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
      if(!result.contains(ConnectivityResult.mobile)||!result.contains(ConnectivityResult.wifi)){
        _showDialog();
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