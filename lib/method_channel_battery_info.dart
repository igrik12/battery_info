import 'package:battery_info/model/android_battery_info.dart';
import 'package:battery_info/model/iso_battery_info.dart';
import 'package:flutter/services.dart';
import 'battery_info_platform_interface.dart';

/// An implementation of [BatteryInfoPlatform] that uses method channels.
class MethodChannelBatteryInfo implements BatteryInfoPlatform {
  /// The method channel used to interact with the native platform.
  static MethodChannel _methodChannel =
      MethodChannel('com.igrik12.battery_info/channel');

  /// The event channel used to interact with the native platform.
  static EventChannel _streamChannel =
      EventChannel('com.igrik12.battery_info/stream');

  @override
  Future<AndroidBatteryInfo> androidBatteryInfo() async {
    try {
      final batteryInfo = await _methodChannel.invokeMethod('getBatteryInfo');
      final converted = AndroidBatteryInfo.fromJson(Map.from(batteryInfo));
      return converted;
    } on PlatformException catch (e) {
      print(e.message);
      return null;
    }
  }

  @override
  Future<IosBatteryInfo> iosBatteryInfo() async {
    try {
      final batteryInfo = await _methodChannel.invokeMethod('getBatteryInfo');
      final converted = IosBatteryInfo.fromJson(Map.from(batteryInfo));
      return converted;
    } on PlatformException catch (e) {
      print(e.message);
      return null;
    }
  }

  @override
  Stream<AndroidBatteryInfo> androidBatteryInfoStream() {
    return _streamChannel.receiveBroadcastStream().map((data) {
      try {
        final converted = AndroidBatteryInfo.fromJson(Map.from(data));
        return converted;
      } on PlatformException catch (e) {
        print(e.message);
        return null;
      }
    });
  }

  @override
  Stream<IosBatteryInfo> iosBatteryInfoStream() {
    return _streamChannel.receiveBroadcastStream().map((data) {
      try {
        final converted = IosBatteryInfo.fromJson(Map.from(data));
        return converted;
      } on PlatformException catch (e) {
        print(e.message);
        return null;
      }
    });
  }
}
