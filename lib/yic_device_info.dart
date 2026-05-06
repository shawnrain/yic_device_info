import 'yic_device_info_platform_interface.dart';

class YicDeviceInfo {
  Future<String?> getPlatformVersion() {
    return YicDeviceInfoPlatform.instance.getPlatformVersion();
  }

  Future<String?> identifier() {
    return YicDeviceInfoPlatform.instance.identifier();
  }

  Future<String?> deviceModel() {
    return YicDeviceInfoPlatform.instance.deviceModel();
  }
}
