import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'tampilan/loginPage.dart';
import 'models/authentication.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Authentication())
      ],
      child: MaterialApp(
        title: 'PERANG',
        theme: ThemeData(fontFamily: 'OpenSans'),
        home: loginPage(),
      ),
    );
  }
}


