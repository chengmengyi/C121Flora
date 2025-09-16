import 'package:flora121_base/flora121_base/flora121_base_con.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_package_b/flora_enum/flora121_cash_type.dart';

class Flora121InputEmailDialogCon extends Flora121BaseCon{

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
}