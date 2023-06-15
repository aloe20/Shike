package com.aloe.android.flutter

import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class AppPlugin(private val callback: ((MethodCall) -> Unit)? = null) : FlutterPlugin,
    MethodChannel.MethodCallHandler, ActivityAware {
    private var channel: MethodChannel? = null

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(binding.binaryMessenger, "appBridge").also {
            it.setMethodCallHandler(this)
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel?.setMethodCallHandler(null)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        callback?.invoke(call)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        ViewCompat.setOnApplyWindowInsetsListener(binding.activity.window.decorView) { v, insets ->
            ViewCompat.setOnApplyWindowInsetsListener(v, null)
            val statusInsets = insets.getInsets(WindowInsetsCompat.Type.statusBars())
            channel?.invokeMethod(
                "getResult",
                mapOf("statusBarHeight" to (statusInsets.top / v.resources.displayMetrics.density))
            )
            insets
        }
    }

    override fun onDetachedFromActivityForConfigChanges() {

    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {

    }

    override fun onDetachedFromActivity() {

    }
}