import 'package:flora121_base/flora121_base/flora121_base_con.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_local_info.dart';
import 'package:flora121_base/flora121_hep/flora121_music_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';

class Flora121SetDialogCon extends Flora121BaseCon{
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

  clickClose(){
    Flora121RoutersHep.back();
  }
}