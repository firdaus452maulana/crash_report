import 'package:flutter/material.dart';
import 'loginPage.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PERANG',
      theme: ThemeData(fontFamily: 'OpenSans'),
      home: loginPage(),
    );
  }
}


