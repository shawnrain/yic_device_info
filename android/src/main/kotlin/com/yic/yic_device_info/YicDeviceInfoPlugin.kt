package com.yic.yic_device_info

import android.content.Context
import android.content.pm.PackageManager
import android.os.Build
import android.provider.Settings
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.util.UUID

/** YicDeviceInfoPlugin */
class YicDeviceInfoPlugin :
    FlutterPlugin,
    MethodCallHandler {
    private var applicationContext: Context? = null

    // The MethodChannel that will the communication between Flutter and native Android
    //
    // This local reference serves to register the plugin with the Flutter Engine and unregister it
    // when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        applicationContext = flutterPluginBinding.applicationContext
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "yic_device_info")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(
        call: MethodCall,
        result: Result
    ) {
        when (call.method) {
            "getPlatformVersion" -> result.success("Android ${android.os.Build.VERSION.RELEASE}")
            "deviceModel" -> result.success(Build.MODEL)
            "version" -> handleWithContext(result) { context -> version(context) }
            "buildNumber" -> handleWithContext(result) { context -> buildNumber(context) }
            "bundleIdentifier" -> handleWithContext(result) { context -> context.packageName }
            "appName" -> handleWithContext(result) { context -> appName(context) }
            "identifier" -> handleWithContext(result) { context -> identifier(context) }
            "androidId" -> handleWithContext(result) { context -> androidId(context) }
            "channelName" -> handleWithContext(result) { context -> channelName(context) }
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        applicationContext = null
    }

    private fun handleWithContext(
        result: Result,
        value: (Context) -> String
    ) {
        val context = applicationContext
        if (context == null) {
            result.error("missing_context", "Application context is unavailable.", null)
        } else {
            result.success(value(context))
        }
    }

    private fun identifier(context: Context): String {
        val preferences = context.getSharedPreferences("yic_device_info", Context.MODE_PRIVATE)
        val key = "yic_device_info_uuid"
        val cached = preferences.getString(key, null)
        if (cached != null) {
            return cached
        }

        val unique = UUID.randomUUID().toString()
        preferences.edit().putString(key, unique).apply()
        return unique
    }

    private fun androidId(context: Context): String {
        return Settings.Secure.getString(context.contentResolver, Settings.Secure.ANDROID_ID) ?: ""
    }

    @Suppress("DEPRECATION")
    private fun channelName(context: Context): String {
        val applicationInfo =
            context.packageManager.getApplicationInfo(context.packageName, PackageManager.GET_META_DATA)
        val metaData = applicationInfo.metaData ?: return ""
        val keys =
            listOf(
                "YIC_CHANNEL",
                "CHANNEL_NAME",
                "CHANNEL",
                "channelName",
                "channel",
                "UMENG_CHANNEL",
                "APP_CHANNEL"
            )

        for (key in keys) {
            val value = metaData.get(key)?.toString()?.trim()
            if (!value.isNullOrEmpty() && !value.startsWith("$(")) {
                return value
            }
        }

        return ""
    }

    private fun version(context: Context): String {
        val packageInfo = context.packageManager.getPackageInfo(context.packageName, 0)
        return packageInfo.versionName ?: ""
    }

    private fun buildNumber(context: Context): String {
        val packageInfo = context.packageManager.getPackageInfo(context.packageName, 0)
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
            packageInfo.longVersionCode.toString()
        } else {
            @Suppress("DEPRECATION")
            packageInfo.versionCode.toString()
        }
    }

    private fun appName(context: Context): String {
        val applicationInfo = context.applicationInfo
        return context.packageManager.getApplicationLabel(applicationInfo).toString()
    }
}
