package com.dreamorbit.flutter_secure

import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin

/** FlutterSecurePlugin */
class FlutterSecurePlugin : FlutterPlugin, FlutterSecurePlatformAPI {

    override fun onAttachedToEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        FlutterSecurePlatformAPI.setUp(binding.binaryMessenger, this)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        FlutterSecurePlatformAPI.setUp(binding.binaryMessenger, null)
    }
}
