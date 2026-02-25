import 'dart:math';

import 'package:flora121_base/flora121_base/flora121_base_con.dart';
import 'package:flora121_base/flora121_hep/flora121_event/flora121_event_utils.dart';
import 'package:flora121_base/flora121_hep/flora121_music_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_package_b/flora121_hep/flora121_event_code.dart';
import 'package:flora121_package_b/flora121_hep/flora121_routers.dart';

class Flora1215sNoOperationDialogCon extends Flora121BaseCon{

  @override
  void onInit() {
    super.onInit();
    Flora121MusicHep.instance.playNaozhong();
  }

  clickKeep(){
    Flora121RoutersHep.back();
    if(Random().nextBool()){
      Flora121RoutersHep.toNamed(routerName: Flora121RouterNameB.quiz);
    }else{
      Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.showHomeTab,flora121IntValue: 1);
    }
  }

  @override
  void onClose() {
    super.onClose();
    Flora121MusicHep.instance.stopNaozhong();
  }
}