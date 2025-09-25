import 'package:flora121/flora121_launch/flora121_base_router.dart';
import 'package:flora121_base/flora121_hep/flora121_ad_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_af_utils.dart';
import 'package:flora121_base/flora121_hep/flora121_base_router_name.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_firebase_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_ttt.dart';
import 'package:flora121_package_a/flora121_hep/flora121_energy_utils.dart';
import 'package:flora121_package_a/flora121_hep/flora121_routers.dart';
import 'package:flora121_package_a/flora121_hep/flora121_sign_utils.dart';
import 'package:flora121_package_a/flora121_hep/flora121_task_utils.dart';
import 'package:flora121_package_a/flora121_hep/flora121_user_info_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_ad_probability_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_cash_task_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_user_info_utils.dart' as bFlora121UserInfoUtils;
import 'package:flora121_package_b/flora121_hep/flora121_sign_utils.dart' as bFlora121SignUtils;
import 'package:flora121_package_a/flora121_hep/flora121_wheel_utils.dart';
import 'package:flora121_package_b/flora121_hep/flora121_routers.dart';
import 'package:flora121_package_b/flora121_hep/flora121_value_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spine_flutter/spine_flutter.dart';


void main() async{
  await _initAll();
  runApp(const MyApp());
}

_initAll()async{
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarDividerColor: null,
        statusBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
      )
  );
  await GetStorage.init();
  await initSpineFlutter();

  Flora121UserInfoUtils.instance.initUserInfo();
  Flora121TaskUtils.instance.randomTodayTask();
  Flora121EnergyUtils.instance.initEnergy();
  Flora121SignUtils.instance.initSignList();
  Flora121AdHep.instance.initFlora121Ad();
  Flora121WheelUtils.instance.initTodayWheelNum();

  Flora121AfUtils.instance.initAf();
  Flora121FirebaseHep.instance.initFlora121Firebase();
  bFlora121UserInfoUtils.Flora121UserInfoUtils.instance.initUserInfo();
  Flora121CashTaskUtils.instance.initCashTaskBean();
  Flora121ValueUtils.instance.initValue();
  bFlora121SignUtils.Flora121SignUtils.instance.initSignList();
  Flora121Ttt.instance.uploadInstallEvent();
  Flora121AdProbabilityUtils.instance.initValue();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (c,child)=>GetMaterialApp(
        title: 'PlantFortune',
        enableLog: true,
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.system,
        initialRoute: Flora121BaseRouterName.launch,
        debugShowCheckedModeBanner: false,
        getPages: flora121BasePageList+flora121APageList+flora121BPageList,
        defaultTransition: Transition.rightToLeft,
      ),
    );
  }
}