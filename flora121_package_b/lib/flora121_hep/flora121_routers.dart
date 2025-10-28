import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_package_b/flora121_activty/flora121_has_money_tips_activity/flora121_has_money_tips_activity.dart';
import 'package:flora121_package_b/flora121_activty/flora121_home_activity/flora121_home_activity.dart';
import 'package:flora121_package_b/flora121_activty/flora121_quiz_activity/flora121_quiz_activity.dart';

class Flora121RouterNameB{
  static final home="/packageB/home";
  static final quiz="/packageB/quiz";
  static final hasMoneyTips="/packageB/hasMoneyTips";
}

var flora121BPageList=[
  GetPage(
      name: Flora121RouterNameB.home,
      page: ()=> Flora121HomeActivity(),
      transition: Transition.fadeIn
  ),
  GetPage(
      name: Flora121RouterNameB.quiz,
      page: ()=> Flora121QuizActivity(),
      transition: Transition.fadeIn
  ),
  GetPage(
      name: Flora121RouterNameB.hasMoneyTips,
      page: ()=> Flora121HasMoneyTipsActivity(),
      transition: Transition.fadeIn
  ),
];
