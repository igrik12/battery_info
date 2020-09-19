import 'package:flutter/services.dart';
import 'battery_info_platform_interface.dart';

/// An implementation of [BatteryInfoPlatform] that uses method channels.
class MethodChannelBatteryInfo extends BatteryInfoPlatform {
  /// The method channel used to interact with the native platform.
  static MethodChannel channel =
      MethodChannel('com.igrik12.battery_info/channel');

  /// The event channel used to interact with the native platform.
  static EventChannel eventChannel =
      EventChannel('com.igrik12.battery_info/stream');
}
