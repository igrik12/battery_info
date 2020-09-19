# Battery Info

[pub package](https://pub.dartlang.org/packages/battery_info)

Flutter plugin, inspired by [battery](https://pub.dev/packages/battery) package, providing detailed information about the device battery (level, health, charging status, etc.). Now supports both IOS and Android.

* Remaining charge time is only available on API level 28 (Android 9 Pie) and higher

👀 Unfortunately, due to Apple limitations can only retrieve battery level and charging status for the IOS devices.

## Usage

To use this plugin, add `battery_info` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

### Example

```dart
// Import package
import 'package:battery/battery_info.dart';
import 'package:battery_info/model/android_battery_info.dart';
import 'package:battery_info/enums/charging_status.dart';

// Access current battery health
print("Battery Level: ${(await BatteryInfoPlugin().androidBatteryInfo).health}");

// Calculate estimated charging time
BatteryInfoPlugin().androidBatteryInfoStream.listen((AndroidBatteryInfo batteryInfo) {
  print("Charge time remaining: ${(batteryInfo.chargeTimeRemaining / 1000 / 60).truncate()} minutes");
});
```
