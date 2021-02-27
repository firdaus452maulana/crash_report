import 'package:firebase_database/firebase_database.dart';

class DatabaseManager {
  final userListRealtime = FirebaseDatabase.instance.reference().child('users');

  Future<void> setPegawaiRealtime(
      String name, String email, String role, String uid) async {
    return await DatabaseManager()
        .userListRealtime
        .child(uid)
        .set({'name': name, 'email': email, 'role': role, 'bagian': "pegawai"});
  }

  Future<void> setTeknisiRealtime(String name, String email, String uid) async {
    return await DatabaseManager()
        .userListRealtime
        .child(uid)
        .set({'name': name, 'email': email, 'bagian': "teknisi"});
  }
}
