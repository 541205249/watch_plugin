import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:watch_plugin/watch_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
    WatchPlugin();
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion =
          await WatchPlugin.platformVersion ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          // child: Text('Running on: $_platformVersion\n'),
          child: Column(
            children: <Widget>[
              Text(_platformVersion),
              RaisedButton(
                child: const Text('获取hello', style: TextStyle(fontSize: 28.0, color: Colors.red),),
                onPressed: () async {
                  String nativeResult = await WatchPlugin.sayHello("获取hello");
                  print(nativeResult);
                },)
            ],
          ),
        ),
      ),
    );
  }
}
