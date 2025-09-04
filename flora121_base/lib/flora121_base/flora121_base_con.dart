import 'dart:async';
import 'package:flora121_base/flora121_hep/flora121_event/flora121_event_utils.dart';
import 'package:get/get.dart';

abstract class Flora121BaseCon extends GetxController{
  StreamSubscription<Map<String,dynamic>>? _streamSubscription;

  @override
  void onInit() {
    super.onInit();
    if(initFlora121Event()){
      _streamSubscription=Flora121EventUtils.instance.flora121ListenEventMsg(
        msgCallback: (int flora121Code,int? flora121IntValue,String? flora121StringValue,Map<dynamic,dynamic>? flora121Map){
          receivedFlora121EventMsg(flora121Code,flora121IntValue,flora121StringValue,flora121Map);
        },
      );
    }
  }

  bool initFlora121Event()=>false;

  receivedFlora121EventMsg(int flora121Code,int? flora121IntValue,String? flora121StringValue,Map<dynamic,dynamic>? flora121Map){}

  @override
  void onClose() {
    if(initFlora121Event()){
      _streamSubscription?.cancel();
      _streamSubscription=null;
    }
    super.onClose();
  }
}