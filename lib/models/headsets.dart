import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mr_museum/models/power.dart';

class Headsets {
  final String ip;
  String name;
  final String username;
  final String password;
  int batteryLevel;
  int ipdLevel;
  String machineName;

  Headsets(
      {required this.ip,
      required this.name,
      required this.username,
      required this.password,
      this.batteryLevel = 0,
      this.ipdLevel = 0,
      this.machineName = ''});

  factory Headsets.fromFirestore(DocumentSnapshot doc) {
    Map? data = doc.data() as Map;

    return Headsets(
      ip: data['ip'] ?? '',
      name: data['name'] ?? '',
      username: data['username'] ?? '',
      password: data['password'] ?? '',
      //batteryLevel: data['batteryLevel'] ?? '',
      //ipdLevel: data['ipdLevel'] ?? '',
      //machineName: data['machineName'] ?? '',
    );
  }
}
