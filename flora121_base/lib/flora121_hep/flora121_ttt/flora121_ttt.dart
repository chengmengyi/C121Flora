import 'dart:convert';
import 'dart:io';

import 'package:flora121_base/flora121_hep/flora121_local_info.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_ad_enum.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_point_enum.dart';
import 'package:flutter_ad_ios_plugins/data/ad_info_data.dart';
import 'package:flutter_ad_ios_plugins/data/ad_money_info_bean.dart';
import 'package:flutter_ad_ios_plugins/hep/ad_num_hep.dart';
import 'package:flutter_check_af/dio/dio_hep.dart';
import 'package:flutter_check_af/flutter_check_af.dart';
import 'package:flutter_tba_info/flutter_tba_info.dart';

class Flora121Ttt {
  static final Flora121Ttt _flora121ttt=Flora121Ttt();
  static Flora121Ttt get instance => _flora121ttt;

  StorageData<bool> installEventStatus=StorageData<bool>(key: "installEventStatus", defaultValue: false);

  uploadInstallEvent()async{
    uploadSessionEvent();
    if(installEventStatus.getData()){
      return;
    }
    var logId = await FlutterTbaInfo.instance.getLogId();
    var map = await _initTopMap(logId);
    var referrerMap = await FlutterTbaInfo.instance.getReferrerMap();
    map["mullein"]="gumshoe";
    map["dakar"]=referrerMap["build"];
    map["vineyard"]=referrerMap["referrer_url"];
    map["eruption"]=referrerMap["install_version"];
    map["oodles"]=referrerMap["user_agent"];
    map["dar"]="bah";
    map["shone"]=referrerMap["referrer_click_timestamp_seconds"];
    map["avogadro"]=referrerMap["install_begin_timestamp_seconds"];
    map["keyboard"]=referrerMap["referrer_click_timestamp_server_seconds"];
    map["scrawny"]=referrerMap["install_begin_timestamp_server_seconds"];
    map["peterson"]=referrerMap["install_first_seconds"];
    map["abbas"]=referrerMap["last_update_seconds"];
    var headerMap = await _initHeaderMap();
    var url = await _initUrl(logId);
    FlutterCheckAf.instance.log("ttt---->install--->params:$map");
    var dioResult = await DioHep.instance.requestPost(path: url, data: map,header: headerMap);
    FlutterCheckAf.instance.log("ttt---->install--->result:${dioResult.success}---->$map");
    if(dioResult.success){
      installEventStatus.saveData(true);
    }
  }

  uploadSessionEvent()async{
    var logId = await FlutterTbaInfo.instance.getLogId();
    var map = await _initTopMap(logId);
    map["mullein"]="bong";
    var headerMap = await _initHeaderMap();
    var url = await _initUrl(logId);
    FlutterCheckAf.instance.log("ttt---->session--->params:$map");
    var dioResult = await DioHep.instance.requestPost(path: url, data: map,header: headerMap);
    FlutterCheckAf.instance.log("ttt---->session--->result:${dioResult.success}---->$map");
  }

  uploadAdEvent({
    required AdMoneyInfoBean? ad,
    required Flora121AdEnum adEnum,
    required AdInfoData? adInfoData,
    int tryNum=5,
  })async{
    var logId = await FlutterTbaInfo.instance.getLogId();
    var map = await _initTopMap(logId);
    map["pillar"]={
      "off":(ad?.revenue??0)*1000000,
      "patch":"USD",
      "triton":ad?.networkName??"",
      "irritant":adInfoData?.adPlat??"",
      "mundane":adInfoData?.adId??"",
      "benedict":adEnum.name,
      "spoke":adInfoData?.adType.name,
      "flesh":ad?.revenuePrecision??"",
    };
    var headerMap = await _initHeaderMap();
    var url = await _initUrl(logId);
    FlutterCheckAf.instance.log("ttt---->ad--->params:$map");
    var dioResult = await DioHep.instance.requestPost(path: url, data: map,header: headerMap);
    FlutterCheckAf.instance.log("ttt---->ad--->result:${dioResult.success}---->$map");
  }

  uploadPointEvent({
    required Flora121PointEnum pointEnum,
    Map<String,dynamic>? params,
  })async{
    var logId = await FlutterTbaInfo.instance.getLogId();
    var map = await _initTopMap(logId);
    map["mullein"]=pointEnum.name;
    if(null!=params){
      for (var value in params.keys) {
        map["ace\$$value"]=params[value];
      }
    }
    var headerMap = await _initHeaderMap();
    var url = await _initUrl(logId);
    FlutterCheckAf.instance.log("ttt---->point--->params:$map");
    var dioResult = await DioHep.instance.requestPost(path: url, data: map,header: headerMap);
    FlutterCheckAf.instance.log("ttt---->point--->result:${dioResult.success}---->$map");
  }

  Future<Map<String,dynamic>> _initTopMap(String logId)async{
    Map<String,dynamic> map={};
    map["dolce"]={
      "pheasant":await FlutterTbaInfo.instance.getGaid(),
      "anheuser":Platform.isAndroid?"antigone":"veer",
      "burch":logId,
      "jetliner":await FlutterTbaInfo.instance.getOperator(),
      "lollipop":await FlutterTbaInfo.instance.getDeviceModel(),
    };
    map["bogeymen"]={
      "ova":DateTime.now().millisecondsSinceEpoch,
      "penmen": await FlutterTbaInfo.instance.getBundleId(),
      "seaside": await FlutterTbaInfo.instance.getAndroidId(),
      "nay": await FlutterTbaInfo.instance.getManufacturer(),
      "vocal": await FlutterTbaInfo.instance.getSystemLanguage(),
    };
    map["homicide"]={
      "flurry":await FlutterTbaInfo.instance.getNetworkType(),
      "howell":await FlutterTbaInfo.instance.getBrand(),
      "soviet":await FlutterTbaInfo.instance.getAppVersion(),
    };
    map["amazon"]={
      "sang":await FlutterTbaInfo.instance.getIdfv(),
      "cerise":await FlutterTbaInfo.instance.getOsCountry(),
      "sac":await FlutterTbaInfo.instance.getOsVersion(),
      "bon":await FlutterTbaInfo.instance.getDistinctId(),
    };
    return map;
  }

  Future<Map<String,dynamic>> _initHeaderMap()async{
    Map<String,dynamic> map={
      "sac":await FlutterTbaInfo.instance.getOsVersion(),
      "penmen":await FlutterTbaInfo.instance.getBundleId(),
      "jetliner":await FlutterTbaInfo.instance.getOperator(),
    };
    return map;
  }

  Future<String> _initUrl(String logId)async{
    var appVersion = await FlutterTbaInfo.instance.getAppVersion();
    var idfv = await FlutterTbaInfo.instance.getIdfv();
    var bundleId = await FlutterTbaInfo.instance.getBundleId();
    return "${Flora121LocalInfo.tbaUrl}?soviet=$appVersion&sang=$idfv&penmen=$bundleId&burch=$logId";
  }
}