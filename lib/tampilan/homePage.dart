import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class homePage extends StatefulWidget {

  final auth = FirebaseAuth.instance;

  String uid;
  homePage({Key key, @required this.uid}) : super(key : key);

  /*const homePage({Key key,
    @required this._uid
  }) : super(key: key);*/
  
  //String _uid = user.uid.toString();

  @override
  _homePageState createState() => _homePageState(uid);
}

class _homePageState extends State<homePage> {
  String uid;
  _homePageState(this.uid);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance.collection('users').doc(uid).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
                if(snapshot.hasError){
                  return Text('Error: ${snapshot.error}');
                }
                switch(snapshot.connectionState){
                  case ConnectionState.waiting: return Text('Loading..');
                  default:
                    return Text("Selamat Datang "+snapshot.data['name']);
                }
              },
            ),

            Text(uid),
          ],
        ),
      ),
    );
  }
}
