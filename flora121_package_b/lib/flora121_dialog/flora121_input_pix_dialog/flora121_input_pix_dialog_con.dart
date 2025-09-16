import 'package:flora121_base/flora121_base/flora121_base_con.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_package_b/flora_enum/flora121_cash_type.dart';
import 'package:flutter/material.dart';

class Flora121InputPixDialogCon extends Flora121BaseCon{
  var selectCashType="Email";
  List<String> cashTypeList=["Email","Phone","CPF","EVP"];
  TextEditingController cpfTextEditingController=TextEditingController();
  TextEditingController nameTextEditingController=TextEditingController();
  TextEditingController accountTextEditingController=TextEditingController();

  clickCashTypeItem(String type){
    if(selectCashType==type){
      return;
    }
    selectCashType=type;
    update(["cash_type","account"]);
  }

  clickSure(Function(String account) sureCallback){
    var cpf = cpfTextEditingController.text.trim();
    if(!_is11DigitNumber(cpf)){
      "Enter 11-digit CPF number".showToast();
      return;
    }
    var name = nameTextEditingController.text.trim();
    if(name.contains("@")){
      "Enter the correct name".showToast();
      return;
    }
    var account = accountTextEditingController.text.trim();
    if(selectCashType=="Email"&&!_isEmail(account)){
      "The format you entered is incorrect.".showToast();
      return;
    }
    if(selectCashType=="Phone"&&!account.startsWith("+55")){
      "Please enter a valid phone number starting with 55.".showToast();
      return;
    }
    if(selectCashType=="CPF"&&!_is11DigitNumber(account)){
      "Enter 11-digit CPF number".showToast();
      return;
    }
    if(selectCashType=="EVP"&&!_is36CharsWithDash(account)){
      "Enter the correct EVP".showToast();
      return;
    }
    Flora121RoutersHep.back();
    sureCallback.call(account);
  }

  bool _is36CharsWithDash(String input) {
    return input.length == 36 && input.contains('-');
  }

  bool _isEmail(String input) {
    final emailRegex = RegExp(
      r'^[\w\.-]+@[\w\.-]+\.\w+$',
    );
    return emailRegex.hasMatch(input);
  }

  bool _isTenDigitNumber(String input) {
    return RegExp(r'^\d{10}$').hasMatch(input);
  }

  bool _is11DigitNumber(String input) {
    return RegExp(r'^\d{11}$').hasMatch(input);
  }

  String getAccountTipsStr(){
    // List<String> cashTypeList=["Email","Phone","CPF","EVP"];
    switch(selectCashType){
      case "Email":return "e.g. 123456789@abc.com";
      case "Phone":return "e.g.+55119123456789";
      case "CPF":return "e.g. 99999999999";
      case "EVP":return "e.g. 123e4567-e89b-12d3-a456-426655440000";
      default: return "";
    }
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
    cpfTextEditingController.dispose();
    nameTextEditingController.dispose();
    accountTextEditingController.dispose();
    super.onClose();
  }
}