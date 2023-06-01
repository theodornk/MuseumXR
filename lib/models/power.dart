import 'dart:convert';

Powerstatus powerstatusFromJson(String str) =>
    Powerstatus.fromJson(json.decode(str));

String powerstatusToJson(Powerstatus data) => json.encode(data.toJson());

class Powerstatus {
  Powerstatus({
    required this.acOnline,
    required this.batteryPresent,
    required this.charging,
    required this.defaultAlert1,
    required this.defaultAlert2,
    required this.estimatedTime,
    required this.maximumCapacity,
    required this.remainingCapacity,
  });

  int acOnline;
  int batteryPresent;
  int charging;
  int defaultAlert1;
  int defaultAlert2;
  int estimatedTime;
  int maximumCapacity;
  int remainingCapacity;

  factory Powerstatus.fromJson(Map<String, dynamic> json) => Powerstatus(
        acOnline: json["AcOnline"],
        batteryPresent: json["BatteryPresent"],
        charging: json["Charging"],
        defaultAlert1: json["DefaultAlert1"],
        defaultAlert2: json["DefaultAlert2"],
        estimatedTime: json["EstimatedTime"],
        maximumCapacity: json["MaximumCapacity"],
        remainingCapacity: json["RemainingCapacity"],
      );

  Map<String, dynamic> toJson() => {
        "AcOnline": acOnline,
        "BatteryPresent": batteryPresent,
        "Charging": charging,
        "DefaultAlert1": defaultAlert1,
        "DefaultAlert2": defaultAlert2,
        "EstimatedTime": estimatedTime,
        "MaximumCapacity": maximumCapacity,
        "RemainingCapacity": remainingCapacity,
      };
}
