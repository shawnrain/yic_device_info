import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'yic_device_info_method_channel.dart';

abstract class YicDeviceInfoPlatform extends PlatformInterface {
  /// Constructs a YicDeviceInfoPlatform.
  YicDeviceInfoPlatform() : super(token: _token);

  static final Object _token = Object();

  static YicDeviceInfoPlatform _instance = MethodChannelYicDeviceInfo();

  /// The default instance of [YicDeviceInfoPlatform] to use.
  ///
  /// Defaults to [MethodChannelYicDeviceInfo].
  static YicDeviceInfoPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [YicDeviceInfoPlatform] when
  /// they register themselves.
  static set instance(YicDeviceInfoPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> identifier() {
    throw UnimplementedError('identifier() has not been implemented.');
  }

  Future<String?> androidId() {
    throw UnimplementedError('androidId() has not been implemented.');
  }

  Future<String?> channelName() {
    throw UnimplementedError('channelName() has not been implemented.');
  }

  Future<String?> deviceModel() {
    throw UnimplementedError('deviceModel() has not been implemented.');
  }

  Future<String?> version() {
    throw UnimplementedError('version() has not been implemented.');
  }

  Future<String?> buildNumber() {
    throw UnimplementedError('buildNumber() has not been implemented.');
  }

  Future<String?> bundleIdentifier() {
    throw UnimplementedError('bundleIdentifier() has not been implemented.');
  }

  Future<String?> appName() {
    throw UnimplementedError('appName() has not been implemented.');
  }
}
