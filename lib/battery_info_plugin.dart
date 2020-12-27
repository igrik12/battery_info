import 'dart:async';
import 'package:battery_info/battery_info_platform_interface.dart';
import 'package:battery_info/model/android_battery_info.dart';
import 'package:battery_info/model/iso_battery_info.dart';

/// Plugin for accessing the battery information of the device
class BatteryInfoPlugin {
  /// Returns the battery info as a single API call
  Future<AndroidBatteryInfo> get androidBatteryInfo async =>
      await BatteryInfoPlatform.instance.androidBatteryInfo();

  /// Returns a stream of [BatteryInfo] data that is pushed out to the
  /// subscribers on updates
  Stream<AndroidBatteryInfo> get androidBatteryInfoStream =>
      BatteryInfoPlatform.instance.androidBatteryInfoStream();

  /// Returns the battery info as a single API call
  Future<IosBatteryInfo> get iosBatteryInfo async =>
      BatteryInfoPlatform.instance.iosBatteryInfo();

  /// Returns a stream of [IsoBatteryInfo] data that is pushed out to the
  /// subscribers on updates
  Stream<IosBatteryInfo> get iosBatteryInfoStream =>
      BatteryInfoPlatform.instance.iosBatteryInfoStream();
}
