import Flutter
import KeychainAccess
import Foundation
import UIKit

public class YicDeviceInfoPlugin: NSObject, FlutterPlugin {
  private enum Key: String {
    case uuid = "yic_device_info_uuid"
  }

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "yic_device_info", binaryMessenger: registrar.messenger())
    let instance = YicDeviceInfoPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    case "identifier":
      result(Self.identifier())
    case "deviceModel":
      result(Self.deviceModel())
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  /// 设备唯一ID处理
  /// - Returns: 设备唯一ID
  static func identifier() -> String {
    let keychain = Keychain()
    if let uniqueDevice = try? keychain.getString(Key.uuid.rawValue) {
      return uniqueDevice
    }

    let unique = UUID().uuidString
    try? keychain.set(unique, key: Key.uuid.rawValue)
    return unique
  }


  /// 获取到设备型号 iPhone18,3
  static func deviceModel() -> String {
    var systemInfo = utsname()
    uname(&systemInfo)
    let mirror = Mirror(reflecting: systemInfo.machine)  
     return mirror.children.reduce("") { identifier, element in
      guard let value = element.value as? Int8, value != 0 else {
        return identifier
      }
      return identifier + String(UnicodeScalar(UInt8(value)))
    }
  }
}
