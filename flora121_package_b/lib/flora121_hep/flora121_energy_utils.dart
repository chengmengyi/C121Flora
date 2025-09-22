import 'package:flora121_base/flora121_hep/flora121_event/flora121_event_utils.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_sql/flora121_base_sql_utils.dart';
import 'package:flora121_base/flora121_hep/flora121_sql/flora121_sql_name.dart';
import 'package:flora121_package_b/flora121_bean/flora121_energy_bean.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_common_get_dialog/flora121_common_get_dialog.dart';
import 'package:flora121_package_b/flora121_hep/flora121_event_code.dart';
import 'package:flora121_package_b/flora121_hep/flora121_storage/flora121_storage.dart';
import 'package:flora121_package_b/flora121_hep/flora121_task_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_value_utils.dart';

class Flora121EnergyUtils{

  static final Flora121EnergyUtils _utils=Flora121EnergyUtils();
  static Flora121EnergyUtils get instance => _utils;

  initEnergy()async{
    var database = await Flora121BaseSqlUtils.instance.initSql();
    var list = await database.query(Flora121SqlName.aEnergy);
    if(list.isNotEmpty){
      return;
    }
    database.insert(Flora121SqlName.aEnergy, Flora121EnergyBean(energyType: EnergyType.sun,currentTime: 0,totalTime:300 ,addNum: 10,taskType: TaskType.suns).toJson());
    database.insert(Flora121SqlName.aEnergy, Flora121EnergyBean(energyType: EnergyType.fertilizer1,currentTime: 0,totalTime:180 ,addNum: 8,taskType: TaskType.fertilizer).toJson());
    database.insert(Flora121SqlName.aEnergy, Flora121EnergyBean(energyType: EnergyType.water1,currentTime: 0,totalTime:60 ,addNum: 2,taskType: TaskType.water).toJson());
    database.insert(Flora121SqlName.aEnergy, Flora121EnergyBean(energyType: EnergyType.water2,currentTime: 0,totalTime:60 ,addNum: 2,taskType: TaskType.water).toJson());
    database.insert(Flora121SqlName.aEnergy, Flora121EnergyBean(energyType: EnergyType.fertilizer2,currentTime: 0,totalTime:180 ,addNum: 8,taskType: TaskType.fertilizer).toJson());
  }

  Future<List<Flora121EnergyBean>> getEnergyList()async{
    var database = await Flora121BaseSqlUtils.instance.initSql();
    var list = await database.query(Flora121SqlName.aEnergy);
    if(list.isEmpty){
      return [];
    }
    List<Flora121EnergyBean> result=[];
    for (var value in list) {
      result.add(Flora121EnergyBean.fromJson(value));
    }
    return result;
  }

  updateEnergy(Flora121EnergyBean bean)async{
    var database = await Flora121BaseSqlUtils.instance.initSql();
    var list = await database.query(Flora121SqlName.aEnergy,where: '"energyType" = ?', whereArgs: [bean.energyType]);
    if(list.isEmpty){
      return;
    }
    await database.update(Flora121SqlName.aEnergy, bean.toJson(),where: '"id" = ?', whereArgs: [list.first["id"]]);
  }

  updateCollectEnergyNum(){
    bCollectEnergyNum.saveData(bCollectEnergyNum.getData()+1);
    var levelQuantity = Flora121ValueUtils.instance.getUpLevelQuantity();
    var isUpLevel = bCollectEnergyNum.getData()%levelQuantity==0;
    if(isUpLevel){
      Flora121RoutersHep.dialog(
        child: Flora121CommonGetDialog(
          addNum: Flora121ValueUtils.instance.getUpLevelAddNum(),
          dismissCallback: (received){},
        ),
      );
    }
  }

  int getLevelNum()=>(bCollectEnergyNum.getData()~/Flora121ValueUtils.instance.getUpLevelQuantity())+1;

  int getCollectSurplusNum()=>Flora121ValueUtils.instance.getUpLevelQuantity()-bCollectEnergyNum.getData()%Flora121ValueUtils.instance.getUpLevelQuantity();

  double getLevelPro(){
    var levelQuantity = Flora121ValueUtils.instance.getUpLevelQuantity();
    var i = (bCollectEnergyNum.getData()%levelQuantity)/levelQuantity;
    if(i<=0){
      return 0.0;
    }else if(i>=1){
      return 1.0;
    }else{
      return i;
    }
  }
}