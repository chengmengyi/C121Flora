import 'dart:async';

import 'package:flora121_base/flora121_base/flora121_base_con.dart';
import 'package:flora121_base/flora121_hep/flora121_ad_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_music_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_ad_enum.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_point_enum.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_ttt.dart';
import 'package:flora121_package_b/flora121_hep/flora121_ad_probability_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_cash_task_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_hep.dart';
import 'package:flora121_package_b/flora121_hep/flora121_storage/flora121_storage.dart';
import 'package:flora121_package_b/flora121_hep/flora121_user_info_utils.dart';

class Flora121CommonGetDialogCon extends Flora121BaseCon{
  var progressIndex=0,fromWater=false;
  Timer? _timer;

  Flora121CommonGetDialogCon(this.fromWater);

  @override
  void onInit() {
    super.onInit();
    _startTimer();
    Flora121MusicHep.instance.playOtherAudio(AudioName.win);
  }

  clickDouble(double addNum,bool fromNewUser, Flora121AdEnum adEnum,bool fromQuiz,Function(bool received) dismissCallback){
    if(fromNewUser){
      Flora121UserInfoUtils.instance.updateMyMoney(addNum.numX2(),fromQuiz: fromQuiz);
      Flora121RoutersHep.back();
      dismissCallback.call(true);
      return;
    }
    if(fromWater){
      Flora121UserInfoUtils.instance.updateMyMoney(addNum,fromQuiz: fromQuiz);
      Flora121RoutersHep.back();
      dismissCallback.call(true);
      return;
    }
    _uploadClickDoublePontEvent(adEnum);
    Flora121AdHep.instance.showFlora121BBBBBBB(
      adType: AdType.reward,
      adEnum: adEnum,
      showAd: Flora121AdProbabilityUtils.instance.showAd(AdType.reward),
      closeAd: (giveReward){
        if(giveReward){
          Flora121UserInfoUtils.instance.updateMyMoney(addNum.numX2(),fromQuiz: fromQuiz);
        }
        Flora121RoutersHep.back();
        dismissCallback.call(true);
      },
    );
  }

  fromLevelClickDouble(double addNum,Flora121AdEnum rvEnum,Flora121AdEnum intEnum,Function(bool received) dismissCallback){
    _uploadClickDoublePontEvent(rvEnum);
    Flora121AdHep.instance.showFlora121BBBBBBB(
      adType: AdType.interstitial,
      adEnum: intEnum,
      showAd: Flora121AdProbabilityUtils.instance.showAd(AdType.interstitial),
      closeAd: (giveReward){
        if(giveReward){
          Flora121UserInfoUtils.instance.updateMyMoney(addNum);
        }
        Flora121RoutersHep.back();
        dismissCallback.call(true);
      },
    );
  }

  clickOnly(double addNum,Flora121AdEnum adEnum,Function(bool received) dismissCallback){
    _uploadClickClosePointEvent(adEnum);
    Flora121AdHep.instance.showFlora121BBBBBBB(
      adType: AdType.interstitial,
      adEnum: adEnum,
      showAd: Flora121AdProbabilityUtils.instance.showAd(AdType.interstitial),
      closeAd: (giveReward){
        Flora121UserInfoUtils.instance.updateMyMoney(addNum);
        Flora121RoutersHep.back();
        dismissCallback.call(true);
      },
    );
  }

  clickClose(double addNum,Flora121AdEnum adEnum,Function(bool received) dismissCallback){
    _uploadClickClosePointEvent(adEnum);
    Flora121AdHep.instance.showFlora121BBBBBBB(
      adType: AdType.interstitial,
      adEnum: adEnum,
      showAd: Flora121AdProbabilityUtils.instance.showAd(AdType.interstitial),
      closeAd: (giveReward){
        Flora121RoutersHep.back();
        dismissCallback.call(false);
      },
    );
  }

  _startTimer(){
    _timer=Timer.periodic(Duration(milliseconds: 500), (t){
      progressIndex++;
      update(["progress"]);
      if(progressIndex>=2){
        _stopTimer();
      }
    });
  }

  _stopTimer(){
    _timer?.cancel();
    _timer=null;
  }

  uploadShowPointEvent(Flora121AdEnum adEnum){
    Flora121PointEnum? pointEnum;
    switch(adEnum){
      case Flora121AdEnum.frfcn_level_rv:
        pointEnum=Flora121PointEnum.home_upgrade_pop;
        break;
      case Flora121AdEnum.frfcn_signin_rv:
        pointEnum=Flora121PointEnum.home_signin_pop;
        break;
      case Flora121AdEnum.frfcn_dice_rv:
        pointEnum=Flora121PointEnum.dice_page_pop;
        break;
      case Flora121AdEnum.frfcn_wheel_rv:
        pointEnum=Flora121PointEnum.wheel_page_pop;
        break;
      case Flora121AdEnum.frfcn_quiz_rv:
        pointEnum=Flora121PointEnum.quiz_page_pop;
        break;
      default:
        break;
    }
    if(null!=pointEnum){
      Flora121Ttt.instance.uploadPointEvent(pointEnum: pointEnum);
    }
  }

  _uploadClickDoublePontEvent(Flora121AdEnum adEnum){
    Flora121PointEnum? pointEnum;
    switch(adEnum){
      case Flora121AdEnum.frfcn_level_rv:
        pointEnum=Flora121PointEnum.home_upgrade_c;
        break;
      case Flora121AdEnum.frfcn_signin_rv:
        pointEnum=Flora121PointEnum.home_signin_pop_c;
        break;
      case Flora121AdEnum.frfcn_dice_rv:
        pointEnum=Flora121PointEnum.dice_page_pop_c;
        break;
      case Flora121AdEnum.frfcn_wheel_rv:
        pointEnum=Flora121PointEnum.wheel_page_pop_c;
        break;
      case Flora121AdEnum.frfcn_quiz_rv:
        pointEnum=Flora121PointEnum.quiz_page_pop_c;
        break;
      default:
        break;
    }
    if(null!=pointEnum){
      Flora121Ttt.instance.uploadPointEvent(pointEnum: pointEnum);
    }
  }

  _uploadClickClosePointEvent(Flora121AdEnum adEnum){
    Flora121PointEnum? pointEnum;
    switch(adEnum){
      case Flora121AdEnum.frfcn_level_int:
        pointEnum=Flora121PointEnum.home_upgrade_close;
        break;
      case Flora121AdEnum.frfcn_signin_int:
        pointEnum=Flora121PointEnum.home_signin_pop_close;
        break;
      case Flora121AdEnum.frfcn_dice_int:
        pointEnum=Flora121PointEnum.dice_page_pop_close;
        break;
      case Flora121AdEnum.frfcn_wheel_int:
        pointEnum=Flora121PointEnum.wheel_page_pop_close;
        break;
      case Flora121AdEnum.frfcn_quiz_int:
        pointEnum=Flora121PointEnum.quiz_page_pop_close;
        break;
      default:
        break;
    }
    if(null!=pointEnum){
      Flora121Ttt.instance.uploadPointEvent(pointEnum: pointEnum);
    }
  }

  bool isFromSign()=>true;

  @override
  void onClose() {
    _stopTimer();
    super.onClose();
  }
}