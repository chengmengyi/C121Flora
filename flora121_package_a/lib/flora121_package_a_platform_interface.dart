import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flora121_package_a_method_channel.dart';

abstract class Flora121Package_aPlatform extends PlatformInterface {
  /// Constructs a Flora121Package_aPlatform.
  Flora121Package_aPlatform() : super(token: _token);

  static final Object _token = Object();

  static Flora121Package_aPlatform _instance = MethodChannelFlora121Package_a();

  /// The default instance of [Flora121Package_aPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlora121Package_a].
  static Flora121Package_aPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [Flora121Package_aPlatform] when
  /// they register themselves.
  static set instance(Flora121Package_aPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
