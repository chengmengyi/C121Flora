import 'dart:async';

import 'package:flora121_base/flora121_hep/flora121_event/flora121_event_utils.dart';
import 'package:flutter/material.dart';

abstract class Flora121BaseStateful extends StatefulWidget{}

abstract class Flora121BaseStatefulState<T extends Flora121BaseStateful> extends State<T>{
  StreamSubscription<Map<String,dynamic>>? _streamSubscription;

  @override
  void initState() {
    super.initState();
    if(initFlora121Event()){
      _streamSubscription=Flora121EventUtils.instance.flora121ListenEventMsg(
        msgCallback: (int flora121Code,int? flora121IntValue,String? flora121StringValue,Map<dynamic,dynamic>? flora121Map){
          receivedFlora121EventMsg(flora121Code,flora121IntValue,flora121StringValue,flora121Map);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context){
    return initBaseWidgetFlora121();
  }

  Widget initBaseWidgetFlora121();

  bool initFlora121Event()=>false;

  receivedFlora121EventMsg(int flora121Code,int? flora121IntValue,String? flora121StringValue,Map<dynamic,dynamic>? flora121Map){}

  @override
  void dispose() {
    if(initFlora121Event()){
      _streamSubscription?.cancel();
      _streamSubscription=null;
    }
    super.dispose();
  }
}