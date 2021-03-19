import 'package:crash_report/tampilan/register/registerPageAdmin.dart';
import 'package:crash_report/tampilan/register/registerPagePegawai.dart';
import 'package:flutter/cupertino.dart';
import 'registerPageTeknisi.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class daftarSebagai extends StatefulWidget {
  @override
  _daftarSebagaiState createState() => _daftarSebagaiState();
}

class _daftarSebagaiState extends State<daftarSebagai> {
  List<String> lst = ['Pegawai', 'Admin', 'Teknisi'];
  int selectedIndex = 0;
  int indexnavigate = 0;
  String textUser = 'Pegawai';
  String textBaca = 'pe.ga.wai';
  String textFitur = 'fitur';
  String textIsiFitur =
      '1. menambahkan list barang \n2. melakukan pelaporan kerusakan barang';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/background.png'),
                  fit: BoxFit.fill)),
        ),
        Center(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(left: 32, right: 32),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(17.5)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 40, left: 40, right: 40),
                    //color:Colors.red,
                    child: Text(
                      "Daftar sebagai :",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.openSans(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    //color: Colors.red,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        customRadio(lst[0], 0),
                        customRadio(lst[1], 1),
                        customRadio(lst[2], 2),
                      ],
                    ),
                  ),
                  Container(
                    //color: Colors.red,
                    margin: EdgeInsets.only(left: 45, top: 20, right: 45),
                    child: Text(
                      '$textUser',
                      style: GoogleFonts.openSans(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 45, right: 45),
                    child: Text(
                      '$textBaca',
                      style: GoogleFonts.openSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: Colors.black.withOpacity(0.5)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 45, right: 45),
                    child: Text(
                      '$textFitur',
                      style: GoogleFonts.openSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: Colors.black.withOpacity(0.5)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 45, right: 45),
                    child: Text(
                      '$textIsiFitur',
                      style: GoogleFonts.openSans(
                          fontSize: 10,
                          fontWeight: FontWeight.w300,
                          color: Colors.black.withOpacity(0.5)),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    margin: EdgeInsets.only(
                        left: 45, right: 45, bottom: 40, top: 24),
                    //color: Colors.red,
                    child: ButtonMulai(indexnavigate),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }

  void changeAll(int index) {
    changeIndex(index);
    changeText(index);
    GetIndex(index);
  }

  void changeIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void GetIndex(int index) {
    setState(() {
      selectedIndex = index;
      indexnavigate = index;
    });
  }

  void changeText(int index) {
    //print(index);
    setState(() {
      switch (index) {
        case 0:
          textUser = 'Pegawai';
          textBaca = 'pe.ga.wai';
          textFitur = 'fitur';
          textIsiFitur =
              '1. menambahkan list barang \n2. melakukan pelaporan kerusakan barang';
          break;
        case 1:
          textUser = 'Admin';
          textBaca = 'pe.ga.wai';
          textFitur = 'fitur';
          textIsiFitur =
              '1. menambahkan list barang \n2. melakukan pelaporan kerusakan barang';
          break;
        case 2:
          textUser = 'Teknisi';
          textBaca = 'pe.ga.wai';
          textFitur = 'fitur';
          textIsiFitur =
              '1. menambahkan list barang \n2. melakukan pelaporan kerusakan barang';
          break;
      }
    });
  }

  void NavigateUser(int nav) {
    setState(() {
      switch (nav) {
        case 0:
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => registerPagePegawai()));
          break;
        case 1:
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => registerPageAdmin()));
          break;
        case 2:
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => registerPageTeknisi()));
          break;
      }
    });
  }

  Widget ButtonMulai(int nav) {
    return RaisedButton(
      color: Color(0xFF031F4B),
      onPressed: () => NavigateUser(nav),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17.5)),
      padding: EdgeInsets.all(0),
      child: Container(
        width: double.infinity,
        child: Text(
          'Lanjut',
          textAlign: TextAlign.center,
          style: GoogleFonts.openSans(
              fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  Widget customRadio(String txt, int index) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 38, right: 38),
      child: RaisedButton(
        onPressed: () => changeAll(index),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: EdgeInsets.all(0),
        color: selectedIndex == index ? Color(0xFF031F4B) : Color(0xFFC3CEDA),
        child: Container(
          height: 60,
          width: double.infinity,
          margin: EdgeInsets.only(left: 20, right: 20),
          alignment: Alignment.centerLeft,
          child: Text(
            txt,
            style: GoogleFonts.openSans(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: selectedIndex == index
                    ? Colors.white
                    : Colors.black.withOpacity(0.2)),
          ),
        ),
      ),
    );
  }
}
