import 'package:flora121/flora121_launch/flora121_launch_activity.dart';
import 'package:flora121/flora121_web/flo121_web_avtivity.dart';
import 'package:flora121_base/flora121_hep/flora121_base_router_name.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';


var flora121BasePageList=[
  GetPage(
      name: Flora121BaseRouterName.launch,
      page: ()=> Flora121LaunchActivity(),
      transition: Transition.fadeIn
  ),
  GetPage(
      name: Flora121BaseRouterName.web,
      page: ()=> Flo121WebAvtivity(),
      transition: Transition.fadeIn
  ),
];
