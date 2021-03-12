import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as Path;
import 'package:crash_report/tampilan/sideBar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:carousel_pro/carousel_pro.dart';

class mainMenuAdmin extends StatefulWidget {
  @override
  _mainMenuAdminState createState() => _mainMenuAdminState();
}

class _mainMenuAdminState extends State<mainMenuAdmin>
    with SingleTickerProviderStateMixin {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _namaAlatController,
      _lokasiController,
      _divisiController,
      _uploadedFileURL,
      _laporanController,
      _dateController,
      _timeController;
  TabController _tabController;
  ScrollController _scrollController;
  String valueDivisi;

  List divisi = ["Divisi 1", "Divisi 2", "Divisi 3"];

  Query _query;
  DatabaseReference _ref, _repref;
  String uid = '';
  String name = '';
  String role = '';
  File image;

  //
  String _error = 'No Error Dectected';
  bool isUploading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _scrollController = ScrollController();
    _namaAlatController = TextEditingController();
    _lokasiController = TextEditingController();
    _divisiController = TextEditingController();
    _laporanController = TextEditingController();
    _uploadedFileURL = TextEditingController();
    _dateController = TextEditingController();
    _timeController = TextEditingController();
    _ref = FirebaseDatabase.instance.reference().child('listBarang');
    _repref = FirebaseDatabase.instance.reference().child('listLaporan');
    _query = FirebaseDatabase.instance
        .reference()
        .child('listBarang')
        .orderByChild('divisi');
    _ambilPreference();
    _indogs();
  }

  Future<void> _indogs() async {
  await initializeDateFormatting('id_ID', null);
}

  //Buat gridViewGambar
  Widget buildGridView({Map image, String barangKey}) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: <Widget>[
          Image.network(
            image['URL'],
            width: 100,
            height: 100,
          ),
          Positioned(
            right: 5,
            top: 5,
            child: InkWell(
              child: Icon(
                Icons.remove_circle,
                size: 25,
                color: Colors.red,
              ),
              onTap: () {
                setState(() {
                  _ref.child(barangKey).child("image").child(image['key']).remove();
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  // DIALOG ADD BARANG
  Widget _showDialogPenambahan() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: SingleChildScrollView(
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
                              style: GoogleFonts.openSans(fontSize: 12),
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
                                  hintStyle: GoogleFonts.openSans(
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
                                  errorStyle: GoogleFonts.openSans(fontSize: 10)),
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
                              style: GoogleFonts.openSans(fontSize: 12),
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
                                  hintStyle: GoogleFonts.openSans(
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
                                  errorStyle: GoogleFonts.openSans(fontSize: 10)),
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
                          DropdownButtonFormField(
                            icon: Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                color: Color(0xFF000000).withOpacity(0.25),
                                size: 20,
                              ),
                            ),
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    borderSide: BorderSide(
                                        color:
                                            Color(0xFF000000).withOpacity(0.15))),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    borderSide:
                                        BorderSide(color: Color(0xFF031F4B))),
                                filled: false,
                                contentPadding:
                                    EdgeInsets.only(left: 24.0, right: 0),
                                hintStyle: GoogleFonts.openSans(
                                    fontSize: 12,
                                    color: Color(0xFF000000).withOpacity(0.25)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    borderSide: BorderSide(color: Colors.red)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    borderSide:
                                        BorderSide(color: Colors.red, width: 1)),
                                errorStyle: GoogleFonts.openSans(fontSize: 10)),
                            hint: Text(
                              "divisi",
                              style: GoogleFonts.openSans(
                                  fontSize: 12,
                                  color: Color(0xFF000000).withOpacity(.25)),
                            ),
                            value: valueDivisi,
                            onChanged: (newValue) {
                              setState(() {
                                valueDivisi = newValue;
                              });
                            },
                            validator: (value) {
                              if (valueDivisi == null) {
                                return "Divisi harus dipilih!";
                              }
                              return null;
                            },
                            items: divisi.map((valueItem) {
                              return DropdownMenuItem(
                                value: valueItem,
                                child: Text(
                                  valueItem,
                                  style: GoogleFonts.openSans(
                                      fontSize: 12, color: Color(0xFF000000)),
                                ),
                              );
                            }).toList(),
                          ),

                          SizedBox(height: 16),

                          // FlatButton(
                          //   color: Colors.grey,
                          //   shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(12),
                          //   ),
                          //   textColor: Colors.white,
                          //   child: Container(
                          //     height: 42.5,
                          //     alignment: Alignment.center,
                          //     child: Row(
                          //       children: <Widget>[
                          //         Icon(Icons.add_a_photo),
                          //         SizedBox(width: 10),
                          //         Text(
                          //           "Gambar/Foto",
                          //           style: GoogleFonts.openSans(
                          //               fontStyle: FontStyle.normal,
                          //               fontWeight: FontWeight.bold,
                          //               fontSize: 12.0),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          //   onPressed: () {
                          //     loadAssets();
                          //   },
                          // ),
                          //
                          // SizedBox(height: 16),

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
                          resetAndClose();
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
            ),
          );
        });
  }

  //LIST BARANG
  Widget _buildListBarang({Map barang, final theme}) {
    Color statusColor = getStatusColor(barang['status']);
    return Container(
      child: Container(
          margin: EdgeInsets.only(left: 16, right: 16, top: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                spreadRadius: 2,
                blurRadius: 6,
                offset: Offset(0, 0),
              )
            ],
            borderRadius: BorderRadius.circular(17.5),
          ),
          child: Stack(
            children: [

              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(right: 24, left: 24, top: 24),
                //color: Colors.cyan,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //posisi
                  mainAxisSize: MainAxisSize.min,
                  // untuk mengatur agar widget column mengikuti widget
                  children: <Widget>[
                    Text(
                      "Status",
                      style: GoogleFonts.openSans(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      barang['status'],
                      style: GoogleFonts.openSans(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: statusColor,
                      ),
                    ),
                  ],
                ),
              ),

              Theme(
                data: theme,
                child: ExpansionTile(
                  tilePadding: EdgeInsets.all(0),
                  childrenPadding: EdgeInsets.all(0),
                  trailing: Text(''),
                  title: Stack(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        //color: Colors.green,
                        margin: EdgeInsets.only(left: 24, top: 16, bottom: 16, right: 72),
                        child: Column(
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
                                color: Colors.black,
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
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 24, right: 24),
                      child: Column(
                        children: <Widget>[
                          Card(
                            child: IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                setState(() async {
                                  File imageFile;
                                  await ImagePicker.pickImage(source: ImageSource.gallery).then((img) {
                                    imageFile = img;
                                  });
                                  postImage(imageFile).then((downloadUrl) {
                                    Map<String, String> hashMap = {
                                      'URL' : downloadUrl.toString(),
                                    };
                                    _ref.child(barang['key']).child("image").push().set(hashMap).then((value){
                                      SnackBar snackbar = SnackBar(
                                          content: Text('Uploaded Successfully'));
                                      scaffoldKey.currentState.showSnackBar(snackbar);
                                    });
                                  });
                                });
                              },
                            ),
                          ),
                          Container(
                            height: 100,
                            //color: Colors.grey[200],
                            margin: EdgeInsets.only(bottom: 24.0),
                            child: FirebaseAnimatedList(
                                  query: _ref.child(barang['key']).child("image").orderByChild('URL'),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (BuildContext context,
                                      DataSnapshot snapshot,
                                      Animation<double> animation,
                                      int index) {
                                    Map image = snapshot.value;
                                    image['key'] = snapshot.key;
                                    return buildGridView(image: image ,barangKey: barang['key']);
                                  },
                            ),
                            // new Image.network(barang['imageURL']),
                          ),

                          Container(
                            width: double.infinity,
                            //color: Colors.green,
                            padding: EdgeInsets.all(0),
                            margin: EdgeInsets.only(bottom: 24),
                            alignment: Alignment.center,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  //color: Colors.pink,
                                  child: GestureDetector(
                                    onTap: () {
                                      _showDialogDelete(barang['key']);
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.grey[400],
                                      size: 32,
                                    ),
                                  ),
                                ),

                                Expanded(
                                  child: Container(
                                    //color: Colors.red,
                                    alignment: Alignment.centerRight,
                                    child: RaisedButton(
                                      color: Color(0xFF031F4B),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30)),
                                      textColor: Colors.white,
                                      child: Container(
                                        width: 85,
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Lapor",
                                          style: GoogleFonts.openSans(
                                            fontSize: 12,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        _showDialogLaporan(barang['key']);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  //DIALOG ADD LAPORAN
  Widget _showDialogLaporan(String barangKey) {
    getBarangDetail(barangKey: barangKey);

    DateTime now = DateTime.now();
    DateFormat format = new DateFormat("EEEE, d LLLL yyyy", "id_ID");
    String formattedDate = format.format(now);

    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              padding: EdgeInsets.all(24),
              child: SingleChildScrollView(
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          top: 16, bottom: 16, left: 8, right: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        //posisi
                        mainAxisSize: MainAxisSize.min,
                        // untuk mengatur agar widget column mengikuti widget
                        children: <Widget>[
                          Container(
                              child: Text(
                            "Laporkan Kerusakan",
                            style: GoogleFonts.openSans(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          )),

                          SizedBox(height: 16),

                          Center(
                            child: Text(
                              "--- Deskripsi Alat ---",
                              style: GoogleFonts.openSans(
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.black.withOpacity(0.25),
                              ),
                            ),
                          ),

                          SizedBox(height: 4),

                          Container(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                //posisi
                                mainAxisSize: MainAxisSize.min,
                                // untuk mengatur agar widget column mengikuti widget
                                children: <Widget>[
                                  Text(
                                    _namaAlatController.text,
                                    style: GoogleFonts.openSans(
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    _lokasiController.text,
                                    style: GoogleFonts.openSans(
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12,
                                        color: Colors.black.withOpacity(0.25)),
                                  ),
                                  Text(
                                    _divisiController.text,
                                    style: GoogleFonts.openSans(
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12,
                                    ),
                                  ),
                                ]),
                          ),

                          SizedBox(height: 16),

                          Center(
                            child: Text(
                              "--- Identitas Diri ---",
                              style: GoogleFonts.openSans(
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.black.withOpacity(0.25),
                              ),
                            ),
                          ),

                          SizedBox(height: 4),

                          Container(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                //posisi
                                mainAxisSize: MainAxisSize.min,
                                // untuk mengatur agar widget column mengikuti widget
                                children: <Widget>[
                                  Text(
                                    name,
                                    style: GoogleFonts.openSans(
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    role,
                                    style: GoogleFonts.openSans(
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12,
                                        color: Colors.black.withOpacity(0.5)),
                                  ),
                                ]),
                          ),

                          SizedBox(height: 16),

                          Center(
                            child: Text(
                              "--- Laporan ---",
                              style: GoogleFonts.openSans(
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.black.withOpacity(0.25),
                              ),
                            ),
                          ),

                          SizedBox(height: 4),

                          Container(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                //posisi
                                mainAxisSize: MainAxisSize.min,
                                // untuk mengatur agar widget column mengikuti widget
                                children: <Widget>[
                                  Text(
                                    _dateController.text =
                                        formattedDate,
                                    style: GoogleFonts.openSans(
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12,
                                    ),
                                  ),

                                  Text(_timeController.text =
                                  "${now.hour.toString()}:${now.minute.toString().padLeft(2, '0')}"
                                  ),
                                  
                                  //LAPORAN KERUSAKAN
                                  Container(
                                    child: TextFormField(
                                      cursorColor: Colors.black,
                                      style: GoogleFonts.openSans(fontSize: 12),
                                      maxLines: null,
                                      controller: _laporanController,
                                      decoration: new InputDecoration(
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8)),
                                              borderSide: BorderSide(
                                                  color: Color(0xFF000000)
                                                      .withOpacity(0.15))),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8)),
                                              borderSide: BorderSide(
                                                  color: Color(0xFF031F4B))),
                                          filled: false,
                                          contentPadding: EdgeInsets.only(
                                              left: 24.0, right: 24.0),
                                          hintStyle: GoogleFonts.openSans(
                                              fontSize: 12,
                                              color: Color(0xFF000000)
                                                  .withOpacity(0.15)),
                                          hintText: "Laporan Kerusakan",
                                          errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.all(Radius.circular(8)),
                                              borderSide: BorderSide(color: Colors.red)),
                                          focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)), borderSide: BorderSide(color: Colors.red, width: 1)),
                                          errorStyle: GoogleFonts.openSans(fontSize: 10)),
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
                                  Text(
                                    "Ini nanti dikasih gambar",
                                    style: GoogleFonts.openSans(
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12,
                                    ),
                                  ),
                                ]),
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
                                  "Lapor",
                                  style: GoogleFonts.openSans(
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                updateReport(barangKey: barangKey);
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
                          resetAndClose();
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
            ),
          );
        });
  }

  //DIALOG HAPUS BARANG
  Widget _showDialogDelete(String barangKey) {
    getBarangDetail(barangKey: barangKey);
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.black.withOpacity(0.75),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            child: Container(
              padding: EdgeInsets.all(24),
              child: SingleChildScrollView(
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding:
                      EdgeInsets.only(top: 16, bottom: 8, left: 8, right: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        //posisi
                        mainAxisSize: MainAxisSize.min,
                        // untuk mengatur agar widget column mengikuti widget
                        children: <Widget>[
                          Text(
                            "${_namaAlatController.text} akan dihapus secara permanen",
                            style: GoogleFonts.openSans(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),

                          SizedBox(height: 16),

                          Center(
                              child: Text(
                                "Apakah Kau Yakin ?",
                                style: GoogleFonts.openSans(
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              )),

                          SizedBox(height: 16),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              FlatButton(
                                color: Colors.grey[400],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                textColor: Colors.white,
                                child: Container(
                                  height: 42.5,
                                  width: 75,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Tidak",
                                    style: GoogleFonts.openSans(
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  resetAndClose();
                                },
                              ),
                              FlatButton(
                                color: Color(0xFF031F4B),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                textColor: Colors.white,
                                child: Container(
                                  height: 42.5,
                                  width: 75,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Ya",
                                    style: GoogleFonts.openSans(
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  hapusBarangLaporan(barangKey: barangKey);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  // // TAMBAH GAMBAR DOANG DARI GALLERY
  // Future<void> getImage() async {
  //   image.create();
  //   await ImagePicker.pickImage(source: ImageSource.gallery).then((img) {
  //     image = img;
  //   });
  // }

  // void uploadImages(String barangKey, List<Asset> images) {
  //   for (var imageFile in images) {
  //     postImage(imageFile).then((downloadUrl) {
  //       imageUrls.add(downloadUrl.toString());
  //       if (imageUrls.length == images.length) {
  //         Map<String, String> hashMap = {
  //           'imageUrl' : downloadUrl.toString(),
  //         };
  //         _ref.child(barangKey).child('image').set(hashMap).then((value) {
  //           SnackBar snackbar = SnackBar(
  //               content: Text('Uploaded Successfully'));
  //           scaffoldKey.currentState.showSnackBar(snackbar);
  //           setState(() {
  //             images = [];
  //             imageUrls = [];
  //           });
  //         });
  //       }
  //     }).catchError((err) {
  //       print(err);
  //     });
  //   }
  // }

  // Future<void> loadAssets() async {
  //   List<Asset> resultList = List<Asset>();
  //   String error = 'No Error Dectected';
  //   try {
  //     resultList = await MultiImagePicker.pickImages(
  //       maxImages: 3,
  //       enableCamera: true,
  //       selectedAssets: images,
  //       cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
  //       materialOptions: MaterialOptions(
  //         actionBarColor: "#abcdef",
  //         actionBarTitle: "Upload Image",
  //         allViewTitle: "All Photos",
  //         useDetailsView: false,
  //         selectCircleStrokeColor: "#000000",
  //       ),
  //     );
  //     print(resultList.length);
  //     print((await resultList[0].getThumbByteData(122, 100)));
  //     print((await resultList[0].getByteData()));
  //     print((await resultList[0].metadata));
  //
  //   } on Exception catch (e) {
  //     error = e.toString();
  //   }
  //
  //   // If the widget was removed from the tree while the asynchronous platform
  //   // message was in flight, we want to discard the reply rather than calling
  //   // setState to update our non-existent appearance.
  //   if (!mounted) return;
  //   setState(() {
  //     images = resultList;
  //     _error = error;
  //   });
  // }

  Future<dynamic> postImage(File imageFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference = FirebaseStorage.instance.ref().child('fotoBarang/$fileName');
    await reference.putFile(imageFile);
    // UploadTask uploadTask = reference.putData((await imageFile.getByteData()).buffer.asUint8List());
    return await reference.getDownloadURL();
  }

  // // UPLOAD GAMBAR KE DATABASE
  // Future<void> sendImage() async {
  //   Reference _storef = FirebaseStorage.instance
  //       .ref()
  //       .child('fotoBarang/${Path.basename(image.path)}');
  //   await _storef.putFile(image);
  //
  //   _uploadedFileURL.text = await _storef.getDownloadURL();
  // }

  // AMBIL SHARED PREFERENCES
  Future<void> _ambilPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      uid = preferences.getString('uid');
      name = preferences.getString('name');
      role = preferences.getString('role');
    });
  }

  // TAMPILAN
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      drawer: sideBar(),
      body: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(top: 16, left: 8, right: 8, bottom: 0),
            height: 256,
            width: double.infinity,
            color: Color(0xFF031F4B),

            // SELAMAT DATANG USER
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    scaffoldKey.currentState.openDrawer();
                  },
                ),
                Container(
                  margin: EdgeInsets.only(left: 24, right: 24, top: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Selamat Datang,",
                        style: GoogleFonts.openSans(
                            color: Color(0xFF949090),
                            fontWeight: FontWeight.w300,
                            fontSize: 16),
                      ),
                      Text(
                        name,
                        style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      Text(
                        role,
                        style: GoogleFonts.openSans(
                            color: Color(0xFFADABAB),
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.only(top: 164, bottom: 24, left: 24, right: 24),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  spreadRadius: 0,
                  blurRadius: 20,
                  offset: Offset(0, 0),
                )
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Column(
                children: [
                  Container(
                    height: 36,
                    child: TabBar(
                      controller: _tabController,
                      isScrollable: false,
                      labelPadding: EdgeInsets.all(0),
                      labelColor: Colors.black,
                      labelStyle: GoogleFonts.openSans(
                          fontWeight: FontWeight.bold, fontSize: 12),
                      unselectedLabelStyle: GoogleFonts.openSans(
                          fontWeight: FontWeight.w400, fontSize: 12),
                      unselectedLabelColor: Colors.black.withOpacity(0.5),
                      indicator: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                        ),
                      ),
                      tabs: <Widget>[
                        Tab(
                          text: "List Barang",
                        ),
                        Tab(
                          text: "Laporan",
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: new TabBarView(controller: _tabController,
                          //physics: NeverScrollableScrollPhysics(),
                          children: [
                            // TAB VIEW LIST BARANG
                            CupertinoScrollbar(
                              controller: _scrollController,
                              child: FirebaseAnimatedList(
                                query: _query,
                                itemBuilder: (BuildContext context,
                                    DataSnapshot snapshot,
                                    Animation<double> animation,
                                    int index) {
                                  Map barang = snapshot.value;
                                  barang['key'] = snapshot.key;
                                  return _buildListBarang(
                                      barang: barang, theme: theme);
                                },
                              ),
                            ),

                            // TAB VIEW LAPORAN
                            Center(
                                child: Text("Ini nanti ubah ke list laporan")),
                          ]),
                    ),
                  )
                ],
              ),
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

  getBarangDetail({String barangKey}) async {
    DataSnapshot snapshot = await _ref.child(barangKey).once();

    Map barang = snapshot.value;

    _namaAlatController.text = barang['nama'];
    _lokasiController.text = barang['letak'];
    _divisiController.text = barang['divisi'];
    _uploadedFileURL.text = barang['imageURL'];
  }

  saveBarang() {
    //SEND IMAGE KE DATABASE
    // sendImage();

    String namaAlat = _namaAlatController.text;
    String lokasi = _lokasiController.text;
    String divisi = valueDivisi;
    String status = 'Normal';
    // String URL = _uploadedFileURL.text;

    Map<String, String> barang = {
      'nama': namaAlat,
      'letak': lokasi,
      'divisi': divisi,
      'status': status,
      // 'imageURL': URL,
    };

    _ref.push().set(barang).then((value) {
      Navigator.pop(context);
      _namaAlatController.clear();
      _lokasiController.clear();
      _divisiController.clear();
      valueDivisi = null;
    });

    // if (URL != null) {
    //   _ref.push().set(barang).then((value) {
    //     Navigator.pop(context);
    //     _namaAlatController.clear();
    //     _lokasiController.clear();
    //     _divisiController.clear();
    //     valueDivisi = null;
    //     _uploadedFileURL.clear();
    //     image.delete();
    //   });

  }

  updateReport({String barangKey}) {
    String namaPelapor = name;
    String laporan = _laporanController.text;
    String status = 'Rusak';
    String date = _dateController.text;
    String time = _timeController.text;
    String namaAlat = _namaAlatController.text;

    Map<String, String> report = {
      'namaPelapor': namaPelapor,
      'nama': namaAlat,
      'laporan': laporan,
      'date': date,
      'time': time,
      'status': status,
    };

    Map<String, String> barang = {
      'status': status,
    };

    _repref.child(barangKey).set(report).then((value) {
      _namaAlatController.clear();
      _lokasiController.clear();
      _divisiController.clear();
      valueDivisi = null;
      _uploadedFileURL.clear();
    });

    _ref.child(barangKey).update(barang).then((value) {
      Navigator.pop(context);
      _laporanController.clear();
      _dateController.clear();
    });
  }

  resetAndClose(){
    _namaAlatController.clear();
    _lokasiController.clear();
    _divisiController.clear();
    valueDivisi = null;
    _uploadedFileURL.clear();
    _laporanController.clear();
    _dateController.clear();
    Navigator.pop(context);
  }

  hapusBarangLaporan({String barangKey}){
    if (_repref.child(barangKey) != null)
      _repref.child(barangKey).remove();
    _ref.child(barangKey).remove().whenComplete(() => resetAndClose());
  }

  Color getStatusColor(String status) {
    Color color = Theme.of(context).accentColor;

    if (status == 'Normal') {
      color = Color(0xFF628C57);
    }
    if (status == 'Rusak') {
      color = Color(0xFFFF6A6A);
    }
    if (status == 'Diperiksa') {
      color = Color(0xFFFFD54F);
    }
    return color;
  }
}
