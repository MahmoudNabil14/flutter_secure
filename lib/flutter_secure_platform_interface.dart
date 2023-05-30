import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_secure_method_channel.dart';

abstract class FlutterSecurePlatform extends PlatformInterface {
  /// Constructs a FlutterSecurePlatform.
  FlutterSecurePlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterSecurePlatform _instance = MethodChannelFlutterSecure();

  /// The default instance of [FlutterSecurePlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterSecure].
  static FlutterSecurePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterSecurePlatform] when
  /// they register themselves.
  static set instance(FlutterSecurePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
