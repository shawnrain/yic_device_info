# yic_device_info

A new Flutter plugin project.

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/to/develop-plugins),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Android

```dart
final deviceInfo = YicDeviceInfo();

final androidId = await deviceInfo.androidId();
final channelName = await deviceInfo.channelName();
```

Configure the channel name in `AndroidManifest.xml` with any one of these
metadata keys: `YIC_CHANNEL`, `CHANNEL_NAME`, `CHANNEL`, `channelName`,
`channel`, `UMENG_CHANNEL`, or `APP_CHANNEL`.

```xml
<application>
    <meta-data
        android:name="YIC_CHANNEL"
        android:value="official" />
</application>
```
