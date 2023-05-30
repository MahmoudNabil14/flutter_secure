import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_secure_platform_interface.dart';

/// An implementation of [FlutterSecurePlatform] that uses method channels.
class MethodChannelFlutterSecure extends FlutterSecurePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_secure');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
