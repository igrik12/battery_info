import 'dart:async';
import 'package:battery_info/model/android_battery_info.dart';
import 'package:battery_info/model/iso_battery_info.dart';
import 'package:flutter/services.dart';

/// Plugin for accessing the battery information of the device
class BatteryInfoPlugin {
  static const MethodChannel _methodChannel =
      const MethodChannel('com.igrik12.battery_info/channel');
  static const EventChannel _streamChannel =
      EventChannel("com.igrik12.battery_info/stream");

  /// Returns the battery info as a single API call
  Future<AndroidBatteryInfo> get androidBatteryInfo async {
    final batteryInfo = await _methodChannel.invokeMethod('getBatteryInfo');
    final converted = AndroidBatteryInfo.fromJson(Map.from(batteryInfo));
    return converted;
  }

  /// Returns a stream of [BatteryInfo] data that is pushed out to the
  /// subscribers on updates
  Stream<AndroidBatteryInfo> get androidBatteryInfoStream {
    return _streamChannel.receiveBroadcastStream().map((data) {
      final converted = AndroidBatteryInfo.fromJson(Map.from(data));
      return converted;
    });
  }

  /// Returns the battery info as a single API call
  Future<IosBatteryInfo> get iosBatteryInfo async {
    final batteryInfo = await _methodChannel.invokeMethod('getBatteryInfo');
    final converted = IosBatteryInfo.fromJson(Map.from(batteryInfo));
    return converted;
  }

  /// Returns a stream of [IsoBatteryInfo] data that is pushed out to the
  /// subscribers on updates
  Stream<IosBatteryInfo> get iosBatteryInfoStream {
    return _streamChannel.receiveBroadcastStream().map((data) {
      final converted = IosBatteryInfo.fromJson(Map.from(data));
      return converted;
    });
  }
}
