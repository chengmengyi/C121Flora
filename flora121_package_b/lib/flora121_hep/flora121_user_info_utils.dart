import 'dart:math';
import 'package:flora121_base/flora121_hep/flora121_ad_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_event/flora121_event_utils.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_fengkong_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_music_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_sql/flora121_base_sql_utils.dart';
import 'package:flora121_base/flora121_hep/flora121_sql/flora121_sql_name.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_point_enum.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_ttt.dart';
import 'package:flora121_package_b/flora121_bean/flora121_user_info_bean.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_money_15_80_animator_dialog/flora121_money_15_80_animator_dialog.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_money_15_80_tips_dialog/flora121_money_15_80_tips_dialog.dart';
import 'package:flora121_package_b/flora121_hep/flora121_cash_task_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_event_code.dart';
import 'package:flora121_package_b/flora121_hep/flora121_routers.dart';
import 'package:flora121_package_b/flora121_hep/flora121_storage/flora121_storage.dart';
import 'package:flora121_package_b/flora121_hep/flora121_value_utils.dart';

class Flora121UserInfoUtils{
  static final Flora121UserInfoUtils _utils = Flora121UserInfoUtils();
  static Flora121UserInfoUtils get instance => _utils;

  Flora121UserInfoBean? _userInfoBean;

  initUserInfo()async{
    var database = await Flora121BaseSqlUtils.instance.initSql();
    var list = await database.query(Flora121SqlName.aUserInfo);
    if(list.isNotEmpty){
      _userInfoBean=Flora121UserInfoBean.fromJson(list.first);
      return;
    }
    var bean = Flora121UserInfoBean(
      headIcon: ["head1","head2","head3","head4","head5"].random(),
      userId: generateRandomString(9),
      healthNum: 100,
    );
    var id = await database.insert(Flora121SqlName.aUserInfo, bean.toJson());
    bean.id=id;
    _userInfoBean=bean;
  }

  updateHealth(int addNum)async{
    if(addNum==0){
      return;
    }
    _userInfoBean?.healthNum=(_userInfoBean?.healthNum??0)+addNum;
    if((_userInfoBean?.healthNum??0)<=0){
      _userInfoBean?.healthNum=0;
    }
    if((_userInfoBean?.healthNum??0)>100){
      _userInfoBean?.healthNum=100;
    }
    var database = await Flora121BaseSqlUtils.instance.initSql();
    await database.update(Flora121SqlName.aUserInfo, _userInfoBean?.toJson()??{},where: '"id" = ?',whereArgs: [_userInfoBean?.id]);
    Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.updateHealthNum);
  }

  Flora121UserInfoBean? getUserInfo()=>_userInfoBean;

  String generateRandomString(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random.secure();
    return List.generate(length, (index) => chars[random.nextInt(chars.length)]).join();
  }

  updateMyMoney(double addNum,{bool fromQuiz=false})async{
    if(addNum==0){
      return;
    }
    var goldMode = bGoldMode.getData();
    if(goldMode.isNotEmpty){
      Flora121CashTaskUtils.instance.updateGoldProgress(addNum, goldMode);
      Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.showGoldDiamondAnimator);
      return;
    }

    bMyMoneyNum.saveData((Decimal.fromJson("${bMyMoneyNum.getData()}")+Decimal.fromJson("$addNum")).toDouble());
    if(addNum>0){
      bTotalMoneyToAdProbability.saveData((Decimal.fromJson("${bTotalMoneyToAdProbability.getData()}")+Decimal.fromJson("$addNum")).toDouble());

      var moneyLevel = bLastTimeMoneyLevel.getData()+20;
      var data = bMyMoneyNum.getData();
      if(data>=moneyLevel){
        var max = ((bMyMoneyNum.getData()-moneyLevel)~/20)+1;
        for(var index=0; index<max; index++){
          Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.cash_dall,params: {"money":moneyLevel});
          bLastTimeMoneyLevel.saveData(moneyLevel);
          moneyLevel+=20;
        }
      }

      var first = Flora121ValueUtils.instance.getCashList().first;
      var getRewardNum = flora121RewardRevenuePaidAccount.getData();
      var adLittle = Flora121FengkongHep.instance.getAdLittle();
      if(data>=first&&getRewardNum<adLittle){
        flora121HasMoneyRewardAdLittle.saveData(true);
      }
      var adMore = Flora121FengkongHep.instance.getAdMore();
      if(data<first&&getRewardNum>=adMore){
        flora121NoMoneyRewardAdMany.saveData(true);
      }
      Flora121MusicHep.instance.playOtherAudio(AudioName.money);
      Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.showMoneyAnimator,flora121Map: {"bool":fromQuiz});
      await Future.delayed(Duration(milliseconds: 1200));
      Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.updateMyMoney);
      if(data>=first&&bLastShowHasMoneyDialogTimer.getData()!=getTodayTimeStr()){
        bLastShowHasMoneyDialogTimer.saveData(getTodayTimeStr());
        Flora121CashTaskUtils.instance.showGoldStepDialog(first);
      }
      if(bShowMoney15Animator.getData()&&data>=15){
        bShowMoney15Animator.saveData(false);
        _showMoney15And80Animator();
      }
      if(bShowMoney80Animator.getData()&&data>=70){
        bShowMoney80Animator.saveData(false);
        _showMoney15And80Animator();
      }
    }else{
      Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.updateMyMoney);
    }
  }

  _showMoney15And80Animator(){
    Flora121RoutersHep.dialog(
      child: Flora121Money1580AnimatorDialog(
        dismissCallback: (){
          Flora121RoutersHep.dialog(child: Flora121Money1580TipsDialog());
        },
      ),
    );
  }
}