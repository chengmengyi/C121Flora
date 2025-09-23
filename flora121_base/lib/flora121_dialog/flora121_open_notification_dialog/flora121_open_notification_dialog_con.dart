import 'package:app_settings/app_settings.dart';
import 'package:flora121_base/flora121_base/flora121_base_con.dart';
import 'package:flora121_base/flora121_hep/flora121_applife_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_point_enum.dart';
import 'package:flora121_base/flora121_hep/flora121_ttt/flora121_ttt.dart';

class Flora121OpenNotificationDialogCon extends Flora121BaseCon{
  @override
  void onInit() {
    super.onInit();
    Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.noti_confirm_pop);
  }

  clickOk(){
    Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.noti_confirm_pop_c);
    Flora121RoutersHep.back();
    Flora121ApplifeHep.instance.toOpenNotification=true;
    AppSettings.openAppSettings(type: AppSettingsType.notification);
  }

  clickClose(){
    Flora121Ttt.instance.uploadPointEvent(pointEnum: Flora121PointEnum.noti_confirm_pop_close);
    Flora121RoutersHep.back();
  }
}