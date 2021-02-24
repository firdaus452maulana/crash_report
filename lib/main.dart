import 'package:crash_report/tampilan/homePage.dart';
import 'package:crash_report/tampilan/mainMenuUser.dart';
import 'package:crash_report/tampilan/pilihBagianPage.dart';
import 'package:flutter/material.dart';
import 'tampilan/loginPage.dart';
import 'models/authentication.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SharedPreferences preferences = await SharedPreferences.getInstance();
  var email = preferences.getString('email');

  runApp(MaterialApp(
    title: 'PERANG',
    theme: ThemeData(fontFamily: 'OpenSans'),
    home: email == null ? pilihBagianPage() : mainMenuUser(),));
  //runApp(MyApp());
}

/*class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'PERANG',
        theme: ThemeData(fontFamily: 'OpenSans'),
        //home: pilihBagianPage(),
    );
  }
}*/


