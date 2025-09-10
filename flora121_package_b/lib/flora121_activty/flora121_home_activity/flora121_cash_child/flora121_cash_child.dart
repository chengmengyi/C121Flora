import 'package:flora121_base/flora121_base/flora121_base_child.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_b/flora121_activty/flora121_home_activity/flora121_cash_child/flora121_cash_con.dart';
import 'package:flutter/material.dart';

class Flora121CashChild extends Flora121BaseChild<Flora121CashCon>{
  @override
  Flora121CashCon initBaseConFlora121() => Flora121CashCon();

  @override
  Widget initBaseWidgetFlora121() => Center(
    child: Flora121TextView(text: "骰子", color: "#000000", size: 20.sp),
  );
}