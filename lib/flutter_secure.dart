import 'package:flutter_secure/src/platform_api.dart';

class FlutterSecure {
  final FlutterSecurePlatformAPI _platformAPI = FlutterSecurePlatformAPI();

  Future<bool> get isRooted {
    return _platformAPI.isRooted();
  }

  FlutterSecure();
}
