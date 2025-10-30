package com.example.flora121_package_b

import androidx.annotation.NonNull
import android.content.Context
import android.content.Intent
import android.net.Uri
import androidx.core.net.toUri
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import android.util.Log

/** Flora121Package_bPlugin */
class Flora121Package_bPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var mApplicationContext: Context

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    mApplicationContext=flutterPluginBinding.applicationContext
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flora121_package_b")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "intentAc") {
      call.arguments?.let{
        val map = it as Map<String, Any>
        val url = (map["url"] as? String) ?: ""
        parseIntent(url)
      }
    } else {
      result.notImplemented()
    }
  }

  private fun parseIntent(url: String) {
    try {
      var intent: Intent? = null

      intent = if (url.startsWith("intent")) {
        Intent.parseUri(url, Intent.URI_INTENT_SCHEME)
      } else {
        Intent(Intent.ACTION_VIEW, url.toUri())
      }

      if(intent != null){
        intent.component=null
        intent.flags =Intent.FLAG_ACTIVITY_NEW_TASK
      }

      mApplicationContext.startActivity(intent)
    } catch (e: Exception) {

    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
