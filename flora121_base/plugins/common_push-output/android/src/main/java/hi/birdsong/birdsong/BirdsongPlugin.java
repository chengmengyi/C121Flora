package hi.birdsong.birdsong;

import android.Manifest;
import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Build;

import androidx.annotation.NonNull;
import androidx.core.app.ActivityCompat;
import androidx.core.app.NotificationManagerCompat;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import hi.birdsong.birdsong.api.BirdsongApi;
import hi.birdsong.birdsong.api.FlutterEventSinkProxy;
import hi.birdsong.birdsong.api.IBirdsongApi;
import hi.birdsong.birdsong.api.ResultListener;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.PluginRegistry.NewIntentListener;
import io.flutter.plugin.common.EventChannel;

/** BirdsongPlugin */
public class BirdsongPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware,
        NewIntentListener,
        EventChannel.StreamHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private Activity activity;
  private ActivityPluginBinding activityBinding;
  private EventChannel eventChannel;
  private Intent initIntent;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "hi.birdsong.birdsong/method");
    channel.setMethodCallHandler(this);
    eventChannel = new EventChannel(flutterPluginBinding.getBinaryMessenger(), "hi.birdsong.birdsong/event");
    eventChannel.setStreamHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    final String method = call.method;
    switch (method) {
      case "initialize":
        doInitialize(call, result);
        break;
      case "repeat":
        doRepeat(call, result);
        break;
      case "subscribe":
        doSubscribe(call, result);
        break;
      case "present":
        doPresent(call, result);
        break;
      case "request":
        doRequest(call, result);
        break;
      case "has":
        result.success(NotificationManagerCompat.from(activity).areNotificationsEnabled());
        break;
      case "show":
        Map<String, Object> arguments = call.arguments();
        BirdsongApi.getInstance().show(activity, arguments);
        result.success("");
        break;
      default:
        result.notImplemented();
        break;
    }
  }

  private void doRequest(MethodCall call, Result result) {
    if (NotificationManagerCompat.from(activity).areNotificationsEnabled()) {
      result.success("");
      return;
    }
    if (Build.VERSION.SDK_INT < Build.VERSION_CODES.TIRAMISU) {
      result.success("");
      return;
    }
    Map<String, Object> arguments = call.arguments();
    BirdsongApi.getInstance().requestPermission(activity, arguments, aBoolean -> result.success(""));
  }

  private void doInitialize(MethodCall call, Result result) {
    if (activity == null) return;
    final Context context = activity.getApplicationContext();
    Map<String, Object> arguments = call.arguments();
    BirdsongApi.getInstance().initialize(context, arguments);
    result.success("");
  }

  private void doRepeat(MethodCall call, Result result) {
    final Context context = activity;
    if (context == null) return;
    Map<String, Object> arguments = call.arguments();
    BirdsongApi.getInstance().repeat(context, arguments);
    result.success("");
  }

  private void doSubscribe(MethodCall call, Result result) {
    Map<String, Object> arguments = call.arguments();
    String topic = (String) Objects.requireNonNull(arguments.get("topic"));
    BirdsongApi.getInstance().subscribe(topic, aBoolean -> result.success(aBoolean));
  }

  private void doPresent(MethodCall call, Result result) {
    final Context context = activity;
    if (context == null) return;
    Map<String, Object> arguments = call.arguments();
    BirdsongApi.getInstance().present(context, arguments);
    result.success("");
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    BirdsongApi.getInstance().onEventCancel();
    channel.setMethodCallHandler(null);
    eventChannel.setStreamHandler(null);
  }

  @Override
  public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
    this.activity = binding.getActivity();
    this.activityBinding = binding;
    binding.addOnNewIntentListener(this);
    initIntent = activity.getIntent();
    BirdsongApi.getInstance().onAttachedToActivity(activity);
  }

  @Override
  public void onDetachedFromActivity() {
    if (activityBinding != null) {
      activityBinding.removeOnNewIntentListener(this);
    }
    BirdsongApi.getInstance().onDetachedFromActivity(activity);
    this.activity = null;
    this.activityBinding = null;
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {
    onDetachedFromActivity();
  }

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
    onAttachedToActivity(binding);
  }

  @Override
  public boolean onNewIntent(@NonNull Intent intent) {
    return BirdsongApi.getInstance().onNewIntent(intent);
  }

  @Override
  public void onListen(Object o, EventChannel.EventSink eventSink) {
    BirdsongApi.getInstance().onEventListen(activity, (s, map) -> {
      Map<String, Object> transport = new HashMap<>();
      transport.put("method", s);
      transport.put("data", map);
      eventSink.success(transport);
    }, initIntent);
    initIntent = null;
  }

  @Override
  public void onCancel(Object o) {
    BirdsongApi.getInstance().onEventCancel();
  }
}
