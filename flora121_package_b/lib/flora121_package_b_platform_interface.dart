import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flora121_package_b_method_channel.dart';

abstract class Flora121Package_bPlatform extends PlatformInterface {
  /// Constructs a Flora121Package_bPlatform.
  Flora121Package_bPlatform() : super(token: _token);

  static final Object _token = Object();

  static Flora121Package_bPlatform _instance = MethodChannelFlora121Package_b();

  /// The default instance of [Flora121Package_bPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlora121Package_b].
  static Flora121Package_bPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [Flora121Package_bPlatform] when
  /// they register themselves.
  static set instance(Flora121Package_bPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
