import 'package:flora121_base/flora121_base/flora121_base_con.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_package_b/flora_enum/flora121_cash_type.dart';

class Flora121TransferFundsDialogCon extends Flora121BaseCon{
  bool showFail=false;
  late Function() dismissCallback;
  Flora121TransferFundsDialogCon(this.dismissCallback);

  @override
  void onInit() {
    super.onInit();
    _delay();
  }

  _delay()async{
    await Future.delayed(Duration(milliseconds: 1500));
    showFail=true;
    update(["bottom_text","icon"]);
    await Future.delayed(Duration(milliseconds: 1500));
    Flora121RoutersHep.back();
    dismissCallback.call();
  }
}