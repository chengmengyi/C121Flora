
import 'flora121_base_platform_interface.dart';

class Flora121Base {
  Future<String?> getPlatformVersion() {
    return Flora121BasePlatform.instance.getPlatformVersion();
  }
}
