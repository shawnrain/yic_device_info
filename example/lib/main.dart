import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:yic_device_info/yic_device_info.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String _identifier = 'Unknown';
  String _androidId = 'Unknown';
  String _channelName = 'Unknown';
  String _deviceModel = 'Unknown';

  String _version = "Unknown";
  String _build = "Unknown";
  String _bundIdentifier = "Unknown";
  final _yicDeviceInfoPlugin = YicDeviceInfo();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Plugin example app')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Running on: $_platformVersion'),
                const SizedBox(height: 16),
                Text('设备标识: $_identifier'),
                const SizedBox(height: 8),
                Text('Android ID: $_androidId'),
                const SizedBox(height: 8),
                Text('渠道名: $_channelName'),
                const SizedBox(height: 8),
                Text('设备型号: $_deviceModel'),
                const SizedBox(height: 8),
                Text('Version: $_version'),
                const SizedBox(height: 8),
                Text('Build: $_build'),
                const SizedBox(height: 8),
                Text('bundIdentifier: $_bundIdentifier'),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: getIdentifier,
                  child: const Text('获取设备标识'),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: getAndroidId,
                  child: const Text('获取Android ID'),
                ),
                ElevatedButton(
                  onPressed: getChannelName,
                  child: const Text('获取渠道名'),
                ),
                ElevatedButton(
                  onPressed: getDeviceModel,
                  child: const Text('获取设备型号'),
                ),
                ElevatedButton(
                  onPressed: getVersion,
                  child: const Text('获取版本号'),
                ),
                ElevatedButton(
                  onPressed: getBuild,
                  child: const Text('获取Build'),
                ),
                ElevatedButton(
                  onPressed: getBundleIdentifier,
                  child: const Text('获取BundleIdentifier'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await _yicDeviceInfoPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  /// 设备的标识
  Future<void> getIdentifier() async {
    String identifier;
    try {
      identifier =
          await _yicDeviceInfoPlugin.identifier() ?? 'Unknown identifier';
    } on PlatformException {
      identifier = 'Failed to get identifier.';
    }

    if (!mounted) return;

    setState(() {
      _identifier = identifier;
    });
  }

  /// Android ID
  Future<void> getAndroidId() async {
    String androidId;
    try {
      androidId = await _yicDeviceInfoPlugin.androidId() ?? 'Unknown androidId';
    } on PlatformException {
      androidId = 'Failed to get androidId.';
    }

    if (!mounted) return;

    setState(() {
      _androidId = androidId;
    });
  }

  /// 渠道名
  Future<void> getChannelName() async {
    String channelName;
    try {
      channelName =
          await _yicDeviceInfoPlugin.channelName() ?? 'Unknown channelName';
    } on PlatformException {
      channelName = 'Failed to get channelName.';
    }

    if (!mounted) return;

    setState(() {
      _channelName = channelName;
    });
  }

  /// 机型 iPhone 15,3
  Future<void> getDeviceModel() async {
    String deviceModel;
    try {
      deviceModel =
          await _yicDeviceInfoPlugin.deviceModel() ?? 'Unknown device model';
    } on PlatformException {
      deviceModel = 'Failed to get device model.';
    }

    if (!mounted) return;

    setState(() {
      _deviceModel = deviceModel;
    });
  }

  /// 版本 1.0.0
  Future<void> getVersion() async {
    String version;
    try {
      version = await _yicDeviceInfoPlugin.version() ?? 'Unknown version';
    } on PlatformException {
      version = 'Failed to get version.';
    }

    if (!mounted) return;

    setState(() {
      _version = version;
    });
  }

  /// 版本号 如 3
  Future<void> getBuild() async {
    String buildNumber;
    try {
      buildNumber =
          await _yicDeviceInfoPlugin.buildNumber() ?? 'Unknown buildNumber';
    } on PlatformException {
      buildNumber = 'Failed to get buildNumber.';
    }

    if (!mounted) return;

    setState(() {
      _build = buildNumber;
    });
  }

  /// bundleIdentifier 应用的包名
  Future<void> getBundleIdentifier() async {
    String bundleIdentifier;
    try {
      bundleIdentifier =
          await _yicDeviceInfoPlugin.bundleIdentifier() ??
          'Unknown bundleIdentifier';
    } on PlatformException {
      bundleIdentifier = 'Failed to get bundleIdentifier.';
    }

    if (!mounted) return;

    setState(() {
      _bundIdentifier = bundleIdentifier;
    });
  }
}
