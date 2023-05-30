package com.dreamorbit.flutter_secure

import android.app.Activity
import android.content.Context
import androidx.annotation.NonNull
import com.scottyab.rootbeer.RootBeer
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding

/** FlutterSecurePlugin */
class FlutterSecurePlugin : FlutterPlugin, FlutterSecurePlatformAPI, ActivityAware {

    private lateinit var context: Context
    private lateinit var activity: Activity

    override fun onAttachedToEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        FlutterSecurePlatformAPI.setUp(binding.binaryMessenger, this)
        context = binding.applicationContext
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        FlutterSecurePlatformAPI.setUp(binding.binaryMessenger, null)
    }

    override fun onDetachedFromActivity() {

    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {

    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity;
    }

    override fun onDetachedFromActivityForConfigChanges() {

    }

    /*
    *
    * API Implementation
    *
    * */

    override fun isRooted(): Boolean {
        return RootBeer(context).isRooted
    }
}
