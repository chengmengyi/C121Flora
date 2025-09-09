
import 'flora121_package_b_platform_interface.dart';

class Flora121Package_b {
  Future<String?> getPlatformVersion() {
    return Flora121Package_bPlatform.instance.getPlatformVersion();
  }
}
