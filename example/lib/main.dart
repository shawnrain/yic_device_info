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
  String _deviceModel = 'Unknown';
  final _yicDeviceInfoPlugin = YicDeviceInfo();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

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
                Text('设备型号: $_deviceModel'),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: getIdentifier,
                  child: const Text('获取设备标识'),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: getDeviceModel,
                  child: const Text('获取设备型号'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
