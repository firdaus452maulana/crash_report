import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseManager {
  final CollectionReference userList = FirebaseFirestore.instance.collection('users');

  Future<void> setPegawai(String name, String email, String role, String uid) async {
    return await userList.doc(uid).set({
      'name': name,
      'email': email,
      'role': role,
      'bagian': "pegawai"
    });
  }

  Future<void> setTeknisi(String name, String email,  String uid) async {
    return await userList.doc(uid).set({
      'name': name,
      'email': email,
      'bagian': "teknisi"
    }).then((value) async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('email', email);
    });
  }
}


