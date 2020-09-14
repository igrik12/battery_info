import 'dart:async';
import 'dart:convert';

import 'package:battery_info/model/battery_info.dart';
import 'package:flutter/services.dart';

class BatteryInfoPlugin {
  static const MethodChannel _methodChannel =
      const MethodChannel('com.twarkapps.battery_info/channel');
  static const EventChannel _streamChannel =
      EventChannel("com.twarkapps.battery_info/stream");

  static Future<BatteryInfo> get batteryInfo async {
    final batteryInfo = await _methodChannel.invokeMethod('getBatteryInfo');
    final converted = BatteryInfo.fromJson(Map.from(batteryInfo));
    return converted;
  }

  static Stream<BatteryInfo> get batteryInfoStream {
    return _streamChannel.receiveBroadcastStream().map((data) {
      final converted = BatteryInfo.fromJson(Map.from(data));
      return converted;
    });
  }
}
