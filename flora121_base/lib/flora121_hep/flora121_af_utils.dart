import 'dart:io';

import 'package:adjust_sdk/adjust.dart';
import 'package:adjust_sdk/adjust_ad_revenue.dart';
import 'package:adjust_sdk/adjust_attribution.dart';
import 'package:adjust_sdk/adjust_config.dart';
import 'package:adjust_sdk/adjust_event_success.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_local_info.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_point_enum.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_ttt.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_android_ad_plugins/data/ad_money_info_bean.dart';
import 'package:flutter_check_af/flutter_check_af.dart';
import 'package:flutter_check_af/request_af/request_af_callback.dart';
import 'package:flutter_check_af/request_cloak/request_cloak_callback.dart';
import 'package:flutter_tba_info/flutter_tba_info.dart';

class Flora121AfUtils{
  static final Flora121AfUtils _utils=Flora121AfUtils();
  static Flora121AfUtils get instance => _utils;

  initAf()async{
    var distinctId = await FlutterTbaInfo.instance.getDistinctId();
    _initAdjust(distinctId);
    FlutterCheckAf.instance.init(
      afKey: Flora121LocalInfo.afAppkeyBase64.base64(),
      afAppId: "",
      afSwitch: "1",
      distinctId: distinctId,
      clockUrl: Flora121LocalInfo.tbaCloakUrl,
      cloakWhiteKey: "bernhard",
      cloakData: await _initCloakData(distinctId),
      requestAfCallback: _afCall(),
      requestCloakCallback: _cloakCall(),
    );
  }

  _initAdjust(String distinctId)async{
    Adjust.addGlobalCallbackParameter("customer_user_id", distinctId);
    var adjustConfig = AdjustConfig(Flora121LocalInfo.adjustTokenBase64.base64(), AdjustEnvironment.production);
    adjustConfig.attributionCallback=(AdjustAttribution attributionChangedData) {
      var network = attributionChangedData.network??"";
      FlutterCheckAf.instance.log("adjust====>attributionCallback===>$network");
      // if(network.isNotEmpty&&!network.contains("Organic")){
      //   LocalStorage.write(LocalStorageKey.localAdjustIsBuyUserKey, true);
      //   checkListener?.adjustChangeToBuyUser();
      // }
      // checkListener?.adjustResultCall(network);
    };
    adjustConfig.eventSuccessCallback= (AdjustEventSuccess eventSuccessData) {
      FlutterCheckAf.instance.log("adjust====>eventSuccessCallback");
      // checkListener?.adjustEventCall(eventSuccessData);
    };
    Adjust.initSdk(adjustConfig);
  }

  test()async{
    FlutterCheckAf.instance.log("adjust====>attributionC");
    var distinctId = await FlutterTbaInfo.instance.getDistinctId();
    Adjust.addGlobalCallbackParameter("customer_user_id", distinctId);
    var adjustConfig = AdjustConfig(Flora121LocalInfo.adjustTokenBase64.base64(), AdjustEnvironment.production);
    adjustConfig.attributionCallback=(AdjustAttribution attributionChangedData) {
      var network = attributionChangedData.network??"";
      FlutterCheckAf.instance.log("adjust====>attributionCallback===>$network");
      // if(network.isNotEmpty&&!network.contains("Organic")){
      //   LocalStorage.write(LocalStorageKey.localAdjustIsBuyUserKey, true);
      //   checkListener?.adjustChangeToBuyUser();
      // }
      // checkListener?.adjustResultCall(network);
    };
    adjustConfig.eventSuccessCallback= (AdjustEventSuccess eventSuccessData) {
      FlutterCheckAf.instance.log("adjust====>eventSuccessCallback");
      // checkListener?.adjustEventCall(eventSuccessData);
    };
    Adjust.initSdk(adjustConfig);
  }

  uploadReToAdjust(AdMoneyInfoBean? ad){
    var adjustAdRevenue = AdjustAdRevenue("applovin_max_sdk");
    adjustAdRevenue.setRevenue(ad?.revenue??0, "USD");
    adjustAdRevenue.adRevenueNetwork=ad?.networkName;
    adjustAdRevenue.adRevenueUnit=ad?.adUnitId;
    Adjust.trackAdRevenue(adjustAdRevenue);
  }

  RequestAfCallback _afCall()=>RequestAfCallback(
    startRequestAf: (){
      Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.af_req);
    },
    requestSuccess: (bool isB){
      Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.af_suc,params: {"adj_user":isB?1:0});
    },
    firstRequestAfB: (){
      // Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.organic_to_buy);
    },
    startAfSuccess: (){},
    startAfFail: (int code,String msg){},
  );

  RequestCloakCallback _cloakCall()=>RequestCloakCallback(
    startRequestCloak: (){
      Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.cloak_req);
    },
    requestSuccess: (bool isWhite){
      //cloak_user：【0】【1】，对应【黑名单用户】【自然量用户】
      Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.cloak_suc,params: {"cloak_user":isWhite?1:0});
    },
  );

  check(){
    FlutterCheckAf.instance.checkUser();
  }

  _initCloakData(String distinctId)async => {
    "penmen":await FlutterTbaInfo.instance.getBundleId(),
    "anheuser":Platform.isAndroid?"antigone":"veer",
    "soviet":await FlutterTbaInfo.instance.getAppVersion(),
    "bon":distinctId,
    "ova":DateTime.now().millisecondsSinceEpoch,
    "lollipop":await FlutterTbaInfo.instance.getDeviceModel(),
    "sac":await FlutterTbaInfo.instance.getOsVersion(),
    "sang":await FlutterTbaInfo.instance.getIdfv(),
    "pheasant":await FlutterTbaInfo.instance.getGaid(),
    "seaside":await FlutterTbaInfo.instance.getAndroidId(),
    "smithson":await FlutterTbaInfo.instance.getIdfa(),
    "flurry":await FlutterTbaInfo.instance.getNetworkType(),
  };
}