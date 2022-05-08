
import 'dart:async';

import 'package:flutter/services.dart';

class WatchPlugin {
  static const MethodChannel _channelMedthod = MethodChannel('watch_plugin_method');
  static const EventChannel _channelEvent = EventChannel('watch_plugin_event');
  // 状态监听
  static StreamController<String> statusController = StreamController.broadcast();


  static Future<String?> get platformVersion async {
    final String? version = await _channelMedthod.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String> sayHello(String msg) async {
    // final String str = await _channelMedthod.invokeMethod('sayHello', <String, dynamic>{'msg':msg});
    // return str;
    Map<dynamic, dynamic> map = await _channelMedthod.invokeMethod("sayHello",
        <String, dynamic>{'msg':msg, 'msg2':'msg2', 'msg3':'msg3'});
    String value1 = map['key1'];
    String value2 = map['key2'];
    return value1 + ',' + value2;
  }

  WatchPlugin() {
    initEvent();
  }

  void initEvent() {
    StreamSubscription<dynamic> _eventSubscription = _channelEvent.receiveBroadcastStream()
        .listen(eventListener, onError: errorListener);
  }

  void eventListener(dynamic event) {
    Map<dynamic, dynamic> map = event;
    switch(map['event']) {
      case 'event1':
        print("event1,value:" + map['value']);
        break;
      case 'event2':
        print("event2,value:" + map['value']);
        break;
    }
  }

  void errorListener(Object error) {
    print(error);
    // final PlatformException exception = error;
    // throw exception;
  }

}
