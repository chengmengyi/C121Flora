import 'dart:convert';

import 'package:flora121_base/flora121_dialog/flora121_ad_limit_dialog/flora121_ad_limit_dialog.dart';
import 'package:flora121_base/flora121_dialog/flora121_show_ad_fail_dialog/flora121_show_ad_fail_dialog.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
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

StorageData<String> flora121AdConfigStr=StorageData<String>(key: "flora121AdConfigStr", defaultValue: "");


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
    if(Flora121FengkongHep.instance.checkFengkong()){
      if(isOpen){
        closeAd.call(false);
        return;
      }
      if(adType==AdType.reward){
        "The advertisement cannot be loaded".showToast();
      }
      closeAd.call(false);
      return;
    }
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
          // _checkRewardShowTime(adType);
          // PsnFbUtils.instance.logPurchase(ad?.revenue??0.0,);
          // FlutterCheckAf.instance.uploadAdRevenue(ad?.networkName??"", ad?.revenue??0, ad?.adUnitId??"", evnetEnum.name);
          // PsnBTbaUtils.instance.adEvent(ad: ad, adEventEnum: evnetEnum, adInfoData: info);
          // PsnMusicUtils.instance.pauseBackMp3();
          // psnAdWatchNum.saveData(psnAdWatchNum.getData()+1);
          // var adLevel = psnLastAdLevel.getData()+5;
          // if(psnAdWatchNum.getData()>=adLevel){
          //   PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.cash_ad_detail,params: {"ad":adLevel});
          //   psnLastAdLevel.saveData(adLevel);
          // }
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
          // _checkRewardCloseTime(adType);
          // lookAdCallback?.call();
          Flora121MusicHep.instance.playBgm();
          closeAd.call(true);
        },
        revenuePaid: (ad,info){

        },
      ),
    );
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

    },
    loadAdSuccessCallback: (AdMoneyInfoBean adMoneyInfoBean,AdInfoData? bean,int loadTime){

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