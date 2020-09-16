# Battery Info

[pub package](https://pub.dartlang.org/packages/battery_info)

Flutter plugin, inspired by [battery](https://pub.dev/packages/battery) package, providing detailed information about the device battery (level, health, charging status, etc.).<br/> Currently only supports Android (IOS coming in the future)

## Usage

To use this plugin, add `battery_info` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

### Example

```dart
// Import package
import 'package:battery/battery_info.dart';


// Access current battery health
print("Battery Level: ${(await BatteryInfoPlugin.batteryInfo.health)}");

BatteryInfoPlugin.batteryInfoStream.listen((BatteryInfo batteryInfo) {
  print("Charge time remaining: ${(data.chargeTimeRemaining / 1000 / 60).truncate()} minutes");
});
```

API reference can be found here:
[API reference](https://pub.dev/documentation/battery_info/latest/model_battery_info/BatteryInfo-class.html)
