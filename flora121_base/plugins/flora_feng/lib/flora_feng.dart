import 'package:flutter/services.dart';

final class Flora_feng {
  static final Flora_feng instance = Flora_feng._internal();

  Flora_feng._internal();

  final _methodChannel = const MethodChannel('flora_feng');

  //设备是否被Root
  Future<bool> roFlora121ot() async {
    return (await _methodChannel.invokeMethod("roFlora121ot")) == true;
  }

  //是否连接VPN网络
  Future<bool> vpFlora121n() async {
    return (await _methodChannel.invokeMethod("vpFlora121n")) == true;
  }

  //设备是否有可用的sim卡
  Future<bool> siFlora121m() async {
    return (await _methodChannel.invokeMethod("siFlora121m")) == true;
  }

  //设备是否为模拟器
  Future<bool> siFlora121mulator() async {
    return (await _methodChannel.invokeMethod("siFlora121mulator")) == true;
  }

  //应用是否安装自Google play store
  Future<bool> stFlora121ore() async {
    return (await _methodChannel.invokeMethod("stFlora121ore")) == true;
  }

  //设备是否启用开发者模式
  Future<bool> deFlora121veloper() async {
    return (await _methodChannel.invokeMethod("deFlora121veloper")) == true;
  }

  //安装应用的安装器程序的包名
  Future<String> inFlora121staller() async {
    return await _methodChannel.invokeMethod("inFlora121staller");
  }

  //初始化数盟平台
  Future<void> inFlora121itNumberUnit({required String apiKey}) async {
    await _methodChannel.invokeMethod("inFlora121itNumberUnit", apiKey);
  }

  //从数盟平台读取数盟可信ID，对应文档请求参数：did
  Future<String> getFlora121NumberUnitID({String channel = "", String message = ""}) async {
    return (await _methodChannel.invokeMethod("geFlora121tNumberUnitID", {
          "channel": channel,
          "message": message,
        })) ??
        "";
  }
}
