import 'package:flora121_package_a/flora121_bean/flora121_energy_bean.dart';

String getEnergyIcon(Flora121EnergyBean bean){
  switch(bean.energyType){
    case EnergyType.sun: return "home11";
    case EnergyType.fertilizer1:
    case EnergyType.fertilizer2:
      return "home12";
    case EnergyType.water1:
    case EnergyType.water2:
      return "home13";
  }
  return "home11";
}