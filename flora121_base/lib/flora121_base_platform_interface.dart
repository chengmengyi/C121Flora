import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flora121_base_method_channel.dart';

abstract class Flora121BasePlatform extends PlatformInterface {
  /// Constructs a Flora121BasePlatform.
  Flora121BasePlatform() : super(token: _token);

  static final Object _token = Object();

  static Flora121BasePlatform _instance = MethodChannelFlora121Base();

  /// The default instance of [Flora121BasePlatform] to use.
  ///
  /// Defaults to [MethodChannelFlora121Base].
  static Flora121BasePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [Flora121BasePlatform] when
  /// they register themselves.
  static set instance(Flora121BasePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> flora() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
