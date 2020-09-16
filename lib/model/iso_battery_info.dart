import 'package:battery_info/enums/charging_status.dart';

class IosBatteryInfo {
  int batteryLevel;
  ChargingStatus chargingStatus;
  IosBatteryInfo({this.batteryLevel, this.chargingStatus});

  /// Serialise data back to json from the model
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["batteryLevel"] = this.batteryLevel;
    data["chargingStatus"] = this.chargingStatus;
    return data;
  }

  ChargingStatus getChargingStatus(String status) {
    switch (status) {
      case "charging":
        return ChargingStatus.Charging;
      case "unplugged":
        return ChargingStatus.Discharging;
      case "full":
        return ChargingStatus.Full;
      default:
        return ChargingStatus.Unknown;
    }
  }

  @override
  IosBatteryInfo.fromJson(Map<String, dynamic> json) {
    this.batteryLevel = json["batteryLevel"];
    this.chargingStatus = getChargingStatus(json["chargingStatus"]);
  }
}
