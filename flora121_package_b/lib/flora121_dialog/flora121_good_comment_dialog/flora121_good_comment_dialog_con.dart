import 'package:flora121_base/flora121_base/flora121_base_con.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';

class Flora121GoodCommentDialogCon extends Flora121BaseCon{
  var index=-1;

  clickItem(int index){
    this.index=index;
    update(["list"]);
  }

  clickFeed()async{
    if(index<3){
      Flora121RoutersHep.back();
      return;
    }
    var instance = InAppReview.instance;
    if (await instance.isAvailable()) {
      instance.requestReview();
    }
    Flora121RoutersHep.back();
  }
}