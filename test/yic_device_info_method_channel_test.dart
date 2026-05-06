import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yic_device_info/yic_device_info_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelYicDeviceInfo platform = MethodChannelYicDeviceInfo();
  const MethodChannel channel = MethodChannel('yic_device_info');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
          return '42';
        });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });

  test('identifier', () async {
    expect(await platform.identifier(), '42');
  });

  test('deviceModel', () async {
    expect(await platform.deviceModel(), '42');
  });
}
