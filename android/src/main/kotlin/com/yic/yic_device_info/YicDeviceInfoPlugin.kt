package com.yic.yic_device_info

import android.content.Context
import android.os.Build
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
            "identifier" -> {
                val context = applicationContext
                if (context == null) {
                    result.error("missing_context", "Application context is unavailable.", null)
                } else {
                    result.success(identifier(context))
                }
            }
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        applicationContext = null
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
}
