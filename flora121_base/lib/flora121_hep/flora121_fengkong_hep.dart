import 'dart:convert';

import 'package:flora121_base/flora121_hep/flora121_ad_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_local_info.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_point_enum.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_ttt.dart';
import 'package:flora_feng/flora_feng.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_android_ad_plugins/hep/ad_num_hep.dart';
import 'package:flutter_check_af/dio/dio_hep.dart';
import 'package:flutter_tba_info/flutter_tba_info.dart';

StorageData<String> flora121FengKongConfigStr=StorageData<String>(key: "flora121FengKongConfigStr", defaultValue: "");
StorageData<String> flora121RiskChanceStr=StorageData<String>(key: "flora121RiskChanceStr", defaultValue: "");

class FengkongTag{
  static const String root="root";
  static const String vpn="vpn";
  static const String sim="sim";
  static const String simulator="simulator";
  static const String developer="developer";
  static const String googleplay="googleplay";
  static const String number="number";
  static const String ip="ip";
  static const String ad_short_show="ad_short_show";
  static const String ad_short_close="ad_short_close";
  static const String wrong_deem_ad_less="wrong_deem_ad_less";
  static const String wrong_deem_ad_more="wrong_deem_ad_more";
}

class Flora121FengkongHep{
  static final Flora121FengkongHep _hep=Flora121FengkongHep();
  static Flora121FengkongHep get instance => _hep;

  var _shumengSuccess=false,_ipSuccess=false;
  Flora121FengKongBean? _flora121fengKongBean;

  initFengkong()async{
    if(_shumengSuccess&&_ipSuccess){
      return;
    }
    _initFlora121FengKongBean();
    FlutterAndroidAdPlugins.instance.setEverydayWatchAdNum(_flora121fengKongBean?.behavior?.adDailyShow??60);
    _roFlora121ot();
    _vpFlora121n();
    _siFlora121m();
    _siFlora121mulator();
    _deFlora121veloper();
    _stFlora121ore();
    _getFlora121NumberUnitID();
    _ipFlora121();
  }

  _roFlora121ot()async{
    var root = await Flora_feng.instance.roFlora121ot();
    uploadSessionCustomData({FengkongTag.root:root?1:0});
    if(root&&_flora121fengKongBean?.ui?.device!=0&&_checkHasDevice(FengkongTag.root)){
      uploadRiskChanceData(FengkongTag.root);
    }
  }

  _vpFlora121n()async{
    var vpn = await Flora_feng.instance.vpFlora121n();
    uploadSessionCustomData({FengkongTag.vpn:vpn?1:0});
    if(vpn&&_flora121fengKongBean?.ui?.device!=0&&_checkHasDevice(FengkongTag.vpn)){
      uploadRiskChanceData(FengkongTag.vpn);
    }
  }

  _siFlora121m()async{
    var sim = await Flora_feng.instance.siFlora121m();
    uploadSessionCustomData({FengkongTag.sim:sim?1:0});
    if(!sim&&_flora121fengKongBean?.ui?.device!=0&&_checkHasDevice(FengkongTag.sim)){
      uploadRiskChanceData(FengkongTag.sim);
    }
  }

  _siFlora121mulator()async{
    var simulator = await Flora_feng.instance.siFlora121mulator();
    uploadSessionCustomData({FengkongTag.simulator:simulator?1:0});
    if(simulator&&_flora121fengKongBean?.ui?.device!=0&&_checkHasDevice(FengkongTag.simulator)){
      uploadRiskChanceData(FengkongTag.simulator);
    }
  }

  _deFlora121veloper()async{
    var developer = await Flora_feng.instance.deFlora121veloper();
    uploadSessionCustomData({FengkongTag.developer:developer?1:0});
    if(developer&&_flora121fengKongBean?.ui?.device!=0&&_checkHasDevice(FengkongTag.developer)){
      uploadRiskChanceData(FengkongTag.developer);
    }
  }

  _stFlora121ore()async{
    var googleplay = await Flora_feng.instance.stFlora121ore();
    uploadSessionCustomData({FengkongTag.googleplay:googleplay?1:0});
    if(!googleplay&&_flora121fengKongBean?.ui?.device!=0&&_checkHasDevice(FengkongTag.googleplay)){
      uploadRiskChanceData(FengkongTag.googleplay);
    }
  }

  _getFlora121NumberUnitID()async{
    var numberUnitID = await Flora_feng.instance.getFlora121NumberUnitID();
    var dioResult = await DioHep.instance.requestPost(
      path: "https://sg-ddi.shuzilm.cn/q",
      data: {"protocol":2,"pkg":await FlutterTbaInfo.instance.getBundleId(),"did":numberUnitID},
    );
    print("kk=====${await FlutterTbaInfo.instance.getBundleId()}===${dioResult.success}===${dioResult.msg}");
    if(dioResult.success){
      try{
        _shumengSuccess=true;
        var json = jsonDecode(dioResult.msg);
        if(json["err"]==0&&json["device_type"]!=0&&_flora121fengKongBean?.ui?.number==1){
          uploadRiskChanceData(FengkongTag.number);
        }else{

        }
      }catch(e){

      }
    }
  }

  _ipFlora121()async{
    var dioResult = await DioHep.instance.requestPost(
      path: "https://ip-prod.plantrecordgrowth.com/api/cmonkey",
      data: {
        "amonkey":await FlutterTbaInfo.instance.getAndroidId(),
      },
    );
    if(dioResult.success){
      try{
        _ipSuccess=true;
        var result = decrypt(dioResult.msg, 20);
        var bape = jsonDecode(result)["data"]["bape"];
        if(bape&&_flora121fengKongBean?.ui?.device!=0&&_checkHasDevice(FengkongTag.ip)){
          uploadRiskChanceData(FengkongTag.ip);
        }
      }catch(e){}
    }
  }

