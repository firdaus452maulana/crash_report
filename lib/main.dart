import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'tampilan/loginPage.dart';
import 'models/authentication.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: null)
      ],
      child: MaterialApp(
        title: 'PERANG',
        theme: ThemeData(fontFamily: 'OpenSans'),
        home: loginPage(),
      ),
    );
  }
}


