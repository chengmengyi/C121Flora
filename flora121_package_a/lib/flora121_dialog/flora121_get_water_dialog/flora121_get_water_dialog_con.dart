import 'package:flora121_base/flora121_base/flora121_base_con.dart';
import 'package:flora121_base/flora121_hep/flora121_ad_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_package_a/flora121_hep/flora121_task_utils.dart';

class Flora121GetWaterDialogCon extends Flora121BaseCon{
  
  getDouble(int waterNum,Function() getCallback){
    Flora121AdHep.instance.showFlora121AAAAAAAA(
      adType: AdType.reward,
      closeAd: (){
        _addWater(waterNum*2,getCallback);
      },
    );
  }

  getSingle(int waterNum, Function() getCallback){
    _addWater(waterNum,getCallback);
  }

  _addWater(int addNum,Function() getCallback)async{
    await Flora121TaskUtils.instance.updateTaskByType(TaskType.water, addNum);
    Flora121RoutersHep.back();
    getCallback.call();
  }
}