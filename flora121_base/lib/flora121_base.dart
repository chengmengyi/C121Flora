
import 'flora121_base_platform_interface.dart';

class Flora121Base {
  static final Flora121Base _flora121base=Flora121Base();
  static Flora121Base get instance=>_flora121base;

  Future<void> flora() {
    return Flora121BasePlatform.instance.flora();
  }
}
