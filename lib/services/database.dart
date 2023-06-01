import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mr_museum/models/exhibitions.dart';
import 'package:mr_museum/models/headsets.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final headsets = List;

  Future getHeadsets() async {
    var result = await _db
        .collection('users')
        .doc('E8QTdsFDlSU8vrwDoDkK47mETOZ2') //TODO: change to current user
        .collection('headsets')
        .get();
    return result.docs.map((doc) => Headsets.fromFirestore(doc)).toList();
  }

  Future getExhibitions() async {
    var result = await _db
        .collection('users')
        .doc('E8QTdsFDlSU8vrwDoDkK47mETOZ2') //TODO: change to current user
        .collection('exhibitions')
        .get();
    return result.docs.map((doc) => Exhibitions.fromFirestore(doc)).toList();
  }

  Future addHeadset(ip, name, username, password) async {
    var result = await _db
        .collection('users')
        .doc('E8QTdsFDlSU8vrwDoDkK47mETOZ2') //TODO: change to current user
        .collection('headsets')
        .add({
      'ip': ip,
      'name': name,
      'username': username,
      'password': password,
    });
    return result;
  }

  Future<void> updateExhibitionActiveStatus(
      String exhibitionId, bool isActive) async {
    print(
        'Updating exhibition active status with ID: $exhibitionId to $isActive'); // Debugging line
    return _db
        .collection('users')
        .doc('E8QTdsFDlSU8vrwDoDkK47mETOZ2')
        .collection('exhibitions')
        .doc(exhibitionId)
        .update({'active': isActive});
  }

  Future<void> resetExhibition(String exhibitionId, bool isActive) async {
    return _db
        .collection('users')
        .doc('E8QTdsFDlSU8vrwDoDkK47mETOZ2')
        .collection('exhibitions')
        .doc(exhibitionId)
        .update({'reset': isActive});
  }
}
