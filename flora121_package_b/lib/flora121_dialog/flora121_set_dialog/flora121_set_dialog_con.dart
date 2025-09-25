import 'package:flora121_base/flora121_base/flora121_base_con.dart';
import 'package:flora121_base/flora121_hep/flora121_event/flora121_event_utils.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_local_info.dart';
import 'package:flora121_base/flora121_hep/flora121_music_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_point_enum.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_ttt.dart';
import 'package:flora121_package_b/flora121_hep/flora121_event_code.dart';
import 'package:flora121_package_b/flora121_hep/flora121_storage/flora121_storage.dart';

class Flora121SetDialogCon extends Flora121BaseCon{
  @override
  void onInit() {
    super.onInit();
    Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.home_set_pop);
  }

  clickUserAgreement(){
    toWebActivity("User Agreement", Flora121LocalInfo.userAgreement);
  }

  clickPrivacy(){
    toWebActivity("Privacy Policy", Flora121LocalInfo.privacy);
  }

  clickMusic(){
    Flora121MusicHep.instance.onOrOffMusic();
    update(["music"]);
  }

  clickBarrage(){
    bBarrageSwitch.saveData(!bBarrageSwitch.getData());
    update(["barrage"]);
    Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.updateBarrageShow);
  }

  clickClose(){
    Flora121RoutersHep.back();
  }
}