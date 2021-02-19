import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class homePage extends StatefulWidget {
  final User user;
  final auth = FirebaseAuth.instance;

  const homePage({Key key,
    @required this.user
  }) : super(key: key);
  
  //String _uid = user.uid.toString();

  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Selamat Datang ${widget.user.uid}'),
      ),
    );
  }
}
