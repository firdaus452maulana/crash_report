import 'package:flutter/cupertino.dart';
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
      backgroundColor: Color(0xFF031F4B),
      body: Stack(
        children: [
          Image(
            image: AssetImage('assets/bgt.png'),
          ),
          Container(
            margin: EdgeInsets.only(top: 24),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 100, left: 30),
            //color: Colors.red,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  child: Text(
                    'SiAPP',
                    style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 40),
                  ),
                ),
                Container(
                  //color: Colors.yellow,
                  child: Text(
                    'Sistem Informasi Pelaporan Peralatan',
                    style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontWeight: FontWeight.w100,
                        fontSize: 13),
                  ),
                ),
                Container(
                  color: Colors.white,
                  height: 1,
                  margin: EdgeInsets.only(top: 20, right: 30),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15, right: 40),
                  //color: Colors.yellow,
                  child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                    style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontWeight: FontWeight.w100,
                        fontSize: 13),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    'in Cooperation with.',
                    style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 10),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 6),
                  //color: Colors.green,
                  child: Row(
                    children: [
                      Image(
                        width: 35,
                        height: 35,
                        image: AssetImage('assets/airnav2.png'),
                      ),
                      Image(
                        width: 60,
                        height: 35,
                        image: AssetImage('assets/pens.png'),
                      ),
                      Image(
                        width: 35,
                        height: 35,
                        image: AssetImage('assets/NomaDev.png'),
                      ),
                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 20,right: 30),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 15),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40.0),
                            child: Image(
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                              image: AssetImage('assets/bgt.png'),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 15),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40.0),
                            child: Image(
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                              image: AssetImage('assets/bgt.png'),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 15),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40.0),
                            child: Image(
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                              image: AssetImage('assets/bgt.png'),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 15),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40.0),
                            child: Image(
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                              image: AssetImage('assets/bgt.png'),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 15),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40.0),
                            child: Image(
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                              image: AssetImage('assets/bgt.png'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 30),
            height: double.infinity,
            alignment: Alignment.bottomRight,
            //color: Colors.pink,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  //color: Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 24,
                        width: 24,
                        margin: EdgeInsets.only(right: 10),
                        child: GestureDetector(
                            onTap: () {
                              const url = 'https://instagram.com/atharian007';
                              if (canLaunch(url) != null) {
                                launch(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                            child: Image.asset(
                              'assets/igw.png',
                            )),
                      ),
                      Container(
                        height: 20,
                        margin: EdgeInsets.only(right: 10),
                        width: 20,
                        child: GestureDetector(
                            onTap: () {
                              const url =
                                  'https://wa.me/6285334103670?text=Halo';
                              if (canLaunch(url) != null) {
                                launch(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                            child: Image.asset(
                              'assets/waw.png',
                            )),
                      ),
                      Container(
                        height: 20,
                        width: 20,
                        child: GestureDetector(
                            onTap: () {
                              const url =
                                  'https://www.linkedin.com/in/muhammad-hafidz-288819180/';
                              if (canLaunch(url) != null) {
                                launch(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                            child: Image.asset(
                              'assets/in2.png',
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20, bottom: 20),
            height: double.infinity,
            alignment: Alignment.bottomCenter,
            //color: Colors.yellow,
          ),
        ],
      ),
    );
  }
}
