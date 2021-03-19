import 'package:crash_report/tampilan/register/registerPageAdmin.dart';
import 'package:crash_report/tampilan/register/registerPagePegawai.dart';
import 'package:flutter/cupertino.dart';
import 'registerPageTeknisi.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class pilihBagianPage extends StatefulWidget {
  @override
  _pilihBagianPageState createState() => _pilihBagianPageState();
}

class _pilihBagianPageState extends State<pilihBagianPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/background.png'),
                    fit: BoxFit.fill)),
          ),
         Container(
                margin: EdgeInsets.only(left: 32,top:100,right:32,bottom:100),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(17.5)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: 44, left: 32, right: 32, bottom: 32),
                      child: Text(
                        "Pilih Bagian",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.openSans(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),

                    // PILIH PEGAWAI
                    Container(
                      margin: EdgeInsets.only(
                          top: 0, left: 32, right: 32, bottom: 15),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17.5)),
                        color: Colors.white,
                        padding: EdgeInsets.all(0),
                        child: Container(
                          width: double.infinity,
                          height: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(17.5),
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [Color(0xFF031F4B),Color(0xFF031F4B).withOpacity(0.5)]
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 20,left: 20),
                                child: Text(
                                  "Pegawai",
                                  style: GoogleFonts.openSans(
                                      fontSize: 24, fontWeight: FontWeight.bold,color: Colors.white),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 20),
                                child: Text(
                                  "fitur pada user pegawai apa aja",
                                  style: GoogleFonts.openSans(
                                      fontSize: 10, fontWeight: FontWeight.w100,color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => registerPagePegawai()));
                        },
                      ),
                    ),

                    // PILIH ADMIN
                    Container(
                      margin: EdgeInsets.only(
                          top: 0, left: 32, right: 32, bottom: 15),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17.5)),
                        color: Colors.white,
                        padding: EdgeInsets.all(0),
                        child: Container(
                          width: double.infinity,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(17.5),
                            gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [Color(0xFF0C4160),Color(0xFF0C4160).withOpacity(0.5)]
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 20,left: 20),
                                child: Text(
                                  "Admin",
                                  style: GoogleFonts.openSans(
                                      fontSize: 24, fontWeight: FontWeight.bold,color: Colors.white),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 20),
                                child: Text(
                                  "fitur pada user admin apa aja",
                                  style: GoogleFonts.openSans(
                                      fontSize: 10, fontWeight: FontWeight.w100,color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => registerPageAdmin()));
                        },
                      ),
                    ),

                    // PILIH TEKNISI
                    Container(
                      margin: EdgeInsets.only(
                          top: 0, left: 32, right: 32, bottom: 50),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17.5)),
                        color: Colors.white,
                        padding: EdgeInsets.all(0),
                        child: Container(
                          width: double.infinity,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(17.5),
                            gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [Color(0xFF738FA7),Color(0xFF738FA7).withOpacity(0.5)]
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 20,left: 20),
                                child: Text(
                                  "Teknisi",
                                  style: GoogleFonts.openSans(
                                      fontSize: 24, fontWeight: FontWeight.bold,color: Colors.white),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 20),
                                child: Text(
                                  "fitur pada user teknisi apa aja",
                                  style: GoogleFonts.openSans(
                                      fontSize: 10, fontWeight: FontWeight.w100,color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      registerPageTeknisi()));
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
