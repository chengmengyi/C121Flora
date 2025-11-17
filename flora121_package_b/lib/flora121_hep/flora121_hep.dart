import 'dart:math';

import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_package_b/flora121_hep/flora121_cash_task_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_storage/flora121_storage.dart';
import 'package:flora121_package_b/flora121_hep/flora121_value_utils.dart';
import 'package:flora121_package_b/flora_enum/flora121_cash_type.dart';
import 'package:flora121_package_b/flora_enum/flora121_energy_type.dart';

String getEnergyIcon(Flora121EnergyType flora121EnergyType){
  switch(flora121EnergyType){
    case Flora121EnergyType.wheel: return "energy_wheel";
    case Flora121EnergyType.money:
      var data = bGoldMode.getData();
      if(data==Flora121GoldMode.gold){
        return "bubble_gold";
      }else if(data==Flora121GoldMode.diamond){
        return "bubble_diamond";
      }
      return "energy_money";
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

String idStar(String id){
  if(id.length!=9){
    return id;
  }
  var start = id.substring(0,1);
  var end = id.substring(6,9);
  return "$start*****$end";
}

String getCashTypeIcon(String cashType){
  switch(cashType){
    case Flora121CashType.paypal: return "icon_paypal";
    case Flora121CashType.pagBank: return "icon_pagbank";
    case Flora121CashType.pix: return "icon_pix";
    case Flora121CashType.cashApp: return "icon_cashapp";
    default: return "icon_paypal";
  }
}

String getCashTypeMoneyBg(String? type){
  switch(type){
    case Flora121CashType.paypal: return "icon_paypal_tips";
    case Flora121CashType.cashApp: return "icon_cashapp_tips";
    case Flora121CashType.pagBank: return "icon_pagbank_tips";
    case Flora121CashType.pix: return "icon_pix_tips";
    default: return "icon_paypal_tips";
  }
}


String randomTwoLetters() {
  const letters = 'abcdefghijklmnopqrstuvwxyz';
  final random = Random();
  return String.fromCharCodes(List.generate(
    2,
        (_) => letters.codeUnitAt(random.nextInt(letters.length)),
  ));
}