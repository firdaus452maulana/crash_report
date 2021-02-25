import 'package:crash_report/tampilan/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';


class homePage extends StatefulWidget {
  final auth = FirebaseAuth.instance;
  String uid;
  homePage({Key key, @required this.uid}) : super(key: key);

  /*const homePage({Key key,
    @required this._uid
  }) : super(key: key);*/

  //String _uid = user.uid.toString();

  @override
  _homePageState createState() => _homePageState(uid);
}

class _homePageState extends State<homePage> {

  var role;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String uid;
  _homePageState(this.uid);

  Future<void> _signOut(BuildContext context) async {
    await _auth.signOut().then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => loginPage()));
    });
  }

  Future<void> ambilPreference() async {
    SharedPreferences preferences2 = await SharedPreferences.getInstance();
    role = preferences2.getString('uid');
    uid = role.toString();
  }

  @override
  Widget build(BuildContext context) {

    if(uid == null){
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                onPressed: () async {
                  SharedPreferences preference = await SharedPreferences.getInstance();
                  preference.remove('role');
                  _signOut(context);
                },
              ),
              Text("Kosong"),
            ],
          ),
        ),
      );
    }

    else {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(uid)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Text('Loading..');
                    default:
                      return Text("Selamat Datang " + snapshot.data['name']);
                  }
                },
              ),

              RaisedButton(
                onPressed: () async {
                  SharedPreferences preference = await SharedPreferences.getInstance();
                  preference.remove('role');
                  _signOut(context);
                },
              ),

              Text(uid),

            ],
          ),
        ),
      );
    }
  }
}
