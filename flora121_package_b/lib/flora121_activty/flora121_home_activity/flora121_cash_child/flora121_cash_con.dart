import 'dart:convert';
import 'dart:math';

import 'package:flora121_base/flora121_base/flora121_base_con.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_b/flora121_bean/flora121_amount_bean.dart';
import 'package:flora121_package_b/flora121_bean/flora121_cash_task_bean.dart';
import 'package:flora121_package_b/flora121_bean/flora121_cash_task_config_bean.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_cash_success_dialog/flora121_cash_success_dialog.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_cash_task_dialog/flora121_cash_task_dialog.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_input_email_dialog/flora121_input_email_dialog.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_input_phone_dialog/flora121_input_phone_dialog.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_input_pix_dialog/flora121_input_pix_dialog.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_no_money_dialog/flora121_no_money_dialog.dart';
import 'package:flora121_package_b/flora121_hep/flora121_cash_task_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_event_code.dart';
import 'package:flora121_package_b/flora121_hep/flora121_guide/flora121_user_guide_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_hep.dart';
import 'package:flora121_package_b/flora121_hep/flora121_storage/flora121_storage.dart';
import 'package:flora121_package_b/flora121_hep/flora121_user_info_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_value_utils.dart';
import 'package:flora121_package_b/flora_enum/flora121_cash_task_type.dart';
import 'package:flora121_package_b/flora_enum/flora121_cash_type.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Flora121CashCon extends Flora121BaseCon{
  var chooseIndex=0,_showNextCaskTaskDialog=false;

  GlobalKey firstCashAmountGlobalKey=GlobalKey();
  GlobalKey cashBtnGlobalKey=GlobalKey();
  List<Flora121AmountBean> amountList=[];
  Flora121CashTaskBean? taskBean;

  @override
  void onReady() {
    super.onReady();
    _initAmountList();
  }

  clickAmountItem(index){
    if(chooseIndex==index){
      return;
    }
    chooseIndex=index;
    update(["amount"]);
    _queryCashTaskInfo();
  }

  clickCash(){
    if(null!=taskBean){
      var totalList = Flora121CashTaskUtils.instance.getCashTaskTotalList(taskBean);
      var currentList = Flora121CashTaskUtils.instance.getCashTaskCurrentList(taskBean);
      var completedCurrentTask = Flora121CashTaskUtils.instance.checkCompletedCurrentTask(currentList, totalList);
      if(completedCurrentTask){
        Flora121RoutersHep.dialog(
          child: Flora121CashSuccessDialog(
            taskBean: taskBean,
          ),
        );
        return;
      }
      showCashTaskDialog();
      return;
    }
    var myMoney= bMyMoneyNum.getData();
    var bean = amountList[chooseIndex];
    if(myMoney<bean.money){
      Flora121RoutersHep.dialog(
        child: Flora121NoMoneyDialog(),
      );
      return;
    }
    var cashType = bSelectCashType.getData();
    switch(cashType){
      case Flora121CashType.pagBank:
      case Flora121CashType.paypal:
        Flora121RoutersHep.dialog(
          child: Flora121InputEmailDialog(
            cashType: cashType,
            sureCallback: (account){
              _inputAccountResult(account,bean.money);
            },
          ),
        );
        break;
      case Flora121CashType.cashApp:
        Flora121RoutersHep.dialog(
          child: Flora121InputPhoneDialog(
            cashType: cashType,
            sureCallback: (account){
              _inputAccountResult(account,bean.money);
            },
          ),
        );
        break;
      case Flora121CashType.pix:
        Flora121RoutersHep.dialog(
          child: Flora121InputPixDialog(
            sureCallback: (account){
              _inputAccountResult(account,bean.money);
            },
          ),
        );
        break;
    }
  }

  _inputAccountResult(String account, int money)async{
    await Flora121CashTaskUtils.instance.createCashTask(cashMoney: money, cashType: bSelectCashType.getData(), account: account,);
    _initAmountList();
  }

  showCashTaskDialog(){
    Flora121RoutersHep.dialog(
      child: Flora121CashTaskDialog(
        taskBean: taskBean,
      ),
    );
  }

  _initAmountList()async{
    amountList.clear();
    for (var value in Flora121ValueUtils.instance.getCashList()) {
      amountList.add(Flora121AmountBean(money: value));
    }
    update(["amount"]);
    if(amountList.isNotEmpty){
      _queryCashTaskInfo();
    }
  }

  _queryCashTaskInfo()async{
    taskBean = await Flora121CashTaskUtils.instance.queryCashTaskByMoneyAndType(cashMoney: amountList[chooseIndex].money, cashType: bSelectCashType.getData());
    update(["task"]);
  }

  double getCashLeft(int money){
    var data = bMyMoneyNum.getData();
    var result = (Decimal.fromInt(money)-Decimal.fromJson("$data")).toDouble();
    if(result<0){
      return 0;
    }
    return result;
  }

  double getCashLeftProgress(int money){
    if(money==0){
      return 0.0;
    }
    var data = bMyMoneyNum.getData();
    var d = data/money;
    if(d<0){
      return 0.0;
    }else if(d>1){
      return 1.0;
    }else{
      return d;
    }
  }

  @override
  bool initFlora121Event() => true;

  @override
  receivedFlora121EventMsg(int flora121Code, int? flora121IntValue, String? flora121StringValue, Map? flora121Map) {
    switch(flora121Code){
      case Flora121EventCode.showNewUserStep4GuideFirstCashAmount:
        showNewUserStep6GuideFirstCashAmount();
        break;
      case Flora121EventCode.updateCashTask:
        _queryCashTaskInfo();
        break;
      case Flora121EventCode.updateCashType:
        update(["btn","amount"]);
        _queryCashTaskInfo();
        break;
      case Flora121EventCode.updateMyMoney:
        _queryCashTaskInfo();
        break;
      case Flora121EventCode.setCashPageShowNextCaskTaskDialogTag:
        _showNextCaskTaskDialog=true;
        break;
      case Flora121EventCode.cashPageShowNextCaskTaskDialog:
        if(_showNextCaskTaskDialog){
          _showNextCaskTaskDialog=false;
          clickCash();
        }
        break;
    }
  }

  String getBtnColor(){
    switch(bSelectCashType.getData()){
      case Flora121CashType.paypal: return "#1363AE";
      case Flora121CashType.pagBank: return "#58BCBE";
      case Flora121CashType.pix: return "#09A18F";
      case Flora121CashType.cashApp: return "#30A942";
      default: return "#30A942";
    }
  }

  String getGouIcon(){
    switch(bSelectCashType.getData()){
      case Flora121CashType.paypal: return "icon_gou2";
      case Flora121CashType.pagBank: return "icon_gou5";
      case Flora121CashType.pix: return "icon_gou6";
      case Flora121CashType.cashApp: return "icon_gou7";
      default: return "icon_gou2";
    }
  }

  String getAmountItemBgColor(){
    switch(bSelectCashType.getData()){
      case Flora121CashType.paypal: return "#E6F8FF";
      case Flora121CashType.pagBank: return "#DDF8F9";
      case Flora121CashType.pix: return "#E2F9F2";
      case Flora121CashType.cashApp: return "#E3F9E7";
      default: return "#E3F9E7";
    }
  }

  String getBorderItemBgColor(){
    switch(bSelectCashType.getData()){
      case Flora121CashType.paypal: return "#4179B9";
      case Flora121CashType.pagBank: return "#14A6A9";
      case Flora121CashType.pix: return "#09A18F";
      case Flora121CashType.cashApp: return "#30A942";
      default: return "#E3F9E7";
    }
  }

  String getInsBgColor(){
    switch(bSelectCashType.getData()){
      case Flora121CashType.paypal: return "#E6F8FF";
      case Flora121CashType.pagBank: return "#DDF8F9";
      case Flora121CashType.pix: return "#E2F9F2";
      case Flora121CashType.cashApp: return "#E3F9E7";
      default: return "#E3F9E7";
    }
  }

  showNewUserStep6GuideFirstCashAmount(){
    var firstRenderBox = firstCashAmountGlobalKey.currentContext?.findRenderObject() as RenderBox;
    var firstSize = firstRenderBox.size;
    var firstOffset = firstRenderBox.localToGlobal(Offset.zero);

    var cashBtnRenderBox = cashBtnGlobalKey.currentContext?.findRenderObject() as RenderBox;
    var cashBtnOffset = cashBtnRenderBox.localToGlobal(Offset.zero);
    Flora121UserGuideUtils.instance.showStep4Overlay(context, firstOffset, firstSize,cashBtnOffset);
  }

  String getTitleStr(){
    switch(taskBean?.cashTaskIndex){
      case Flora121CashTaskIndex.tasks1: return "Security Verification";
      case Flora121CashTaskIndex.tasks2: return "Earnings Review";
      case Flora121CashTaskIndex.tasks3: return "Transaction Processing";
      case Flora121CashTaskIndex.tasks4: return "Identity Confirmation";
      case Flora121CashTaskIndex.tasks5: return "Compliance Check";
      default: return "";
    }
  }

  String getDescStr(){
    switch(taskBean?.cashTaskIndex){
      case Flora121CashTaskIndex.tasks1: return "Your withdrawal is under security verification. Please complete the required task to confirm account authenticity.";
      case Flora121CashTaskIndex.tasks2: return "Your Eco earnings are being reviewed. Verification is needed to ensure all contributions are valid.";
      case Flora121CashTaskIndex.tasks3: return "Withdrawal request is being processed. We are confirming account and transaction details for your security.";
      case Flora121CashTaskIndex.tasks4: return "Suspicious activity detected. Please complete verification tasks to confirm your identity and proceed with withdrawal.";
      case Flora121CashTaskIndex.tasks5: return "Your withdrawal is pending compliance review. Complete the required steps to validate your account and release funds.";
      default: return "";
    }
  }
}