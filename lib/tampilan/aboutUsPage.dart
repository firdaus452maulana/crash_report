import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class aboutUsPage extends StatefulWidget {
  @override
  _aboutUsPageState createState() => _aboutUsPageState();
}

class _aboutUsPageState extends State<aboutUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xFF031F4B),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 24),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(top:100,left: 30),
            //color: Colors.red,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  child: Text(
                    'SiAPP',
                    style: GoogleFonts.openSans(
                      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 40),
                  ),
                ),
                Container(
                  //color: Colors.yellow,
                  child: Text(
                    'Sistem Informasi Pelaporan Peralatan',
                    style: GoogleFonts.openSans(
                        color: Colors.white, fontWeight: FontWeight.w100, fontSize: 13),
                  ),
                ),
                Container(
                  color: Colors.white,
                  height: 1,
                  margin: EdgeInsets.only(top: 20,right: 30),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15,right: 40),
                  //color: Colors.yellow,
                  child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                    style: GoogleFonts.openSans(
                        color: Colors.white, fontWeight: FontWeight.w100, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: double.infinity,
            alignment: Alignment.bottomCenter,
            //color: Colors.yellow,
            child: Row(
              children: [
                Container(
                  //color: Colors.green,
                  child: IconButton(
                    icon: Image.asset('assets/igw.png'),
                    iconSize: 5.0,
                    onPressed: (){
                      const url = 'https://instagram.com/muhammadhaafidz';
                      if (canLaunch(url) != null) {
                       launch(url);
                      } else {
                      throw 'Could not launch $url';
                      }
                    },
                  ),
                ),
                Container(
                  //color: Colors.green,
                  child: IconButton(
                    icon: Image.asset('assets/waw.png'),
                    iconSize: 5.0,
                    onPressed: (){
                      const url = 'https://wa.me/6285334103670?text=Halo';
                      if (canLaunch(url) != null) {
                        launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
