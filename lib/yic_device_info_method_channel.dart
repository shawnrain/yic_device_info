import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'yic_device_info_platform_interface.dart';

/// An implementation of [YicDeviceInfoPlatform] that uses method channels.
class MethodChannelYicDeviceInfo extends YicDeviceInfoPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('yic_device_info');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>(
      'getPlatformVersion',
    );
    return version;
  }

  @override
  Future<String?> identifier() async {
    final identifier = await methodChannel.invokeMethod<String>('identifier');
    return identifier;
  }

  @override
  Future<String?> deviceModel() async {
    final deviceModel = await methodChannel.invokeMethod<String>('deviceModel');
    return deviceModel;
  }
}
