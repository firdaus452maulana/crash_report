import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homePage.dart';
import 'mainMenuUser.dart';

class loadingPage extends StatefulWidget {
  @override
  _loadingPageState createState() => _loadingPageState();
}

class _loadingPageState extends State<loadingPage> {

  String role;

  // FUNGSI SHARED PREFERENCES
  Future<void> _ambilPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      role = preferences.getString('role');
      if (role == "teknisi") {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => mainMenuUser()));
      }
      if (role == "pegawai") {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => homePage()));
      }
    });
  }

  // BUAT NGERUN FUNGSI PAS APP START
  @override
  void initState() {
    _ambilPreference();
    if (role == "pegawai") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => homePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
