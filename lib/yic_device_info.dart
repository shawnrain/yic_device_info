import 'yic_device_info_platform_interface.dart';

class YicDeviceInfo {
  Future<String?> getPlatformVersion() {
    return YicDeviceInfoPlatform.instance.getPlatformVersion();
  }

  Future<String?> identifier() {
    return YicDeviceInfoPlatform.instance.identifier();
  }

  Future<String?> androidId() {
    return YicDeviceInfoPlatform.instance.androidId();
  }

  Future<String?> channelName() {
    return YicDeviceInfoPlatform.instance.channelName();
  }

  Future<String?> deviceModel() {
    return YicDeviceInfoPlatform.instance.deviceModel();
  }

  Future<String?> version() {
    return YicDeviceInfoPlatform.instance.version();
  }

  Future<String?> buildNumber() {
    return YicDeviceInfoPlatform.instance.buildNumber();
  }

  Future<String?> bundleIdentifier() {
    return YicDeviceInfoPlatform.instance.bundleIdentifier();
  }

  Future<String?> appName() {
    return YicDeviceInfoPlatform.instance.appName();
  }
}
