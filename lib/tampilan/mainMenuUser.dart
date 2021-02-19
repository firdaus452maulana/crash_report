import 'package:flutter/material.dart';

enum DialogAction {save, close}

class addBarang{
  String namaAlat;
  String lokasi;
  String divisi;
}

class mainMenuUser extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          return showDialog(
              context: context,
            builder: (context) {
                return AlertDialog(

                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  title: Text(
                    "Tambah Barang",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  content: Column (
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    //posisi
                    mainAxisSize: MainAxisSize.min,
                    // untuk mengatur agar widget column mengikuti widget
                    children: <Widget>[

                      // NAMA ALAT
                      Container(
                        child: TextFormField(
                          cursorColor: Colors.black,
                          style: TextStyle(fontSize: 12),
                          keyboardType:
                          TextInputType.text,
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
                    ],
                  ),
                );
            });
        },
      ),
    );
  }
}
