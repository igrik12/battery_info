import 'package:battery_info/enums/charging_status.dart';

/// Android Battery Info data model
class AndroidBatteryInfo {
  int currentNow = -1;
  int currentAverage = -1;
  int chargeTimeRemaining = -1;
  String health = "unknown";
  String pluggedStatus = "unknown";
  int temperature = -1;
  int voltage = -1;
  int batteryLevel;
  ChargingStatus chargingStatus;

  AndroidBatteryInfo(
      {this.chargeTimeRemaining,
      this.currentAverage,
      this.currentNow,
      this.health,
      this.pluggedStatus,
      this.temperature,
      this.voltage,
      this.batteryLevel,
      this.chargingStatus});

  /// Serialise data back to json from the model
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["batteryLevel"] = this.batteryLevel;
    data["chargingStatus"] = this.chargingStatus;
    data["chargeTimeRemaining"] = this.chargeTimeRemaining;
    data["currentAverage"] = this.currentAverage;
    data["currentNow"] = this.currentNow;
    data["health"] = this.health;
    data["pluggedStatus"] = this.pluggedStatus;
    data["temperature"] = this.temperature;
    data["voltage"] = this.voltage;
    return data;
  }

  ChargingStatus getChargingStatus(String status) {
    switch (status) {
      case "charging":
        return ChargingStatus.Charging;
      case "discharging":
        return ChargingStatus.Discharging;
      case "full":
        return ChargingStatus.Full;
      default:
        return ChargingStatus.Unknown;
    }
  }

  @override
  AndroidBatteryInfo.fromJson(Map<String, dynamic> json) {
    this.batteryLevel = json["batteryLevel"];
    this.chargingStatus = getChargingStatus(json["chargingStatus"]);
    this.chargeTimeRemaining = json["chargeTimeRemaining"];
    this.currentAverage = json["currentAverage"];
    this.currentNow = json["currentNow"];
    this.health = json["health"];
    this.pluggedStatus = json["pluggedStatus"];
    this.temperature = json["temperature"];
    this.voltage = json["voltage"];
  }
}
