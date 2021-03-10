import 'package:crash_report/tampilan/reportBugPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login/loginPage.dart';

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

  // TAMPILAN
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 24, top: 24),
          color: Color(0xFF031F4B),
          child: Stack(
            children: [
              // ATAS (LOGO, TENTANG APP, REPORT BUG)
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        EdgeInsets.only(left: 8, right: 8, top: 24, bottom: 16),
                    child: Text(
                      "PERANG APP",
                      style: GoogleFonts.openSans(color: Colors.white),
                    ),
                  ),
                  Container(
                    height: 1,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  FlatButton.icon(
                    icon: Icon(
                      Icons.info,
                      color: Colors.white,
                      size: 14,
                    ),
                    label: Text(
                      "Tentang Aplikasi",
                      style: GoogleFonts.openSans(color: Colors.white, fontSize: 12),
                    ),
                    onPressed: () {},
                  ),
                  FlatButton.icon(
                    icon: Icon(
                      Icons.perm_contact_calendar,
                      color: Colors.white,
                      size: 16,
                    ),
                    label: Text(
                      "Contact Dev Team",
                      style: GoogleFonts.openSans(color: Colors.white, fontSize: 12),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => reportBugPage()));

                    },
                  ),
                ],
              ),

              // BAWAH (USER LOGOUT)
              Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                width: double.infinity,
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(bottom: 16, left: 4, right: 4),
                      child: Container(
                        color: Colors.transparent,
                        padding: EdgeInsets.all(0),
                        child: Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              /*IconButton(
                                icon: Icon(Icons.settings),
                                color: Colors.white,
                                onPressed: () {},
                              ),*/
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      name,
                                      style: GoogleFonts.openSans(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      role,
                                      style: GoogleFonts.openSans(
                                          color: Color(0xFFADABAB),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    RaisedButton.icon(
                      label: Text(
                        "Log Out",
                        style: GoogleFonts.openSans(
                            fontWeight: FontWeight.bold, fontSize: 12),
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
                ),
              ),
            ],
          )),
    );
  }
}
