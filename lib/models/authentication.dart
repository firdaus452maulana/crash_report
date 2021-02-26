import 'package:crash_report/models/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthenticationService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future createPegawai(String name, String role, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      await DatabaseManager().setPegawaiRealtime(name, email, role, user.uid);
      return user;
    } catch (e) {
      print(e.toString());
    }
  }

  Future createTeknisi(String name, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      await DatabaseManager().setTeknisiRealtime(name, email, user.uid);
      return user;
    } catch (e) {
      print(e.toString());
    }
  }

  Future signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
    }
  }

  Future createResetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }

}

