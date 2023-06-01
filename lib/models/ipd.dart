import 'dart:convert';

IPDStatus ipdstatusFromJson(String str) => IPDStatus.fromJson(json.decode(str));
String ipdstatusToJson(IPDStatus data) => json.encode(data.toJson());

class IPDStatus {
  IPDStatus({
    required this.ipd,
  });

  int ipd;

  factory IPDStatus.fromJson(Map<String, dynamic> json) => IPDStatus(
        ipd: json["ipd"],
      );

  Map<String, dynamic> toJson() => {
        "ipd": ipd,
      };
}
