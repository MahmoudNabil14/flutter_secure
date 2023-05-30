import 'flutter_secure_platform_interface.dart';

class FlutterSecure {
  Future<String?> getPlatformVersion() {
    return FlutterSecurePlatform.instance.getPlatformVersion();
  }
}
