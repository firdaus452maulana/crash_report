import 'package:crash_report/tampilan/mainMenu/mainMenuTeknisi.dart';
import 'package:crash_report/tampilan/mainMenu/mainMenuPegawai.dart';
import 'package:crash_report/tampilan/mainMenu/mainMenuAdmin.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class loadingPage extends StatefulWidget {
  @override
  _loadingPageState createState() => _loadingPageState();
}

class _loadingPageState extends State<loadingPage> {
  String bagian;

  // NAVIGASI KE HALAMAN HOME PEGAWAI DAN TEKNISI
  _navSignInSuccess() {
    if (bagian == "pegawai") {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => mainMenuPegawai()),
        (route) => false,
      );
    }

    if (bagian == "admin") {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => mainMenuAdmin()),
            (route) => false,
      );
    }

    if (bagian == "teknisi") {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => mainMenuTeknisi()),
        (route) => false,
      );
    }
  }

  // FUNGSI SHARED PREFERENCES
  Future<void> _ambilPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      bagian = preferences.getString('bagian');
      _navSignInSuccess();
    });
  }

  // BUAT NGERUN FUNGSI PAS APP START
  @override
  void initState() {
    try {
      _ambilPreference();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
