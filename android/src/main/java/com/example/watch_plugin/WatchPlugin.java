package com.example.watch_plugin;

import android.app.Activity;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** WatchPlugin */
public class WatchPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware, EventChannel.StreamHandler {
  private MethodChannel mChannelMethod;

  private EventChannel mEventChannel;
  //事件派发对象
  private EventChannel.EventSink mEventSink;
  private Activity mActivity;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
    mChannelMethod = new MethodChannel(binding.getBinaryMessenger(), "watch_plugin_method");
    mChannelMethod.setMethodCallHandler(this);

    mEventChannel = new EventChannel(binding.getBinaryMessenger(), "watch_plugin_event");
    mEventChannel.setStreamHandler(this);
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    mChannelMethod.setMethodCallHandler(null);
    mEventChannel.setStreamHandler(null);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    switch (call.method) {
      case "getPlatformVersion":
        result.success("Android " + android.os.Build.VERSION.RELEASE);
        break;
      case "sayHello":
        sayHello(call, result);
        break;
      default:
        result.notImplemented();
        break;
    }
  }

  private void sayHello(@NonNull MethodCall call, @NonNull Result result) {
    String msg = call.argument("msg");
    System.out.println("msg=" + msg);
    System.out.println("msg2=" + call.argument("msg2"));
    System.out.println("msg3=" + call.argument("msg3"));

    //返回字符串
//        result.success("来了来了!!!!!!!");
    //返回键值对
    ConstraintsMap params = new ConstraintsMap();
    params.putString("key1", "value1");
    params.putString("key2", "value2");
    result.success(params.toMap());

    sendEvent();
  }

  private void sendEvent() {
    if (mEventSink != null) {
      ConstraintsMap paramsEvent = new ConstraintsMap();
      paramsEvent.putString("event", "event1");
      paramsEvent.putString("value", "value1");
      mEventSink.success(paramsEvent.toMap());

      paramsEvent.putString("event", "event2");
      paramsEvent.putString("value", "value2");
      mEventSink.success(paramsEvent.toMap());
    }
  }






  @Override
  public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
    mActivity = binding.getActivity();
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {

  }

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
  }

  @Override
  public void onDetachedFromActivity() {
    mActivity = null;
  }

  @Override
  public void onListen(Object arguments, EventChannel.EventSink events) {
    mEventSink = events;
  }

  @Override
  public void onCancel(Object arguments) {
    mEventSink = null;
  }
}
