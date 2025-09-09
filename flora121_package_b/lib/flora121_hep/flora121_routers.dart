import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_package_b/flora121_activty/flora121_home_activity/flora121_home_activity.dart';

class Flora121RouterNameB{
  static final home="/packageB/home";
}

var flora121BPageList=[
  GetPage(
      name: Flora121RouterNameB.home,
      page: ()=> Flora121HomeActivity(),
      transition: Transition.fadeIn
  ),
];
