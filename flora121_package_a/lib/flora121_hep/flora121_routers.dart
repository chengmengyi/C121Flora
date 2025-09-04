import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_package_a/flora121_activty/flora121_home_activity/flora121_home_activity.dart';

class Flora121RouterNameA{
  static final home="/packageA/home";
}

var flora121APageList=[
  GetPage(
      name: Flora121RouterNameA.home,
      page: ()=> Flora121HomeActivity(),
      transition: Transition.fadeIn
  ),
];
