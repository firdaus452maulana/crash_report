import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseManager {
  final CollectionReference userList = FirebaseFirestore.instance.collection('users');

  Future<void> userSetup(String name, String role, String uid) async {
    return await userList.doc(uid).set({
      'name': name,
      'role': role,
    });
  }
}


