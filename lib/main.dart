import 'package:flutter/material.dart';
import 'splashScreen.dart';
import 'dart:async';

void main() {
  runApp(MaterialApp(
    home: MyHomePage(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PERANG',
    );
  }
}

class MyHomePage extends StatefulWidget {
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(seconds: 3),
      () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => splashScreen(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Image(
          image: AssetImage('assets/logo_perang.png'),
        ),
      ),
    );
  }
}


