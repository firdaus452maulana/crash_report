import 'package:crash_report/tampilan/registerPage.dart';
import '../tampilan/registerPageTeknisi.dart';
import 'package:flutter/material.dart';

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
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(24),
              margin: EdgeInsets.only(left: 32, right: 32),
              width: double.infinity,
              height: 500,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(17.5)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Pilih Bagian",
                    style: TextStyle(fontSize: 24),
                  ),

                  SizedBox(height: 24,),

                  // PILIH PEGAWAI
                  RaisedButton(
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
                              image: AssetImage('assets/background.png'),
                              colorFilter: new ColorFilter.mode(Colors.white.withOpacity(0.2), BlendMode.dstATop),
                              fit: BoxFit.fill)),
                      child: Text("Pegawai"),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  registerPage()));
                    },
                  ),

                  SizedBox(height: 16,),

                  // PILIH TEKNISI
                  RaisedButton(
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
                              image: AssetImage('assets/background.png'),
                              colorFilter: new ColorFilter.mode(Colors.white.withOpacity(0.2), BlendMode.dstATop),
                              fit: BoxFit.fill)),
                      child: Text("Teknisi"),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  registerPageTeknisi()));
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
