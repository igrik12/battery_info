import 'package:battery_info/model/android_battery_info.dart';
import 'package:battery_info/model/iso_battery_info.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'method_channel_battery_info.dart';

abstract class BatteryInfoPlatform extends PlatformInterface {
  BatteryInfoPlatform() : super(token: _token);

  static final Object _token = Object();

  static BatteryInfoPlatform _instance = MethodChannelBatteryInfo();

  /// The default instance of [BatteryInfoPlatform] to use.
  ///
  /// Defaults to [MethodChannelBattery].
  static BatteryInfoPlatform get instance => _instance;

  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [BatteryInfoPlatform] when they register themselves.
  static set instance(BatteryInfoPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Gets the android battery info from device.
  Future<AndroidBatteryInfo> androidBatteryInfo() {
    throw UnimplementedError('androidBatteryInfo() has not been implemented.');
  }

  /// gets android battery info from device.
  Stream<AndroidBatteryInfo> androidBatteryInfoStream() {
    throw UnimplementedError(
        'onAndroidBatteryInfoChanged() has not been implemented.');
  }

  /// Gets the ios battery info from device.
  Future<IosBatteryInfo> iosBatteryInfo() {
    throw UnimplementedError('iosBatteryInfo() has not been implemented.');
  }

  /// gets ios battery info from device.
  Stream<IosBatteryInfo> iosBatteryInfoStream() {
    throw UnimplementedError(
        'onIosBatteryInfoChanged() has not been implemented.');
  }
}
