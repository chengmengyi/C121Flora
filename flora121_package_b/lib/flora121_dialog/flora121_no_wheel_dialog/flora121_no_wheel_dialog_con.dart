import 'package:flora121_base/flora121_base/flora121_base_con.dart';
import 'package:flora121_base/flora121_hep/flora121_ad_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_ad_enum.dart';
import 'package:flora121_package_b/flora121_hep/flora121_ad_probability_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_routers.dart';
import 'package:flora121_package_b/flora121_hep/flora121_wheel_utils.dart';

class Flora121NoWheelDialogCon extends Flora121BaseCon{

  clickEarn(){
    Flora121RoutersHep.back();
    Flora121RoutersHep.toNamed(routerName: Flora121RouterNameB.quiz);
  }

  clickAd(){
    Flora121AdHep.instance.showFlora121BBBBBBB(
      adType: AdType.reward,
      showAd: Flora121AdProbabilityUtils.instance.showAd(AdType.reward),
      adEnum: Flora121AdEnum.frfcn_wheel_num_rv,
      closeAd: (give){
        if(give){
          Flora121WheelUtils.instance.updateWheelNum(1);
          Flora121RoutersHep.back();
        }
      },
    );
  }

  clickClose(){
    Flora121RoutersHep.back();
  }
}