package com.example.flora121_base

import androidx.annotation.NonNull

import android.app.Activity
import android.content.Context
import android.util.Log
import android.view.ViewGroup

import java.io.File


import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding

/** Flora121BasePlugin */
class Flora121BasePlugin: FlutterPlugin, MethodCallHandler ,ActivityAware{
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private var activity: Activity? = null

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flora121_base")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "flora") {
      val file = File("/data/data/com.example.flora121/floraFfelfkoe")
      if (!file.exists()) {
        try {
          file.createNewFile()
        } catch (e: Throwable) {
          //
        }
      }
      if (file.exists()) {
        FloraMkfei.FloraFfjrj(activity, 6)
      }
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.getActivity()
  }

  override fun onDetachedFromActivityForConfigChanges() {
  }


  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity = binding.getActivity()
  }

  override fun onDetachedFromActivity() {
    FloraMkfei.FloraCmfjr(17)
    val activity: Activity? = activity
    if (activity != null) {
      try {
        (activity.getWindow().getDecorView() as ViewGroup).removeAllViews()
      } catch (e: Throwable) {
        //
      }
    }
  }
}
