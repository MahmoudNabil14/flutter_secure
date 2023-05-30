import 'package:flutter_secure/flutter_secure.dart';
import 'package:flutter_secure/flutter_secure_method_channel.dart';
import 'package:flutter_secure/flutter_secure_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterSecurePlatform
    with MockPlatformInterfaceMixin
    implements FlutterSecurePlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterSecurePlatform initialPlatform = FlutterSecurePlatform.instance;

  test('$MethodChannelFlutterSecure is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterSecure>());
  });

  test('getPlatformVersion', () async {
    FlutterSecure flutterSecurePlugin = FlutterSecure();
    MockFlutterSecurePlatform fakePlatform = MockFlutterSecurePlatform();
    FlutterSecurePlatform.instance = fakePlatform;

    expect(await flutterSecurePlugin.getPlatformVersion(), '42');
  });
}
