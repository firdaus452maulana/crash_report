import 'package:crash_report/tampilan/loginPage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';


class mainMenuUser extends StatefulWidget {
  @override
  _mainMenuUserState createState() => _mainMenuUserState();
}

class _mainMenuUserState extends State<mainMenuUser> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _namaAlatController, _lokasiController, _divisiController;

  DatabaseReference _ref;
  @override
  void initState() {
    super.initState();
    _namaAlatController = TextEditingController();
    _lokasiController = TextEditingController();
    _divisiController = TextEditingController();
    _ref = FirebaseDatabase.instance.reference().child('listBarang');
  }

  void _showDialogPenambahan(){
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
            ),
            child: Container(
              padding: EdgeInsets.all(24),
              child: Stack(
                children: <Widget> [
                  Container(
                    padding: EdgeInsets.only(top: 16, bottom: 16, left: 8, right: 8),
                    child: Column (
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      //posisi
                      mainAxisSize: MainAxisSize.min,
                      // untuk mengatur agar widget column mengikuti widget
                      children: <Widget>[

                        Container(
                            child: Text(
                              "Tambah Barang",
                              style: GoogleFonts.openSans(
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            )
                        ),

                        SizedBox(height: 16),

                        // NAMA ALAT
                        Container(
                          child: TextFormField(
                            cursorColor: Colors.black,
                            style: TextStyle(fontSize: 12),
                            keyboardType:
                            TextInputType.text,
                            controller: _namaAlatController,
                            decoration: new InputDecoration(
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(30)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(30)),
                                    borderSide: BorderSide(
                                        color: Color(0xFF000000)
                                            .withOpacity(0.15))),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(30)),
                                    borderSide: BorderSide(
                                        color: Color(0xFF031F4B))),
                                filled: false,
                                contentPadding: EdgeInsets.only(
                                    left: 24.0, right: 24.0),
                                hintStyle: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF000000)
                                        .withOpacity(0.15)),
                                hintText: "Nama Alat",
                                errorBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                    borderSide: BorderSide(color: Colors.red)),
                                focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30)), borderSide: BorderSide(color: Colors.red, width: 1)),
                                errorStyle: TextStyle(fontSize: 10)),
                            obscureText: false,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Field is required";
                              }
                              return null;
                            },
                            onSaved: (value) {},
                          ),
                        ),

                        SizedBox(height: 16),

                        // LOKASI
                        Container(
                          child: TextFormField(
                            cursorColor: Colors.black,
                            style: TextStyle(fontSize: 12),
                            keyboardType:
                            TextInputType.text,
                            controller: _lokasiController,
                            decoration: new InputDecoration(
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(30)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(30)),
                                    borderSide: BorderSide(
                                        color: Color(0xFF000000)
                                            .withOpacity(0.15))),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(30)),
                                    borderSide: BorderSide(
                                        color: Color(0xFF031F4B))),
                                filled: false,
                                contentPadding: EdgeInsets.only(
                                    left: 24.0, right: 24.0),
                                hintStyle: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF000000)
                                        .withOpacity(0.15)),
                                hintText: "Lokasi",
                                errorBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                    borderSide: BorderSide(color: Colors.red)),
                                focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30)), borderSide: BorderSide(color: Colors.red, width: 1)),
                                errorStyle: TextStyle(fontSize: 10)),
                            obscureText: false,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Field is required";
                              }
                              return null;
                            },
                            onSaved: (value) {},
                          ),
                        ),

                        SizedBox(height: 16),

                        // DIVISI
                        Container(
                          child: TextFormField(
                            cursorColor: Colors.black,
                            style: TextStyle(fontSize: 12),
                            keyboardType:
                            TextInputType.text,
                            controller: _divisiController,
                            decoration: new InputDecoration(
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(30)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(30)),
                                    borderSide: BorderSide(
                                        color: Color(0xFF000000)
                                            .withOpacity(0.15))),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(30)),
                                    borderSide: BorderSide(
                                        color: Color(0xFF031F4B))),
                                filled: false,
                                contentPadding: EdgeInsets.only(
                                    left: 24.0, right: 24.0),
                                hintStyle: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF000000)
                                        .withOpacity(0.15)),
                                hintText: "Divisi",
                                errorBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                    borderSide: BorderSide(color: Colors.red)),
                                focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30)), borderSide: BorderSide(color: Colors.red, width: 1)),
                                errorStyle: TextStyle(fontSize: 10)),
                            obscureText: false,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Field is required";
                              }
                              return null;
                            },
                            onSaved: (value) {},
                          ),
                        ),

                        SizedBox(height: 16),

                        //Button
                        Align(
                          alignment: Alignment.centerRight,
                          child: RaisedButton(
                            color: Color(0xFF031F4B),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(30)),
                            textColor: Colors.white,
                            child: Container(
                              height: 42.5,
                              width: 85,
                              alignment: Alignment.center,
                              child: Text(
                                "Save",
                                style: GoogleFonts.openSans(
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            onPressed: () {
                              saveBarang();
                            },
                          ),
                        ),

                      ],
                    ),
                  ),
                  //Icon Close
                  Positioned(
                    right: 0.0,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Align(
                        alignment: Alignment.topRight,
                        child: CircleAvatar(
                          radius: 14,
                          backgroundColor: Color(0xFF031F4B),
                          child: Icon(Icons.close, color: Colors.white,),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> _signOut(BuildContext context) async {
    await _auth.signOut().then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => loginPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          RaisedButton(
            onPressed: () async {
              SharedPreferences preference = await SharedPreferences.getInstance();
              preference.remove('email');
              _signOut(context);
            },
          )
        ],
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF031F4B),
        onPressed: () {
          _showDialogPenambahan();
        },
      ),
    );
  }

  void saveBarang() {

    String namaAlat = _namaAlatController.text;
    String lokasi = _lokasiController.text;
    String divisi = _divisiController.text;
    String status = 'Normal';

    Map<String,String> barang = {
      'nama':namaAlat,
      'letak':lokasi,
      'divisi':divisi,
      'status':status,
    };


    _ref.push().set(barang).then((value) {
      Navigator.pop(context);
      _namaAlatController.clear();
      _lokasiController.clear();
      _divisiController.clear();
    });
  }
}

