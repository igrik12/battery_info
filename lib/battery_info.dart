
import 'dart:async';

import 'package:flutter/services.dart';

class BatteryInfo {
  static const MethodChannel _channel =
      const MethodChannel('battery_info');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
