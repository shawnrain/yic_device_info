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
    case "androidId":
      result("")
    case "channelName":
      result(Self.channelName())
    case "deviceModel":
      result(Self.deviceModel())
    case "version":
      result(Self.versionString())
    case "buildNumber":
      result(Self.buildNumber())
    case "bundleIdentifier":
      result(Self.bundleIdentifier())
    case "appName":
      result(Self.appName())
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

  static func versionString() -> String {
    bundleString(for: "CFBundleShortVersionString")
  }

  static func buildNumber() -> String {
    bundleString(for: "CFBundleVersion")
  }

  private static func bundleString(for key: String) -> String {
    guard let value = Bundle.main.object(forInfoDictionaryKey: key) else {
      return ""
    }

    let stringValue = String(describing: value).trimmingCharacters(in: .whitespacesAndNewlines)
    guard !stringValue.isEmpty, !stringValue.hasPrefix("$(") else {
      return ""
    }

    return stringValue
  }

  static func bundleIdentifier() -> String {
    Bundle.main.bundleIdentifier ?? ""
  }

  static func appName() -> String {
    let infoDictionary = Bundle.main.infoDictionary
    return infoDictionary?["CFBundleDisplayName"] as? String
      ?? infoDictionary?["CFBundleName"] as? String
      ?? ""
  }

  static func channelName() -> String {
    let keys = ["YIC_CHANNEL", "CHANNEL_NAME", "CHANNEL", "channelName", "channel", "UMENG_CHANNEL", "APP_CHANNEL"]
    for key in keys {
      let value = bundleString(for: key)
      if !value.isEmpty {
        return value
      }
    }

    return ""
  }
}
