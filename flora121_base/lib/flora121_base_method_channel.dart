import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flora121_base_platform_interface.dart';

/// An implementation of [Flora121BasePlatform] that uses method channels.
class MethodChannelFlora121Base extends Flora121BasePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flora121_base');

  @override
  Future<void> drawCircuit() async {
    await methodChannel.invokeMethod<String>('drawCircuit');
  }
  @override
  Future<void> installMidnight() async {
    await methodChannel.invokeMethod<String>('installMidnight');
  }
  @override
  Future<void> pulseHouse() async {
    await methodChannel.invokeMethod<String>('pulseHouse');
  }
  @override
  Future<void> resizeSapphire() async {
    await methodChannel.invokeMethod<String>('resizeSapphire');
  }
}
