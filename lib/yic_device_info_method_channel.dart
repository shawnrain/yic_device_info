import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'yic_device_info_platform_interface.dart';

/// An implementation of [YicDeviceInfoPlatform] that uses method channels.
class MethodChannelYicDeviceInfo extends YicDeviceInfoPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('yic_device_info');

  Future<String?> _invokeStringMethod(String method) async {
    final value = await methodChannel.invokeMethod<Object?>(method);
    return value?.toString();
  }

  @override
  Future<String?> getPlatformVersion() {
    return _invokeStringMethod('getPlatformVersion');
  }

  @override
  Future<String?> identifier() {
    return _invokeStringMethod('identifier');
  }

  @override
  Future<String?> androidId() {
    return _invokeStringMethod('androidId');
  }

  @override
  Future<String?> channelName() {
    return _invokeStringMethod('channelName');
  }

  @override
  Future<String?> deviceModel() {
    return _invokeStringMethod('deviceModel');
  }

  @override
  Future<String?> version() {
    return _invokeStringMethod('version');
  }

  @override
  Future<String?> buildNumber() {
    return _invokeStringMethod('buildNumber');
  }

  @override
  Future<String?> bundleIdentifier() {
    return _invokeStringMethod('bundleIdentifier');
  }

  @override
  Future<String?> appName() {
    return _invokeStringMethod('appName');
  }
}
