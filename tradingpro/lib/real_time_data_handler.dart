import 'package:flutter/services.dart';
import 'dart:async';

class RealTimeDataHandler {
  static const  _channel = MethodChannel('soundar/helper');
  final StreamController<String> _dataStreamController = StreamController<String>();

  RealTimeDataHandler() {
    _channel.setMethodCallHandler((call) async {
      if (call.method == 'updateFromNative') {
        _dataStreamController.add(call.arguments);
      }
    });
  }

  Stream<String> get dataStream => _dataStreamController.stream;

  Future<void> connectWebSocket() async {
    try {
      await _channel.invokeMethod('connectWebSocket');
    } on PlatformException catch (e) {
      print("Failed to connect WebSocket: '${e.message}'.");
    }
  }

  void dispose() {
    _dataStreamController.close();
  }
}
