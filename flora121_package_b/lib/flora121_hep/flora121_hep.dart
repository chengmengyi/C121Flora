import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_package_b/flora121_hep/flora121_storage/flora121_storage.dart';
import 'package:flora121_package_b/flora121_hep/flora121_value_utils.dart';
import 'package:flora121_package_b/flora_enum/flora121_energy_type.dart';

String getEnergyIcon(Flora121EnergyType flora121EnergyType){
  switch(flora121EnergyType){
    case Flora121EnergyType.wheel: return "energy_wheel";
    case Flora121EnergyType.money: return "energy_money";
    case Flora121EnergyType.water: return "energy_water";
    case Flora121EnergyType.dice: return "energy_dice";
    case Flora121EnergyType.quiz: return "energy_quiz";
  }
}

double getLeftCashNum(){
  var myMoney = bMyMoneyNum.getData();
  var first = Flora121ValueUtils.instance.getCashList().first;
  var d = (Decimal.fromJson("$first")-Decimal.fromJson("$myMoney")).toDouble();
  if(d<0){
    return 0;
  }
  return d;
}

extension NumDouble on double{
  double numX2()=>(Decimal.fromJson("$this")*Decimal.fromInt(2)).toDouble();
}

