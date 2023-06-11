import 'package:flutter_secure/src/platform_api.dart';

export 'package:flutter_secure/src/ssl_pinning/ssl_pinning.dart';

class FlutterSecure {
  final FlutterSecurePlatformAPI _platformAPI = FlutterSecurePlatformAPI();

  Future<bool> get isRooted {
    return _platformAPI.isRooted();
  }

  FlutterSecure();
}
