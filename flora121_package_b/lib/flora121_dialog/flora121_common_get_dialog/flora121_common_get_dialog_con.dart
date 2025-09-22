import 'dart:async';

import 'package:flora121_base/flora121_base/flora121_base_con.dart';
import 'package:flora121_base/flora121_hep/flora121_ad_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_ad_enum.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_point_enum.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_ttt.dart';
import 'package:flora121_package_b/flora121_hep/flora121_ad_probability_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_hep.dart';
import 'package:flora121_package_b/flora121_hep/flora121_user_info_utils.dart';

class Flora121CommonGetDialogCon extends Flora121BaseCon{
  var progressIndex=0;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    _startTimer();
  }

  clickDouble(double addNum,bool fromNewUser, Flora121AdEnum adEnum,bool fromNewUserGuideStep1, bool fromNewUserGuideStep4,Function(bool received) dismissCallback){
    if(fromNewUser){
      Flora121UserInfoUtils.instance.updateMyMoney(addNum.numX2());
      Flora121RoutersHep.back();
      dismissCallback.call(true);
      return;
    }
    _uploadClickDoublePontEvent(adEnum,fromNewUserGuideStep1,fromNewUserGuideStep4);
    Flora121AdHep.instance.showFlora121BBBBBBB(
      adType: AdType.reward,
      adEnum: adEnum,
      showAd: Flora121AdProbabilityUtils.instance.showAd(AdType.reward),
      closeAd: (giveReward){
        if(!giveReward){
          Flora121UserInfoUtils.instance.updateMyMoney(addNum.numX2());
        }
        Flora121RoutersHep.back();
        dismissCallback.call(true);
      },
    );
  }

  clickClose(double addNum,Flora121AdEnum adEnum,bool fromNewUserGuideStep1, bool fromNewUserGuideStep4,Function(bool received) dismissCallback){
    _uploadClickClosePointEvent(adEnum,fromNewUserGuideStep1,fromNewUserGuideStep4);
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
    _timer=Timer.periodic(Duration(milliseconds: 2000), (t){
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

  uploadShowPointEvent(Flora121AdEnum adEnum, bool fromNewUserGuideStep1, bool fromNewUserGuideStep4){
    if(fromNewUserGuideStep1){
      Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.new_guide,params: {"pop_step":"pop2"});
      return;
    }
    if(fromNewUserGuideStep4){
      Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.new_guide,params: {"pop_step":"pop5"});
      return;
    }
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
      default:
        break;
    }
    if(null!=pointEnum){
      Flora121Ttt.instance.uploadPointEvent(pointEnum: pointEnum);
    }
  }

  _uploadClickDoublePontEvent(Flora121AdEnum adEnum, bool fromNewUserGuideStep1, bool fromNewUserGuideStep4){
    if(fromNewUserGuideStep1){
      Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.new_guide_c,params: {"pop_step":"pop2"});
      return;
    }
    if(fromNewUserGuideStep4){
      Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.new_guide_c,params: {"pop_step":"pop5"});
      return;
    }
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
      default:
        break;
    }
    if(null!=pointEnum){
      Flora121Ttt.instance.uploadPointEvent(pointEnum: pointEnum);
    }
  }

  _uploadClickClosePointEvent(Flora121AdEnum adEnum, bool fromNewUserGuideStep1, bool fromNewUserGuideStep4){
    if(fromNewUserGuideStep1){
      Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.new_guide_c,params: {"pop_step":"pop2"});
      return;
    }
    if(fromNewUserGuideStep4){
      Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.new_guide_c,params: {"pop_step":"pop5"});
      return;
    }
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
      default:
        break;
    }
    if(null!=pointEnum){
      Flora121Ttt.instance.uploadPointEvent(pointEnum: pointEnum);
    }
  }

  @override
  void onClose() {
    _stopTimer();
    super.onClose();
  }
}