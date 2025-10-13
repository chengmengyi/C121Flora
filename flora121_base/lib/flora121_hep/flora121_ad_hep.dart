import 'dart:convert';

import 'package:flora121_base/flora121_dialog/flora121_ad_limit_dialog/flora121_ad_limit_dialog.dart';
import 'package:flora121_base/flora121_dialog/flora121_show_ad_fail_dialog/flora121_show_ad_fail_dialog.dart';
import 'package:flora121_base/flora121_hep/flora121_af_utils.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_fb_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_fengkong_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_local_info.dart';
import 'package:flora121_base/flora121_hep/flora121_music_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_ad_enum.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_point_enum.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_ttt.dart';
import 'package:flutter_ad_ios_plugins/data/ad_info_data.dart';
import 'package:flutter_ad_ios_plugins/data/ad_money_info_bean.dart';
import 'package:flutter_ad_ios_plugins/data/config_ad_data.dart';
import 'package:flutter_ad_ios_plugins/hep/ios_ad_callback.dart';
import 'package:flutter_ad_ios_plugins/hep/ios_load_ad_result_callback.dart';
import 'package:flutter_check_af/flutter_check_af.dart';

StorageData<String> flora121AdConfigStr=StorageData<String>(key: "flora121AdConfigStr", defaultValue: "");


//上次显示激励广告时间
StorageData<int> flora121ShowRewardAdTimeLastTime=StorageData<int>(key: "flora121ShowRewardAdTimeLastTime", defaultValue: 0);
//两次激励广告的时间很小的次数统计
StorageData<int> flora121TwoRewardAdIntervalTimeAccount=StorageData<int>(key: "flora121TwoRewardAdIntervalTimeAccount", defaultValue: 0);
//开始显示激励广告的时间
StorageData<int> flora121StartShowRewardAdTime=StorageData<int>(key: "flora121StartShowRewardAdTime", defaultValue: 0);
//播放到关闭激励广告的时间小的次数统计
StorageData<int> flora121CloseRewardAdIntervalTimeAccount=StorageData<int>(key: "flora121CloseRewardAdIntervalTimeAccount", defaultValue: 0);

//获取激励广告奖励次数
StorageData<int> flora121RewardRevenuePaidAccount=StorageData<int>(key: "flora121RewardRevenuePaidAccount", defaultValue: 0);

//达到提现门槛，视频次数小于3次，被风控
StorageData<bool> flora121HasMoneyRewardAdLittle=StorageData<bool>(key: "flora121HasMoneyRewardAdLittle", defaultValue: false);
//视频次数大于90次，没有达到提现门槛，被风控
StorageData<bool> flora121NoMoneyRewardAdMany=StorageData<bool>(key: "flora121NoMoneyRewardAdMany", defaultValue: false);

StorageData<int> flora121AdWatchNum=StorageData<int>(key: "flora121AdWatchNum", defaultValue: 0);
StorageData<int> flora121LastAdLevel=StorageData<int>(key: "flora121LastAdLevel", defaultValue: 0);


class Flora121AdHep{
  static final Flora121AdHep _flora121adHep= Flora121AdHep();
  static Flora121AdHep get instance => _flora121adHep;

