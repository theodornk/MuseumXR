import 'dart:convert';

MachineName machinenameFromJson(String str) =>
    MachineName.fromJson(json.decode(str));
String machinenameToJson(MachineName data) => json.encode(data.toJson());

class MachineName {
  MachineName({
    required this.computername,
  });

  String computername;

  factory MachineName.fromJson(Map<String, dynamic> json) => MachineName(
        computername: json["ComputerName"],
      );

  Map<String, dynamic> toJson() => {
        "ComputerName": computername,
      };
}
