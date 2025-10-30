import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flora121_package_b_platform_interface.dart';

/// An implementation of [Flora121Package_bPlatform] that uses method channels.
class MethodChannelFlora121Package_b extends Flora121Package_bPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flora121_package_b');

  @override
  Future<void> intentAc(String url) async {
    await methodChannel.invokeMethod<String>('intentAc',{"url":url});
  }
}
