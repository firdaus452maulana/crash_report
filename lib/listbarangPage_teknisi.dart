import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class listbarangPage_teknisi extends StatefulWidget {
  @override
  _listbarangPage_teknisiState createState() => _listbarangPage_teknisiState();
}

class _listbarangPage_teknisiState extends State<listbarangPage_teknisi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
      body: Stack(
          children: <Widget>[
       Container(
      decoration: BoxDecoration(
          color: Colors.blue
      ),
       ),
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  "Selamat Datang",
                  style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
              ),
            Text(
              "Hafid",
               style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24),
            ),
            Text(
            "Teknisi",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24),),
            ],
          ),
        ),
        Center(
          //list barang
           child: Container(
           margin: EdgeInsets.only(left: 32, right: 32),
            height: 500,
            decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
           BoxShadow(
             color: Colors.grey.withOpacity(0.05),
             spreadRadius: 10,
              blurRadius: 10,
              offset: Offset(0, 0),
             )
             ],
          borderRadius: BorderRadius.circular(17.5),
             ),
            child: Stack(
              children: <Widget>[
              Container(
               margin: EdgeInsets.only(left: 32, right: 32),
               height: 500,
                decoration: BoxDecoration(
                 color: Colors.white,
                 boxShadow: [
                 BoxShadow(
                color: Colors.grey.withOpacity(0.05),
                 spreadRadius: 10,
                 blurRadius: 10,
               offset: Offset(0, 0),
                 )
               ],
               borderRadius: BorderRadius.circular(17.5),
              ),
             ),
            ],
          ),
             ),
        ),
    ],
    ));
}
}