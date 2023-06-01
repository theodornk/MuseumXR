import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mr_museum/models/power.dart';

class Exhibitions {
  String name;
  String id;
  bool active;
  bool reset;

  Exhibitions(
      {required this.name,
      required this.id,
      required this.active,
      required this.reset});

  factory Exhibitions.fromFirestore(DocumentSnapshot doc) {
    Map? data = doc.data() as Map;

    return Exhibitions(
      name: data['name'] ?? '',
      id: doc.id,
      active: data['active'] ?? false,
      reset: data['reset'] ?? false,
    );
  }
}
