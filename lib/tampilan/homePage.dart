import 'package:crash_report/tampilan/loginPage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class homePage extends StatefulWidget {
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String uid, name;

  DatabaseReference userData = FirebaseDatabase.instance.reference().child('users');

  // BUAT NGERUN FUNGSI PAS APP START
  @override
  void initState() {
    _ambilPreference();
    _getUserData();
  }

  // NAVIGASI KE HALAMAN LOGIN
  _navLogOutSuccess() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => loginPage()),
      (route) => false,
    );
  }

  // FUNGSI SIGN OUT
  Future<void> _signOut(BuildContext context) async {
    await _auth.signOut().then((value) {
      _navLogOutSuccess();
    });
  }

  // AMBIL SHARED PREFERENCES
  Future<void> _ambilPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      uid = preferences.getString('uid');
      name = preferences.getString('name');
    });
  }

  Future<void> _getUserData() async {
    // AMBIL DATA DARI REALTIME DATABASE
    await userData.child(uid).once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic>.from(snapshot.value).forEach((key,values) {
        setState(() {
          print("snapshot value: " + values.toString());
          if (key == 'name'){
            name = values.toString();
            print("nama pegawai: " + name);
          } else{
            print("bukan bagian");
          }
        });
      });
    });
  }

  // TAMPILAN
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Text(name),
            Text(uid),
            Text(uid),

            RaisedButton(
              onPressed: () async {
                SharedPreferences preference =
                    await SharedPreferences.getInstance();
                preference.clear();
                _signOut(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
