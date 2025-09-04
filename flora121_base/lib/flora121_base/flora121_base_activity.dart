import 'package:flora121_base/flora121_base/flora121_base_con.dart';
import 'package:flutter/material.dart';

import '../flora121_hep/flora121_export.dart';

abstract class Flora121BaseActivity<T extends Flora121BaseCon> extends StatelessWidget{
  late T baseCon;
  bool _hasInit=false;
  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    if(!_hasInit){
      _hasInit=true;
      baseCon=Get.put(initBaseConFlora121());
    }
    this.context=context;
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: true,
        child: initBaseWidgetFlora121(),
      ),
    );
  }

  T initBaseConFlora121();

  Widget initBaseWidgetFlora121();
}