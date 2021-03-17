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
                    'Sistem Informasi Pelaporan Peralatan (SIAP) merupakan aplikasi yang memudahkan pengguna untuk melaporkan kerusakan peralatan atau inventaris. SIAP menciptakan komunikasi yang efektif antar user sebagai pemilik barang atau inventaris dengan teknisi untuk melakukan pemeliharaan. SIAP merupakan aplikasi yang dibuat tim pengembang NomaDev dan bekerja sama dengan AirNav Indonesia serta Politeknik ELektronika Negeri Surabaya',
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
                    ],
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
                  margin:EdgeInsets.only(bottom: 10),
                  child: Text(
                   'connect with us',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontWeight: FontWeight.w100,
                          fontSize: 10),
                    ),
                  ),
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
        ],
      ),
    );
  }
}
