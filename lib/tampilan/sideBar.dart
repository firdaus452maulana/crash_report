import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'loginPage.dart';

class sideBar extends StatefulWidget {
  @override
  _sideBarState createState() => _sideBarState();
}

class _sideBarState extends State<sideBar> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String uid = '';
  String name = '';
  String role = '';

  @override
  void initState() {
    super.initState();
    _ambilPreference();
  }

  // AMBIL SHARED PREFERENCES
  Future<void> _ambilPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      uid = preferences.getString('uid');
      name = preferences.getString('name');
      role = preferences.getString('role');
    });
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

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
          padding: EdgeInsets.only(left: 32, right: 32, bottom: 24, top: 24),
          color: Color(0xFF031F4B),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 16, left: 4, right: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      role,
                      style: TextStyle(
                          color: Color(0xFFADABAB),
                          fontSize: 12,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
              RaisedButton.icon(
                label: Text(
                  "Log Out",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
                icon: Icon(
                  Icons.arrow_back,
                  size: 16,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17.5)),
                onPressed: () async {
                  SharedPreferences preference =
                      await SharedPreferences.getInstance();
                  preference.clear();
                  _signOut(context);
                },
              )
            ],
          )),
    );
  }
}
