
import 'flora121_package_a_platform_interface.dart';

class Flora121Package_a {
  Future<String?> getPlatformVersion() {
    return Flora121Package_aPlatform.instance.getPlatformVersion();
  }
}
