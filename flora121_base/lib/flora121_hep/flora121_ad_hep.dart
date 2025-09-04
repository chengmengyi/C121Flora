import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_local_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_ad_ios_plugins/data/ad_info_data.dart';
import 'package:flutter_ad_ios_plugins/data/config_ad_data.dart';
import 'package:flutter_ad_ios_plugins/hep/ios_ad_callback.dart';
import 'package:flutter_ad_ios_plugins/hep/ios_load_ad_result_callback.dart';

class Flora121AdHep{
  static final Flora121AdHep _flora121adHep= Flora121AdHep();
  static Flora121AdHep get instance => _flora121adHep;

  initFlora121Ad(){
    FlutterIosAdHep.instance.initMax(
      maxKey: Flora121LocalInfo.maxKeyBase64.base64(),
      data: _getConfigData(),
      fengKongLogic: (){
        return false;
      },
      iosLoadAdResultCallback: iosLoadAdResultCallback,
    );
  }

  showFlora121AAAAAAAA({
    required AdType adType,
    required Function() closeAd,
  }){
    var resultData = FlutterIosAdHep.instance.getCacheResultData(adType);
    if(null==resultData){
      "Display advertisement failed, please try again later".showToast();
      return;
    }
    FlutterIosAdHep.instance.showAd(
      adType: adType,
      iosAdCallback: _getIosAdCallback(adType: adType, closeAd: closeAd),
    );
  }

  IosAdCallback _getIosAdCallback({
    required AdType adType,
    required Function() closeAd,
  })=>IosAdCallback(
    showSuccess: (ad,data){

    },
    showFail: (ad){

    },
    closeAd: (){
      closeAd.call();
    },
    revenuePaid: (ad,data){

    },
  );

  final IosLoadAdResultCallback iosLoadAdResultCallback=IosLoadAdResultCallback(
    startLoadAdCallback: (data){

    },
    loadAdSuccessCallback: (ad,data){

    },
    loadAdFailCallback: (data){

    },
  );

  ConfigAdData _getConfigData()=>ConfigAdData(
    maxShowNum: 100,
    maxClickNum: 100,
    priceSwitch: false,
    newInterList: [],
    newRewardList: [
      AdInfoData(adId: kDebugMode?"cb7ea667137bb9b3":"66014d8ee8029236", adPlat: "max", adType: AdType.reward, expireTime: 3000),
    ],
  );
}