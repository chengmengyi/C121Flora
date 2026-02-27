import 'dart:io';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_local_info.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_point_enum.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_ttt.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_check_adjust/flutter_check_adjust.dart';
import 'package:flutter_check_adjust/request_adjust/request_adjust_callback.dart';
import 'package:flutter_check_adjust/request_cloak/request_cloak_callback.dart';
import 'package:flutter_ios_ad_plugins/data/ad_money_info_bean.dart';
import 'package:flutter_tba_info/flutter_tba_info.dart';

class Flora121AfUtils{
  static final Flora121AfUtils _utils=Flora121AfUtils();
  static Flora121AfUtils get instance => _utils;

  Function()? aPackageCheckCallback;

  initAf()async{
    var distinctId = await FlutterTbaInfo.instance.getDistinctId();
    var cloakData={
      "penmen":await FlutterTbaInfo.instance.getBundleId(),
      "anheuser":Platform.isAndroid?"antigone":"veer",
      "soviet":await FlutterTbaInfo.instance.getAppVersion(),
      "bon":await FlutterTbaInfo.instance.getDistinctId(),
      "ova":DateTime.now().millisecondsSinceEpoch,
      "lollipop":await FlutterTbaInfo.instance.getDeviceModel(),
      "sac":await FlutterTbaInfo.instance.getOsVersion(),
      "sang":await FlutterTbaInfo.instance.getIdfv(),
      "pheasant":await FlutterTbaInfo.instance.getGaid(),
      "seaside":await FlutterTbaInfo.instance.getAndroidId(),
    };
    FlutterCheckAdjust.instance.init(
      adjustAppToken: Flora121LocalInfo.adjustTokenBase64.base64(),
      distinctId: distinctId,
      clockUrl: Flora121LocalInfo.tbaCloakUrl,
      cloakWhiteKey: "bernhard",
      cloakData: cloakData,
      referrerConfList: [],
      requestAdjustCallback: RequestAdjustCallback(
        startRequestAdjust: (){
          Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.adjust_req);
        },
        requestSuccess: (bool isB){
          Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.adjust_suc,params: {"adjust_user":isB?1:0});
          _delayCheckUser();
        },
        firstRequestAdjustB: (){
          Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.organic_to_buy);
        },
      ),
      requestCloakCallback: RequestCloakCallback(
        startRequestCloak: (){
          Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.cloak_req);
        },
        requestSuccess: (bool isWhite){
          Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.cloak_suc,params: {"cloak_user":isWhite?1:0});
          _delayCheckUser();
        },
      ),
    );
  }

  _delayCheckUser(){
    if(check()&&Platform.isIOS){
      aPackageCheckCallback?.call();
      aPackageCheckCallback=null;
    }
  }

  uploadReToAdjust(AdMoneyInfoBean? ad){
    FlutterCheckAdjust.instance.uploadAdRevenueToAdjust(ad?.networkName??"", ad?.revenue??0, ad?.adUnitId??"");
  }

  bool check(){
    if(kDebugMode){
      return true;
    }
    return FlutterCheckAdjust.instance.checkUser();
  }
}