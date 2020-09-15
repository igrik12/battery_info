import 'package:battery_info/enums/charging_status.dart';

/// Battery Info data model
class BatteryInfo {
  int batteryLevel = -1;
  ChargingStatus chargingStatus = ChargingStatus.Unknown;
  int currentNow = -1;
  int currentAverage = -1;
  int chargeTimeRemaining = -1;
  String health = "unknown";
  String pluggedStatus = "unknown";
  int temperature = -1;
  int voltage = -1;

  BatteryInfo(
      {this.batteryLevel,
      this.chargeTimeRemaining,
      this.chargingStatus,
      this.currentAverage,
      this.currentNow,
      this.health,
      this.pluggedStatus,
      this.temperature,
      this.voltage});

  /// Deserialise data from json to the model
  BatteryInfo.fromJson(Map<String, dynamic> json) {
    this.batteryLevel = json["batteryLevel"];
    this.chargeTimeRemaining = json["chargeTimeRemaining"];
    this.chargingStatus = _getChargingStatus(json["chargingStatus"]);
    this.currentAverage = json["currentAverage"];
    this.currentNow = json["currentNow"];
    this.health = json["health"];
    this.pluggedStatus = json["pluggedStatus"];
    this.temperature = json["temperature"];
    this.voltage = json["voltage"];
  }

  ChargingStatus _getChargingStatus(String status) {
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

  /// Serialise data back to json from the model
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["batteryLevel"] = this.batteryLevel;
    data["chargeTimeRemaining"] = this.chargeTimeRemaining;
    data["chargingStatus"] = this.chargingStatus;
    data["currentAverage"] = this.currentAverage;
    data["currentNow"] = this.currentNow;
    data["health"] = this.health;
    data["pluggedStatus"] = this.pluggedStatus;
    data["temperature"] = this.temperature;
    data["voltage"] = this.voltage;
    return data;
  }
}
