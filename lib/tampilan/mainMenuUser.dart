import 'package:crash_report/tampilan/loginPage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

class mainMenuUser extends StatefulWidget {
  @override
  _mainMenuUserState createState() => _mainMenuUserState();
}

class _mainMenuUserState extends State<mainMenuUser> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _namaAlatController,
      _lokasiController,
      _divisiController;

  Query _query;
  DatabaseReference _ref;
  String uid, name, role;

  @override
  void initState() {
    super.initState();
    _namaAlatController = TextEditingController();
    _lokasiController = TextEditingController();
    _divisiController = TextEditingController();
    _ref = FirebaseDatabase.instance.reference().child('listBarang');
    _query = FirebaseDatabase.instance
        .reference()
        .child('listBarang')
        .orderByChild('nama');
    _ambilPreference();
  }

  // DIALOG ADD BARANG
  void _showDialogPenambahan() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              padding: EdgeInsets.all(24),
              child: Stack(
                children: <Widget>[
                  Container(
                    padding:
                        EdgeInsets.only(top: 16, bottom: 16, left: 8, right: 8),
                    child: Column(
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
                        )),

                        SizedBox(height: 16),

                        // NAMA ALAT
                        Container(
                          child: TextFormField(
                            cursorColor: Colors.black,
                            style: TextStyle(fontSize: 12),
                            keyboardType: TextInputType.text,
                            controller: _namaAlatController,
                            decoration: new InputDecoration(
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    borderSide: BorderSide(
                                        color: Color(0xFF000000)
                                            .withOpacity(0.15))),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    borderSide:
                                        BorderSide(color: Color(0xFF031F4B))),
                                filled: false,
                                contentPadding:
                                    EdgeInsets.only(left: 24.0, right: 24.0),
                                hintStyle: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF000000).withOpacity(0.15)),
                                hintText: "Nama Alat",
                                errorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    borderSide: BorderSide(color: Colors.red)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 1)),
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
                            keyboardType: TextInputType.text,
                            controller: _lokasiController,
                            decoration: new InputDecoration(
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    borderSide: BorderSide(
                                        color: Color(0xFF000000)
                                            .withOpacity(0.15))),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    borderSide:
                                        BorderSide(color: Color(0xFF031F4B))),
                                filled: false,
                                contentPadding:
                                    EdgeInsets.only(left: 24.0, right: 24.0),
                                hintStyle: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF000000).withOpacity(0.15)),
                                hintText: "Lokasi",
                                errorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    borderSide: BorderSide(color: Colors.red)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 1)),
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
                            keyboardType: TextInputType.text,
                            controller: _divisiController,
                            decoration: new InputDecoration(
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    borderSide: BorderSide(
                                        color: Color(0xFF000000)
                                            .withOpacity(0.15))),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    borderSide:
                                        BorderSide(color: Color(0xFF031F4B))),
                                filled: false,
                                contentPadding:
                                    EdgeInsets.only(left: 24.0, right: 24.0),
                                hintStyle: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF000000).withOpacity(0.15)),
                                hintText: "Divisi",
                                errorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    borderSide: BorderSide(color: Colors.red)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 1)),
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
                                borderRadius: BorderRadius.circular(30)),
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
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Align(
                        alignment: Alignment.topRight,
                        child: CircleAvatar(
                          radius: 14,
                          backgroundColor: Color(0xFF031F4B),
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
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

  Widget _buildListBarang({Map barang}) {
    Color statusColor = getStatusColor(barang['status']);
    return Container(
      //height: 150,
      color: Colors.white,
      child: Container(
        margin: EdgeInsets.only(bottom: 8, left: 16, right: 16),
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
        child: Padding(
          padding: const EdgeInsets.only(
              top: 12.0, bottom: 12.0, left: 24.0, right: 24.0),
          child: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                //posisi
                mainAxisSize: MainAxisSize.min,
                // untuk mengatur agar widget column mengikuti widget
                children: <Widget>[
                  Text(
                    barang['nama'],
                    style: GoogleFonts.openSans(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    barang['letak'],
                    style: GoogleFonts.openSans(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        color: Colors.black.withOpacity(0.25)),
                  ),
                  Text(
                    barang['divisi'],
                    style: GoogleFonts.openSans(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                //posisi
                mainAxisSize: MainAxisSize.min,
                // untuk mengatur agar widget column mengikuti widget
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Status",
                      style: GoogleFonts.openSans(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      barang['status'],
                      style: GoogleFonts.openSans(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: statusColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // AMBIL SHARED PREFERENCES
  Future<void> _ambilPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      uid = preferences.getString('uid');
      name = preferences.getString('name');
      role = preferences.getString('role');
    });
  }

  // NAVIGASI KE HALAMAN LOGIN
  _navLogOutSuccess() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => loginPage()),
      (route) => false,
    );
  }

  // FUNGSI SIGN OUT
  Future<void> _signOut(BuildContext context) async {
    await _auth.signOut().then((value) {
      _navLogOutSuccess();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(top: 64, left: 32, right: 32),
            height: 256,
            width: double.infinity,
            color: Color(0xFF031F4B),

            // SELAMAT DATANG USER
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Selamat Datang,",
                  style: TextStyle(
                      color: Color(0xFF949090),
                      fontWeight: FontWeight.w300,
                      fontSize: 16),
                ),
                Text(
                  name,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                Text(
                  role,
                  style: TextStyle(
                      color: Color(0xFFADABAB),
                      fontWeight: FontWeight.w600,
                      fontSize: 14),
                ),
              ],
            ),
          ),

          // LIST BARANG
          Container(
            margin: EdgeInsets.only(left: 24, right: 24, bottom: 24, top: 180),
            child: FirebaseAnimatedList(
              query: _query,
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                Map barang = snapshot.value;
                return _buildListBarang(barang: barang);
              },
            ),
          ),

          Container(
            alignment: Alignment.bottomCenter,
            child: RaisedButton(
              child: Text("Log Out"),
              onPressed: () async {
                SharedPreferences preference =
                    await SharedPreferences.getInstance();
                preference.clear();
                _signOut(context);
              },
            ),
          ),
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

    Map<String, String> barang = {
      'nama': namaAlat,
      'letak': lokasi,
      'divisi': divisi,
      'status': status,
    };

    _ref.push().set(barang).then((value) {
      Navigator.pop(context);
      _namaAlatController.clear();
      _lokasiController.clear();
      _divisiController.clear();
    });
  }

  Color getStatusColor(String status) {
    Color color = Theme.of(context).accentColor;

    if (status == 'Normal') {
      color = Color(0xFF628C57);
    }
    if (status == 'Rusak') {
      color = Color(0xFFFF6A6A);
    }
    return color;
  }
}
