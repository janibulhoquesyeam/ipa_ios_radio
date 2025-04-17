package net.appdevs.adradio

import io.flutter.embedding.android.FlutterActivity


import android.content.Intent
import android.provider.Settings
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.apintie.radio/cast"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "showOutputChooser") {

                try {
                    val intent = Intent(Settings.ACTION_CAST_SETTINGS) // Opens Cast settings
                    startActivity(intent)
                    result.success(null)
                } catch (e: Exception) {
                    result.error("UNAVAILABLE", "Could not open cast settings", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

}
