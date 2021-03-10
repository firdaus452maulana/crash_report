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
          Center(
            child: SingleChildScrollView(
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(32),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(17.5)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: 24, left: 32, right: 32, bottom: 32),
                      child: Text(
                        "Pilih Bagian",
                        style: GoogleFonts.openSans(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),

                    // PILIH PEGAWAI
                    Container(
                      margin: EdgeInsets.only(
                          top: 0, left: 32, right: 32, bottom: 32),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17.5)),
                        color: Colors.white,
                        padding: EdgeInsets.all(0),
                        child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          height: 144,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(17.5),
                              image: DecorationImage(
                                  image: AssetImage('assets/pegawai.jpg'),
                                  colorFilter: new ColorFilter.mode(
                                      Colors.white.withOpacity(0.2),
                                      BlendMode.dstATop),
                                  fit: BoxFit.fill)),
                          child: Text(
                            "Pegawai",
                            style: GoogleFonts.openSans(
                                fontSize: 12, fontWeight: FontWeight.bold),
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
                          top: 0, left: 32, right: 32, bottom: 32),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17.5)),
                        color: Colors.white,
                        padding: EdgeInsets.all(0),
                        child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          height: 144,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(17.5),
                              image: DecorationImage(
                                  image: AssetImage('assets/pegawai.jpg'),
                                  colorFilter: new ColorFilter.mode(
                                      Colors.white.withOpacity(0.2),
                                      BlendMode.dstATop),
                                  fit: BoxFit.fill)),
                          child: Text(
                            "Admin",
                            style: GoogleFonts.openSans(
                                fontSize: 12, fontWeight: FontWeight.bold),
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
                          top: 0, left: 32, right: 32, bottom: 32),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17.5)),
                        color: Colors.white,
                        padding: EdgeInsets.all(0),
                        child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          height: 144,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(17.5),
                              image: DecorationImage(
                                  image: AssetImage('assets/teknisi.jpeg'),
                                  colorFilter: new ColorFilter.mode(
                                      Colors.white.withOpacity(0.2),
                                      BlendMode.dstATop),
                                  fit: BoxFit.fill)),
                          child: Text(
                            "Teknisi",
                            style: GoogleFonts.openSans(
                                fontSize: 12, fontWeight: FontWeight.bold),
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
            ),
          )
        ],
      ),
    );
  }
}