  initFlora121Ad(){
    FlutterIosAdHep.instance.initMax(
      maxKey: Flora121LocalInfo.maxKeyBase64.base64(),
      data: _createAdData(),
      topOnAppId: Flora121LocalInfo.toponIdBase64.base64(),
      topOnAppKey: Flora121LocalInfo.toponAppkeyBase64.base64(),
      fengKongLogic: (){
        return Flora121FengkongHep.instance.checkFengkong();
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

  showFlora121BBBBBBB({
    required AdType adType,
    required bool showAd,
    required Flora121AdEnum adEnum,
    required Function(bool giveReward) closeAd,
    bool isOpen=false,
  }){
    if(!showAd){
      closeAd.call(true);
      return;
    }
    if(AdNumHep.instance.notLoad()||Flora121FengkongHep.instance.checkFengkong()){
      if(isOpen){
        closeAd.call(true);
        return;
      }
      Flora121RoutersHep.dialog(
        child: Flora121AdLimitDialog(
          dismissCall: (){
            closeAd.call(false);
          },
        ),
      );
      return;
    }
    // if(Flora121FengkongHep.instance.checkFengkong()){
    //   if(isOpen){
    //     closeAd.call(false);
    //     return;
    //   }
    //   if(adType==AdType.reward){
    //     "The advertisement cannot be loaded".showToast();
    //   }
    //   closeAd.call(false);
    //   return;
    // }
    Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.frfcn_ad_chance,params: {"ad_pos_id":adEnum.name});
    var resultData = FlutterIosAdHep.instance.getCacheResultData(adType);
    if(null==resultData){
      FlutterIosAdHep.instance.loadAdWhenNoCache(adType);
      Flora121Ttt.instance.uploadPointEvent(
        pointEnum: Flora121PointEnum.frfcn_ad_impression_fail,
        params: {
          "ad_pos_id":adEnum.name,
          "reason":"ad_nocache",
        },
      );
      if(isOpen){
        closeAd.call(true);
      }else{
        Flora121RoutersHep.dialog(
          child: Flora121ShowAdFailDialog(
            clickTryCall: (){
              var data = FlutterIosAdHep.instance.getCacheResultData(adType);
              if(null==data){
                if(adType==AdType.interstitial){
                  closeAd.call(false);
                }
              }else{
                _show(adType: adType, showAd: showAd, adEnum: adEnum, closeAd: closeAd,isOpen: isOpen);
              }
            },
          ),
        );
      }
      return;
    }
    _show(adType: adType, showAd: showAd, adEnum: adEnum, closeAd: closeAd,isOpen: isOpen);
  }

  _show({
    required AdType adType,
    required bool showAd,
    required Flora121AdEnum adEnum,
    required Function(bool giveReward) closeAd,
    bool isOpen=false,
  }){
    FlutterIosAdHep.instance.showAd(
      adType: adType,
      iosAdCallback: IosAdCallback(
        showSuccess: (ad,info){
          _showSuccess(adType);
          // PsnFbUtils.instance.logPurchase(ad?.revenue??0.0,);
          Flora121FbHep.instance.uploadRe(ad);
          Flora121AfUtils.instance.uploadReToAdjust(ad);
          FlutterCheckAf.instance.uploadAdRevenue(ad?.networkName??"", ad?.revenue??0, ad?.adUnitId??"", adEnum.name);
          Flora121Ttt.instance.uploadAdEvent(ad: ad, adEnum: adEnum, adInfoData: info);
          Flora121MusicHep.instance.pauseBgm();
          _adPv();
        },
        showFail: (){
          Flora121Ttt.instance.uploadPointEvent(
            pointEnum: Flora121PointEnum.frfcn_ad_impression_fail,
            params: {
              "ad_pos_id":adEnum.name,
              "reason":"impfail",
            },
          );
          if(isOpen){
            closeAd.call(true);
          }else{
            if(adType==AdType.reward){
              "Advertisement display failed, please try again later".showToast();
            }else{
              closeAd.call(false);
            }
          }
        },
        closeAd: (AdMoneyInfoBean? ad,AdInfoData? bean,bool hasReward){
          _closeAd(adType);
          // lookAdCallback?.call();
          Flora121MusicHep.instance.playBgm();
          closeAd.call(true);
        },
        revenuePaid: (ad,info){
          _revenuePaid(adType);
        },
      ),
    );
  }

  _showSuccess(AdType adType){
    if(adType==AdType.reward){
      flora121StartShowRewardAdTime.saveData(DateTime.now().millisecondsSinceEpoch);
      if((DateTime.now().millisecondsSinceEpoch-flora121ShowRewardAdTimeLastTime.getData())<((Flora121FengkongHep.instance.getAdShortShow()?.duration??30)*1000)){
        flora121TwoRewardAdIntervalTimeAccount.saveData(flora121TwoRewardAdIntervalTimeAccount.getData()+1);
      }
      flora121ShowRewardAdTimeLastTime.saveData(DateTime.now().millisecondsSinceEpoch);
    }
  }

  _closeAd(AdType adType){
    if(adType==AdType.reward){
      if((DateTime.now().millisecondsSinceEpoch-flora121StartShowRewardAdTime.getData())<((Flora121FengkongHep.instance.getAdShortClose()?.duration??20)*1000)){
        flora121CloseRewardAdIntervalTimeAccount.saveData(flora121CloseRewardAdIntervalTimeAccount.getData()+1);
      }
    }
  }

  _revenuePaid(AdType adType){
    if(adType==AdType.reward){
      flora121RewardRevenuePaidAccount.saveData(flora121RewardRevenuePaidAccount.getData()+1);
    }
  }

  _adPv(){
    flora121AdWatchNum.saveData(flora121AdWatchNum.getData()+1);
    var adLevel = flora121LastAdLevel.getData()+5;
    if(flora121AdWatchNum.getData()>=adLevel){
      Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.pv_dall,params: {"ad":adLevel});
      flora121LastAdLevel.saveData(adLevel);
    }
  }

  IosAdCallback _getIosAdCallback({
    required AdType adType,
    required Function() closeAd,
  })=>IosAdCallback(
    showSuccess: (ad,data){

    },
    showFail: (){

    },
    closeAd: (AdMoneyInfoBean? ad,AdInfoData? bean,bool hasReward){
      closeAd.call();
    },
    revenuePaid: (ad,data){

    },
  );

  final IosLoadAdResultCallback iosLoadAdResultCallback=IosLoadAdResultCallback(
    startLoadAdCallback: (data){
      //ad_code_id/ad_format/ad_platform
      Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.ad_request,params: {"ad_code_id":data?.adId,"ad_format":data?.adType.name,"ad_platform":data?.adPlat});
    },
    loadAdSuccessCallback: (AdMoneyInfoBean adMoneyInfoBean,AdInfoData? data,int loadTime){
      Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.frfcn_ad_return,params: {"ad_code_id":data?.adId,"ad_format":data?.adType.name,"ad_platform":data?.adPlat});
    },
    loadAdFailCallback: (data){

    },
    initSdkSuccess: (int time, String platForm) {

    },
  );

  ConfigAdData _createAdData(){
    var data = flora121AdConfigStr.getData();
    if(data.isEmpty){
      data=Flora121LocalInfo.adLocalStrBase64.base64();
    }
    var json = jsonDecode(data);
    return ConfigAdData(
      maxShowNum: json["ovunscwx"],
      maxClickNum: json["zzvurdgj"],
      priceSwitch: json["frfcn_switch"]??false,
      newInterList: _getAdList(json["frfcn_int"]),
      newRewardList: _getAdList(json["frfcn_rv"]),
    );
  }

  updateAdData(){
    FlutterIosAdHep.instance.updateAdData(_createAdData());
  }

  List<AdInfoData> _getAdList(List? list){
    if(null==list){
      return [];
    }
    List<AdInfoData> resultList=[];
    for (var value in list) {
      resultList.add(
          AdInfoData(
            adId: value["gzancebd"],
            adPlat: value["wilycear"],
            adType: value["ekhhykgh"]=="reward"?AdType.reward:AdType.interstitial,
            expireTime: value["uodzcarx"],
          )
      );
    }
    return resultList;
  }
}