  bool _checkHasDevice(String type)=>_flora121fengKongBean?.device?.contains(type)==true;

  uploadSessionCustomData(Map<String,dynamic> map){
    Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.session_custom,params: map);
  }

  uploadRiskChanceData(String source){
    flora121RiskChanceStr.saveData(source);
    Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.risk_chance,params: {"risk_from":source});
  }

  bool checkFengkong(){
    if(kDebugMode){
      return false;
    }
    var data = flora121RiskChanceStr.getData();
    if(data.isNotEmpty){
      uploadRiskChanceData(data);
      return true;
    }
    if(_flora121fengKongBean?.ui?.behavior!=1){
      return false;
    }
    if(flora121TwoRewardAdIntervalTimeAccount.getData()>=(getAdShortShow()?.value??3)){
      uploadRiskChanceData(FengkongTag.ad_short_show);
      return true;
    }
    if(flora121CloseRewardAdIntervalTimeAccount.getData()>=(getAdShortClose()?.value??3)){
      uploadRiskChanceData(FengkongTag.ad_short_close);
      return true;
    }
    if(flora121HasMoneyRewardAdLittle.getData()){
      uploadRiskChanceData(FengkongTag.wrong_deem_ad_less);
      return true;
    }
    if(flora121NoMoneyRewardAdMany.getData()){
      uploadRiskChanceData(FengkongTag.wrong_deem_ad_more);
      return true;
    }
    return false;
  }

  AdShortShow? getAdShortShow()=>_flora121fengKongBean?.behavior?.adShortShow;

  AdShortClose? getAdShortClose()=>_flora121fengKongBean?.behavior?.adShortClose;

  int getAdLittle()=>_flora121fengKongBean?.behavior?.wrongDeemAdLess??3;

  int getAdMore()=>_flora121fengKongBean?.behavior?.wrongDeemAdMore??90;

  _initFlora121FengKongBean(){
    try{
      var data = flora121FengKongConfigStr.getData();
      if(data.isEmpty){
        data=Flora121LocalInfo.fengkongLocalStrBase64.base64();
      }
      _flora121fengKongBean=Flora121FengKongBean.fromJson(jsonDecode(data));
    }catch(e){
      _flora121fengKongBean=Flora121FengKongBean.fromJson(jsonDecode(Flora121LocalInfo.fengkongLocalStrBase64.base64()));
    }
  }
}


class Flora121FengKongBean {
  Flora121FengKongBean({
    this.ui,
    this.behavior,
    this.device,
  });

  Flora121FengKongBean.fromJson(dynamic json) {
    ui = json['ui'] != null ? Ui.fromJson(json['ui']) : null;
    behavior = json['behavior'] != null ? Behavior.fromJson(json['behavior']) : null;
    device = json['device'] != null ? json['device'].cast<String>() : [];
  }
  Ui? ui;
  Behavior? behavior;
  List<String>? device;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (ui != null) {
      map['ui'] = ui?.toJson();
    }
    if (behavior != null) {
      map['behavior'] = behavior?.toJson();
    }
    map['device'] = device;
    return map;
  }

}

class Behavior {
  Behavior({
    this.adShortShow,
    this.adShortClose,
    this.wrongDeemAdLess,
    this.wrongDeemAdMore,
    this.noInstall,
    this.adDailyShow,});

  Behavior.fromJson(dynamic json) {
    adShortShow = json['ad_short_show'] != null ? AdShortShow.fromJson(json['ad_short_show']) : null;
    adShortClose = json['ad_short_close'] != null ? AdShortClose.fromJson(json['ad_short_close']) : null;
    wrongDeemAdLess = json['wrong_deem_ad_less'];
    wrongDeemAdMore = json['wrong_deem_ad_more'];
    noInstall = json['no_install'];
    adDailyShow = json['ad_daily_show'];
  }
  AdShortShow? adShortShow;
  AdShortClose? adShortClose;
  int? wrongDeemAdLess;
  int? wrongDeemAdMore;
  int? noInstall;
  int? adDailyShow;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (adShortShow != null) {
      map['ad_short_show'] = adShortShow?.toJson();
    }
    if (adShortClose != null) {
      map['ad_short_close'] = adShortClose?.toJson();
    }
    map['wrong_deem_ad_less'] = wrongDeemAdLess;
    map['wrong_deem_ad_more'] = wrongDeemAdMore;
    map['no_install'] = noInstall;
    map['ad_daily_show'] = adDailyShow;
    return map;
  }

}

class AdShortClose {
  AdShortClose({
    this.duration,
    this.value,});

  AdShortClose.fromJson(dynamic json) {
    duration = json['duration'];
    value = json['value'];
  }
  int? duration;
  int? value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['duration'] = duration;
    map['value'] = value;
    return map;
  }

}

class AdShortShow {
  AdShortShow({
    this.duration,
    this.value,});

  AdShortShow.fromJson(dynamic json) {
    duration = json['duration'];
    value = json['value'];
  }
  int? duration;
  int? value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['duration'] = duration;
    map['value'] = value;
    return map;
  }

}

class Ui {
  Ui({
    this.number,
    this.behavior,
    this.device,});

  Ui.fromJson(dynamic json) {
    number = json['number'];
    behavior = json['behavior'];
    device = json['device'];
  }
  int? number;
  int? behavior;
  int? device;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['number'] = number;
    map['behavior'] = behavior;
    map['device'] = device;
    return map;
  }

}