import 'package:crash_report/tampilan/login/loadingPage.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'tampilan/login/loginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SharedPreferences preferences = await SharedPreferences.getInstance();
  var bagian = preferences.getString('bagian');

  runApp(MaterialApp(
    title: 'PERANG',
    theme: ThemeData(fontFamily: 'OpenSans'),
    home: bagian != null ? loadingPage() : loginPage(),
    debugShowCheckedModeBanner: false,
    //home: loginPage(),
  ));

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
