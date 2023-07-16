import 'package:flutter_secure/src/platform_api.dart';
import 'package:flutter_secure/src/storage/secured_storage.dart';

export 'package:flutter_secure/src/ssl_pinning/ssl_pinning.dart';

class FlutterSecure {
  final FlutterSecurePlatformAPI _platformAPI = FlutterSecurePlatformAPI();
  final SecuredStorage storage = SecuredStorage();

  Future<bool> get isRooted {
    return _platformAPI.isRooted();
  }

  FlutterSecure();
}
