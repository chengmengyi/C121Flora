import 'package:flora121_base/flora121_base/flora121_base_con.dart';
import 'package:flora121_base/flora121_hep/flora121_ad_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_package_b/flora121_hep/flora121_task_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_user_info_utils.dart';

class Flora121GetWaterDialogCon extends Flora121BaseCon{
  
  getDouble(String taskType,bool? isHealth,int waterNum,Function() getCallback){
    Flora121AdHep.instance.showFlora121AAAAAAAA(
      adType: AdType.reward,
      closeAd: (){
        _addWater(taskType,isHealth,waterNum*2,getCallback);
      },
    );
  }

  getSingle(String taskType,bool? isHealth,int waterNum, Function() getCallback){
    _addWater(taskType,isHealth,waterNum,getCallback);
  }

  _addWater(String taskType,bool? isHealth,int addNum,Function() getCallback)async{
    if(taskType.isNotEmpty){
      await Flora121TaskUtils.instance.updateTaskByType(TaskType.water, isHealth==true?1:addNum);
    }
    if(isHealth==true){
      Flora121UserInfoUtils.instance.updateHealth(addNum);
    }
    Flora121RoutersHep.back();
    getCallback.call();
  }
}