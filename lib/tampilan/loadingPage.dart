import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homePage.dart';
import 'mainMenuUser.dart';

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
        MaterialPageRoute(builder: (context) => homePage()),
            (route) => false,
      );
    }

    if (bagian == "teknisi") {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => mainMenuUser()),
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
    try{
      _ambilPreference();
    }catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
