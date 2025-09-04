import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flora121_package_a_platform_interface.dart';

/// An implementation of [Flora121Package_aPlatform] that uses method channels.
class MethodChannelFlora121Package_a extends Flora121Package_aPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flora121_package_a');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
