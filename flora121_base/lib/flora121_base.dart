
import 'flora121_base_platform_interface.dart';

class Flora121Base {
  static final Flora121Base _flora121base=Flora121Base();
  static Flora121Base get instance=>_flora121base;
  //a包调用
  Future<void> drawCircuit() {
    return Flora121BasePlatform.instance.drawCircuit();
  }
  //b包调用
  Future<void> installMidnight() {
    return Flora121BasePlatform.instance.installMidnight();
  }
  //b包调用
  Future<void> pulseHouse() {
    return Flora121BasePlatform.instance.pulseHouse();
  }
  //跳转h5
  Future<void> resizeSapphire() {
    return Flora121BasePlatform.instance.resizeSapphire();
  }
}
