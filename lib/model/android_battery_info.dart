import 'package:battery_info/enums/charging_status.dart';

/// Android Battery Info data model
class AndroidBatteryInfo {
  int? currentNow = -1;
  int? currentAverage = -1;
  int? chargeTimeRemaining = -1;
  String? health = "unknown";
  String? pluggedStatus = "unknown";
  String? technology = "unknown";
  int? batteryLevel;
  int? batteryCapacity;
  int? remainingEnergy = -1;
  int? scale;
  int? temperature = -1;
  int? voltage = -1;
  bool? present = true;
  ChargingStatus? chargingStatus;

  AndroidBatteryInfo({
    this.batteryCapacity,
    this.batteryLevel,
    this.chargeTimeRemaining,
    this.chargingStatus,
    this.currentAverage,
    this.currentNow,
    this.health,
    this.pluggedStatus,
    this.present,
    this.remainingEnergy,
    this.scale,
    this.technology,
    this.temperature,
    this.voltage,
  });

  /// Serialise data back to json from the model
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["batteryCapacity"] = this.batteryCapacity;
    data["batteryLevel"] = this.batteryLevel;
    data["chargingStatus"] = this.chargingStatus;
    data["chargeTimeRemaining"] = this.chargeTimeRemaining;
    data["currentAverage"] = this.currentAverage;
    data["currentNow"] = this.currentNow;
    data["health"] = this.health;
    data["pluggedStatus"] = this.pluggedStatus;
    data["present"] = this.present;
    data["scale"] = this.scale;
    data["remainingEnergy"] = this.remainingEnergy;
    data["temperature"] = this.temperature;
    data["technology"] = this.technology;
    data["voltage"] = this.voltage;
    return data;
  }

  /// Retrieves the chargin status from the native value
  ChargingStatus getChargingStatus(String? status) {
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

  /// Deserialize data from json
  AndroidBatteryInfo.fromJson(Map<String, dynamic> json) {
    this.batteryCapacity = json["batteryCapacity"];
    this.batteryLevel = json["batteryLevel"];
    this.chargingStatus = getChargingStatus(json["chargingStatus"]);
    this.chargeTimeRemaining = json["chargeTimeRemaining"];
    this.currentAverage = json["currentAverage"];
    this.currentNow = json["currentNow"];
    this.health = json["health"];
    this.pluggedStatus = json["pluggedStatus"];
    this.present = json["present"];
    this.scale = json["scale"];
    this.remainingEnergy = json["remainingEnergy"];
    this.technology = json["technology"];
    this.temperature = json["temperature"];
    this.voltage = json["voltage"];
  }
}
