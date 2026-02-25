import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_local_info.dart';
import 'package:flutter_ios_ad_plugins/data/ad_money_info_bean.dart';
import 'package:flutter_custom_facebook/flutter_custom_facebook.dart';

class Flora121FbHep{
  static final Flora121FbHep _flora121fbHep=Flora121FbHep();
  static Flora121FbHep get instance => _flora121fbHep;

  initFb(){
    // FlutterCustomFacebook.instance.initFaceBook(
    //   facebookId: Flora121LocalInfo.facebookIdBase64.base64(),
    //   facebookToken: Flora121LocalInfo.facebookTokenBase64.base64(),
    //   facebookAppName: "C121_GP",
    // );
  }

  uploadRe(AdMoneyInfoBean? ad){
    // FlutterCustomFacebook.instance.logPurchase(amount: ad?.revenue??0, currency: "USD",);
  }
}