import 'package:flutter_test/flutter_test.dart';
import 'package:yic_device_info/yic_device_info.dart';
import 'package:yic_device_info/yic_device_info_platform_interface.dart';
import 'package:yic_device_info/yic_device_info_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockYicDeviceInfoPlatform
    with MockPlatformInterfaceMixin
    implements YicDeviceInfoPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<String?> identifier() => Future.value('uuid-42');

  @override
  Future<String?> deviceModel() => Future.value('model-42');
}

void main() {
  final YicDeviceInfoPlatform initialPlatform = YicDeviceInfoPlatform.instance;

  test('$MethodChannelYicDeviceInfo is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelYicDeviceInfo>());
  });

  test('getPlatformVersion', () async {
    YicDeviceInfo yicDeviceInfoPlugin = YicDeviceInfo();
    MockYicDeviceInfoPlatform fakePlatform = MockYicDeviceInfoPlatform();
    YicDeviceInfoPlatform.instance = fakePlatform;

    expect(await yicDeviceInfoPlugin.getPlatformVersion(), '42');
  });

  test('identifier', () async {
    YicDeviceInfo yicDeviceInfoPlugin = YicDeviceInfo();
    MockYicDeviceInfoPlatform fakePlatform = MockYicDeviceInfoPlatform();
    YicDeviceInfoPlatform.instance = fakePlatform;

    expect(await yicDeviceInfoPlugin.identifier(), 'uuid-42');
  });

  test('deviceModel', () async {
    YicDeviceInfo yicDeviceInfoPlugin = YicDeviceInfo();
    MockYicDeviceInfoPlatform fakePlatform = MockYicDeviceInfoPlatform();
    YicDeviceInfoPlatform.instance = fakePlatform;

    expect(await yicDeviceInfoPlugin.deviceModel(), 'model-42');
  });
}
