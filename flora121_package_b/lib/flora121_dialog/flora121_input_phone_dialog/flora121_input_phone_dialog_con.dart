import 'package:flora121_base/flora121_base/flora121_base_con.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_package_b/flora_enum/flora121_cash_type.dart';
import 'package:flutter/material.dart';

class Flora121InputPhoneDialogCon extends Flora121BaseCon{
  TextEditingController textEditingController=TextEditingController();

  clickSure(Function(String account) sureCallback){
    var s = textEditingController.text.trim();
    if(s.isEmpty){
      return;
    }
    if(!_isTenDigitNumber(s)){
      "The format you entered is incorrect.".showToast();
      return;
    }
    Flora121RoutersHep.back();
    sureCallback.call(s);
  }

  bool _isTenDigitNumber(String input) {
    return RegExp(r'^\d{10}$').hasMatch(input);
  }

  String getTitleColor(String cashType){
    switch(cashType){
      case Flora121CashType.pagBank: return "#69C0C2";
      case Flora121CashType.paypal: return "#1363AE";
      case Flora121CashType.cashApp: return "#30A942";
      default: return "#69C0C2";
    }
  }

  clickClose(){
    Flora121RoutersHep.back();
  }

  @override
  void onClose() {
    textEditingController.dispose();
    super.onClose();
  }
}