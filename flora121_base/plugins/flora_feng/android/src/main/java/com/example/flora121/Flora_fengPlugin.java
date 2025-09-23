package com.example.flora121;

import android.content.Context;

import androidx.annotation.NonNull;

import java.util.Map;

import cn.shuzilm.core.Listener;
import cn.shuzilm.core.Main;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

public class Flora_fengPlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private Context context;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "flora_feng");
    channel.setMethodCallHandler(this);
    context = flutterPluginBinding.getApplicationContext();
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    final String method = call.method;
    switch (method) {
      case "roFlora121ot":
        result.success(BoFlora121RiskUtils.isFlora121AbnormalEnv() || BoFlora121RiskUtils.isFlora121Xposed());
        break;
      case "vpFlora121n":
        result.success(BoFlora121RiskUtils.isFlora121Vpn());
        break;
      case "siFlora121m":
        result.success(BoFlora121RiskUtils.isFlora121Sim(context));
        break;
      case "siFlora121mulator":
        result.success(BoFlora121RiskUtils.isFlora121Emulator() || BoFlora121RiskUtils.isFlora121Emulator2());
        break;
      case "stFlora121ore":
        result.success("com.android.vending".contentEquals(BoFlora121RiskUtils.getFlora121Installer(context)));
        break;
      case "deFlora121veloper":
        result.success(BoFlora121RiskUtils.isFlora121DevModel(context) || BoFlora121RiskUtils.isFlora121Debug(context));
        break;
      case "inFlora121staller":
        result.success(BoFlora121RiskUtils.getFlora121Installer(context));
        break;
      case "inFlora121itNumberUnit":
        Main.init(context, (String)call.arguments, false);
        result.success(true);
        break;
      case "geFlora121tNumberUnitID":
        final Map<String, String> arguments = (Map<String, String>)call.arguments;
        Main.getQueryID(context, arguments.get("channel"), arguments.get("message"), false, new Listener() {
          @Override
          public void handler(String s) {
            result.success(s);
          }
        });
        break;
      default:
        result.notImplemented();
        break;
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
