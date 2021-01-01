import 'package:battery_info/battery_info_plugin.dart';
import 'package:battery_info/model/android_battery_info.dart';
import 'package:battery_info/model/iso_battery_info.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("$BatteryInfoPlugin ", () {
    setUp(() async {
      BatteryInfoPlugin.methodChannel
          .setMockMethodCallHandler((MethodCall methodCall) async {
        switch (methodCall.method) {
          case 'getBatteryInfo':
            return (AndroidBatteryInfo()
                  ..batteryLevel = 90
                  ..chargeTimeRemaining = 1000)
                .toJson();
          default:
            return null;
        }
      });

      MethodChannel(BatteryInfoPlugin.streamChannel.name)
          .setMockMethodCallHandler((MethodCall methodCall) async {
        switch (methodCall.method) {
          case 'listen':
            await ServicesBinding.instance.defaultBinaryMessenger
                .handlePlatformMessage(
              BatteryInfoPlugin.streamChannel.name,
              BatteryInfoPlugin.streamChannel.codec.encodeSuccessEnvelope(
                  (AndroidBatteryInfo()..health = "healthy").toJson()),
              (_) {},
            );
            break;
          case 'cancel':
          default:
            return null;
        }
      });
    });

    test("getBatteryInfo for Android", () async {
      final AndroidBatteryInfo result =
          await BatteryInfoPlugin().androidBatteryInfo;
      expect(result.batteryLevel, 90);
      expect(result.chargeTimeRemaining, 1000);
    });

    test("androidBatteryInfoStream for Android", () async {
      final AndroidBatteryInfo result =
          await BatteryInfoPlugin().androidBatteryInfoStream.first;
      expect(result.health, "healthy");
    });
  });

  group("$BatteryInfoPlugin IOS", () {
    setUp(() async {
      BatteryInfoPlugin.methodChannel
          .setMockMethodCallHandler((MethodCall methodCall) async {
        switch (methodCall.method) {
          case 'getBatteryInfo':
            return (IosBatteryInfo()..batteryLevel = 60).toJson();
          default:
            return null;
        }
      });

      MethodChannel(BatteryInfoPlugin.streamChannel.name)
          .setMockMethodCallHandler((MethodCall methodCall) async {
        switch (methodCall.method) {
          case 'listen':
            await ServicesBinding.instance.defaultBinaryMessenger
                .handlePlatformMessage(
              BatteryInfoPlugin.streamChannel.name,
              BatteryInfoPlugin.streamChannel.codec.encodeSuccessEnvelope(
                  (IosBatteryInfo()..batteryLevel = 60).toJson()),
              (_) {},
            );
            break;
          case 'cancel':
          default:
            return null;
        }
      });
    });

    test("getBatteryInfo for IOS", () async {
      final IosBatteryInfo result = await BatteryInfoPlugin().iosBatteryInfo;
      expect(result.batteryLevel, 60);
    });

    test("androidBatteryInfoStream for IOS", () async {
      final IosBatteryInfo result =
          await BatteryInfoPlugin().iosBatteryInfoStream.first;
      expect(result.batteryLevel, 60);
    });
  });
}
