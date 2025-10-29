import 'package:flora121_base/flora121_base/flora121_base_con.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_point_enum.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_ttt.dart';
import 'package:flora121_package_b/flora121_hep/flora121_cash_task_utils.dart';
import 'package:flora121_package_b/flora_enum/flora121_cash_type.dart';
import 'package:flutter/material.dart';

class UserGuideStep6Con extends Flora121BaseCon{
  var selectCashType=Flora121CashType.paypal;
  TextEditingController textEditingController=TextEditingController();

  @override
  void onInit() {
    super.onInit();
    Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.withdrawal_confirmation);
  }

  clickCashType(String type){
    selectCashType=type;
    update(["list","input"]);
  }

  clickSubmit(Function() dismissCallback)async{
    var s = textEditingController.text.trim();
    if(s.isEmpty){
      "No account details on file, payout failed.".showToast();
      return;
    }
    if(selectCashType==Flora121CashType.paypal&&!_isEmail(s)){
      "The format you entered is incorrect.".showToast();
      return;
    }
    if(selectCashType==Flora121CashType.cashApp&&!_isTenDigitNumber(s)){
      "The format you entered is incorrect.".showToast();
      return;
    }
    await Flora121CashTaskUtils.instance.saveCashAccount(selectCashType, s);
    Flora121RoutersHep.back();
    dismissCallback.call();
  }

  bool _isTenDigitNumber(String input) {
    return RegExp(r'^\d{10}$').hasMatch(input);
  }

  bool _isEmail(String input) {
    final emailRegex = RegExp(
      r'^[\w\.-]+@[\w\.-]+\.\w+$',
    );
    return emailRegex.hasMatch(input);
  }

  String getInputTipsStr(){
    switch(selectCashType){
      case Flora121CashType.paypal: return "e.g. 123456789@abc.com";
      case Flora121CashType.cashApp: return "e.g.5551234567";
      default: return "input your account";
    }
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }
}