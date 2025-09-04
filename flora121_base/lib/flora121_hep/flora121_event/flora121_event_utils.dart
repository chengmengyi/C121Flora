import 'dart:async';
import 'package:event_bus/event_bus.dart';

class Flora121EventUtils{
  static final Flora121EventUtils _utils = Flora121EventUtils();
  static Flora121EventUtils get instance => _utils;

  final EventBus _event=EventBus();

  sendMsg({
    required int flora121Code,
    int? flora121IntValue,
    String? flora121StringValue,
    Map<dynamic,dynamic>? flora121Map,
}){
    var params= {
      "flora121Code":flora121Code,
      "flora121IntValue":flora121IntValue,
      "flora121StringValue":flora121StringValue,
      "flora121Map":flora121Map,
    };
    _event.fire(params);
  }

  StreamSubscription<Map<String,dynamic>> flora121ListenEventMsg({
    required Function(int flora121Code,int? flora121IntValue,String? flora121StringValue,Map<dynamic,dynamic>? flora121Map) msgCallback,
}){
    return _event.on<Map<String,dynamic>>().listen((map) {
      msgCallback.call(map["flora121Code"],map["flora121IntValue"],map["flora121StringValue"],map["flora121Map"]);
    });
  }
}