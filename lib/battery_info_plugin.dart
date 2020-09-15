import 'dart:async';
import 'package:battery_info/model/battery_info.dart';
import 'package:flutter/services.dart';

/// Plugin for accessing the battery information of the device
class BatteryInfoPlugin {
  static const MethodChannel _methodChannel =
      const MethodChannel('com.twarkapps.battery_info/channel');
  static const EventChannel _streamChannel =
      EventChannel("com.twarkapps.battery_info/stream");

  /// Returns the battery info as a single API call
  static Future<BatteryInfo> get batteryInfo async {
    final batteryInfo = await _methodChannel.invokeMethod('getBatteryInfo');
    final converted = BatteryInfo.fromJson(Map.from(batteryInfo));
    return converted;
  }

  /// Returns a stream of [BatteryInfo] data that is pushed out to the
  /// subscribers on updates
  static Stream<BatteryInfo> get batteryInfoStream {
    return _streamChannel.receiveBroadcastStream().map((data) {
      final converted = BatteryInfo.fromJson(Map.from(data));
      return converted;
    });
  }
}
