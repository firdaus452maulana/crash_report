import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:crash_report/tampilan/sideBar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../historyLaporan.dart';

class mainMenuAdmin extends StatefulWidget {
  @override
  _mainMenuAdminState createState() => _mainMenuAdminState();
}

class _mainMenuAdminState extends State<mainMenuAdmin>
    with SingleTickerProviderStateMixin {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _namaAlatController,
      _lokasiController,
      _divisiController,
      _laporanController,
      _dateController,
      _timeController;
  TabController _tabController;
  ScrollController _scrollController;
  String valueDivisi, _filterSelected;

  List divisi = ["ATC", "ARO", "PIA"];

  Query _query, _queryLaporan;
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
    _tabController = TabController(vsync: this, length: 3);
    _scrollController = ScrollController();
    _namaAlatController = TextEditingController();
    _lokasiController = TextEditingController();
    _divisiController = TextEditingController();
    _laporanController = TextEditingController();
    _dateController = TextEditingController();
    _timeController = TextEditingController();
    _ref = FirebaseDatabase.instance.reference().child('listBarang');
    _repref = FirebaseDatabase.instance.reference().child('listLaporan');
    _query = FirebaseDatabase.instance
        .reference()
        .child('listBarang')
        .orderByChild('nama');
    _queryLaporan = FirebaseDatabase.instance
        .reference()
        .child('listLaporan')
        .orderByChild('nama');
    _ambilPreference();
    _indogs();
  }

  Future<void> _indogs() async {
    await initializeDateFormatting('id_ID', null);
  }

  //Buat gridViewGambar
  Widget buildGridView({Map image, String barangKey}) {
    return Card(
      //color: Colors.blue,
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
                  _ref
                      .child(barangKey)
                      .child("image")
                      .child(image['key'])
                      .remove();
                  FirebaseStorage.instance.refFromURL(image['URL']).delete();

                });
                checkImage(barangKey: barangKey);
              },
            ),
          ),
        ],
      ),
    );
  }

  //LIST BARANG
  Widget _buildListBarang({Map barang, final theme}) {
    Color statusColor = getStatusColor(barang['status']);
    if (_ref.onValue == null){
      return Text("KOSONG");
    } else {
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
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    margin: EdgeInsets.only(right: 24, left: 24, top: 24),
                    width: 72,
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
                          margin: EdgeInsets.only(
                              left: 24, top: 16, bottom: 16, right: 72),
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
                                    await ImagePicker.pickImage(
                                        source: ImageSource.gallery)
                                        .then((img) {
                                      imageFile = img;
                                    });
                                    postImage(imageFile).then((downloadUrl) {
                                      Map<String, String> hashMap = {
                                        'URL': downloadUrl.toString(),
                                      };
                                      _ref
                                          .child(barang['key'])
                                          .child("image")
                                          .push()
                                          .set(hashMap)
                                          .then((value) {
                                        SnackBar snackbar = SnackBar(
                                            content:
                                            Text('Uploaded Successfully'));
                                        scaffoldKey.currentState
                                            .showSnackBar(snackbar);
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
                                query: _ref
                                    .child(barang['key'])
                                    .child("image")
                                    .orderByChild('URL'),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context,
                                    DataSnapshot snapshot,
                                    Animation<double> animation,
                                    int index) {
                                  Map image = snapshot.value;
                                  image['key'] = snapshot.key;
                                  return buildGridView(
                                      image: image, barangKey: barang['key']);
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

                                  SizedBox(width: 12,),

                                  Container(
                                    //color: Colors.pink,
                                    child: GestureDetector(
                                      onTap: () {
                                        _showDialogEdit(barang['key']);
                                      },
                                      child: Icon(
                                        Icons.edit,
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
                                            borderRadius:
                                            BorderRadius.circular(30)),
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

  }

  //LIST LAPORAN
  Widget _buildListLaporan({Map laporan, final theme}) {
    Color notifikasiColor = getStatusColor(laporan['status']);
    return Container(
      child: Container(
          margin: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
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
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                    height: 16,
                    width: 16,
                    margin: EdgeInsets.only(right: 24, left: 24, top: 32),
                    padding: EdgeInsets.only(right: 24, left: 24, top: 24),
                    decoration: BoxDecoration(
                      color: notifikasiColor,
                      borderRadius: BorderRadius.circular(2.5),
                    )),
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
                        margin: EdgeInsets.only(
                            left: 24, top: 16, bottom: 16, right: 72),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          //posisi
                          mainAxisSize: MainAxisSize.min,
                          // untuk mengatur agar widget column mengikuti widget
                          children: <Widget>[
                            Text(
                              laporan['nama'],
                              style: GoogleFonts.openSans(
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              laporan['date'],
                              style: GoogleFonts.openSans(
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12,
                                  color: Colors.black.withOpacity(0.25)),
                            ),
                            Text(
                              laporan['time'],
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
                    Container(
                      width: double.infinity,
                      //color: Colors.cyan,
                      margin: EdgeInsets.only(left: 24, bottom: 8, right: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Pelapor',
                            style: GoogleFonts.openSans(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            laporan['namaPelapor'],
                            style: GoogleFonts.openSans(
                                fontWeight: FontWeight.w300,
                                fontSize: 12,
                                color: Colors.black.withOpacity(0.25)),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Catatan Kerusakan',
                            style: GoogleFonts.openSans(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            laporan['laporan'],
                            style: GoogleFonts.openSans(
                                fontWeight: FontWeight.w300,
                                fontSize: 12,
                                color: Colors.black.withOpacity(0.25)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }

  //FILTER
  Widget _buildFilterType(String title){
    return InkWell(
      child: Container(
        height: 40,
        width: 90,
        decoration: BoxDecoration(
          color: _filterSelected == title ? Color(0xFF031F4B) : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Color(0xFF031F4B)),
        ),
        child: Center(
          child: Text(
            title,
            style: GoogleFonts.openSans(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.normal,
                    fontSize: 18,
            )),),
      ),
      onTap: () async {
        setState(() {
          _filterSelected = title;
        });
        if (_filterSelected == "Semua"){
          _query = FirebaseDatabase.instance
              .reference()
              .child('listBarang')
              .orderByChild('nama');
        } else {
          _query = FirebaseDatabase.instance
              .reference()
              .child('listBarang')
              .orderByChild('divisi')
              .equalTo(_filterSelected);
        }
      },
    );
  }

  // DIALOG ADD BARANG
  Widget _showDialogPenambahan() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(24),
                child: Stack(
                  children: <Widget>[
                    Form(
                      key: _formKey,
                      child: Container(
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
                                        color:
                                        Color(0xFF000000).withOpacity(0.15)),
                                    hintText: "Nama Alat",
                                    errorBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                        borderSide:
                                        BorderSide(color: Colors.red)),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                        borderSide: BorderSide(
                                            color: Colors.red, width: 1)),
                                    errorStyle:
                                    GoogleFonts.openSans(fontSize: 10)),
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
                                        color:
                                        Color(0xFF000000).withOpacity(0.15)),
                                    hintText: "Lokasi",
                                    errorBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                        borderSide:
                                        BorderSide(color: Colors.red)),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                        borderSide: BorderSide(
                                            color: Colors.red, width: 1)),
                                    errorStyle:
                                    GoogleFonts.openSans(fontSize: 10)),
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
                                          color: Color(0xFF000000)
                                              .withOpacity(0.15))),
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
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 1)),
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
                    ),
                    //Icon Close
                    Positioned(
                      right: 0.0,
                      child: GestureDetector(
                        onTap: () {
                          justReset();
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
            ),
          );
        });
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
                                    _dateController.text = formattedDate,
                                    style: GoogleFonts.openSans(
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12,
                                    ),
                                  ),

                                  Text(_timeController.text =
                                      "${now.hour.toString()}:${now.minute.toString().padLeft(2, '0')}"),

                                  //LAPORAN KERUSAKAN
                                  Container(
                                    child: Form(
                                      key: _formKey,
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
                          justReset();
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
                      padding: EdgeInsets.only(
                          top: 16, bottom: 8, left: 8, right: 8),
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
                                  justReset();
                                  Navigator.pop(context);
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

  //DIALOG EDIT BARANG
  Widget _showDialogEdit(String barangKey) {
    getBarangDetail(barangKey: barangKey);

    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(24),
                child: Stack(
                  children: <Widget>[
                    Form(
                      key: _formKey,
                      child: Container(
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
                                  "Edit Barang",
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
                                        color:
                                        Color(0xFF000000).withOpacity(0.15)),
                                    hintText: "Nama Alat",
                                    errorBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                        borderSide:
                                        BorderSide(color: Colors.red)),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                        borderSide: BorderSide(
                                            color: Colors.red, width: 1)),
                                    errorStyle:
                                    GoogleFonts.openSans(fontSize: 10)),
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
                                        color:
                                        Color(0xFF000000).withOpacity(0.15)),
                                    hintText: "Lokasi",
                                    errorBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                        borderSide:
                                        BorderSide(color: Colors.red)),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                        borderSide: BorderSide(
                                            color: Colors.red, width: 1)),
                                    errorStyle:
                                    GoogleFonts.openSans(fontSize: 10)),
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
                                          color: Color(0xFF000000)
                                              .withOpacity(0.15))),
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
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 1)),
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
                                  updateBarang(barangKey);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //Icon Close
                    Positioned(
                      right: 0.0,
                      child: GestureDetector(
                        onTap: () {
                          justReset();
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
            ),
          );
        });
  }

  Future<dynamic> postImage(File imageFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference =
        FirebaseStorage.instance.ref().child('fotoBarang/$fileName');
    await reference.putFile(imageFile);
    // UploadTask uploadTask = reference.putData((await imageFile.getByteData()).buffer.asUint8List());
    return await reference.getDownloadURL();
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
          ),

          // SELAMAT DATANG USER
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Container(
                      //color: Colors.red,
                      margin: EdgeInsets.only(left: 20, top: 36),
                      child: GestureDetector(
                          onTap: () {
                            scaffoldKey.currentState.openDrawer();
                          },
                          child: Icon(
                            Icons.menu,
                            color: Colors.white,
                          ))),
                  Expanded(
                    child: Container(
                        alignment: Alignment.centerRight,
                        //color: Colors.green,
                        margin: EdgeInsets.only(right: 20, top: 36),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => historyLaporan()));
                            },
                            child: Icon(
                              Icons.history,
                              color: Colors.white,
                            ))),
                  ),
                ],
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
                          text: "Komplain",
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
                            Column(
                              children: [
                                Container(
                                  height: 40,
                                  child: ListView (
                                    scrollDirection: Axis.horizontal,
                                    children: [ 
                                      _buildFilterType('Semua'),
                                      SizedBox(width: 8),
                                      _buildFilterType('ATC'),
                                      SizedBox(width: 8),
                                      _buildFilterType('ARO'),
                                      SizedBox(width: 8),
                                      _buildFilterType('PIA'),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: CupertinoScrollbar(
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
                                ),
                              ],
                            ),

                            // TAB VIEW KOMPLAIN
                            Center(
                                child: Text("Ini nanti ubah ke list KOMPLAIN")),

                            // TAB VIEW LAPORAN
                            CupertinoScrollbar(
                              controller: _scrollController,
                              child: FirebaseAnimatedList(
                                query: _queryLaporan,
                                itemBuilder: (BuildContext context,
                                    DataSnapshot snapshot,
                                    Animation<double> animation,
                                    int index) {
                                  Map laporan = snapshot.value;
                                  laporan['key'] = snapshot.key;
                                  return _buildListLaporan(
                                      laporan: laporan, theme: theme);
                                },
                              ),
                            ),
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
          justReset();
          _showDialogPenambahan();
        },
      ),
    );
  }

  checkImage({String barangKey}) async {
    DataSnapshot snapshot = await _ref.child(barangKey).once();

    Map barang = snapshot.value;

    if (barang['image'] == null)
      {
        _ref.child(barangKey).update({'image' : ""});
      }
  }

  getBarangDetail({String barangKey}) async {
    DataSnapshot snapshot = await _ref.child(barangKey).once();

    Map barang = snapshot.value;

    _namaAlatController.text = barang['nama'];
    _lokasiController.text = barang['letak'];
    _divisiController.text = barang['divisi'];
    valueDivisi = _divisiController.text;
  }

  saveBarang() {

    String namaAlat = _namaAlatController.text;
    String lokasi = _lokasiController.text;
    String divisi = valueDivisi;
    String status = 'Normal';

    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    Map<String, String> barang = {
      'nama': namaAlat,
      'letak': lokasi,
      'divisi': divisi,
      'status': status,
      'image' : "",
    };

    _ref.push().set(barang).then((value) {
      justReset();
      Navigator.pop(context);
    });
  }

  updateBarang(String barangKey) {

    String namaAlat = _namaAlatController.text;
    String lokasi = _lokasiController.text;
    String divisi = valueDivisi;

    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    Map<String, String> barang = {
      'nama': namaAlat,
      'letak': lokasi,
      'divisi': divisi,
    };

    _ref.child(barangKey).update(barang).then((value) {
      justReset();
      Navigator.pop(context);
    });
  }

  updateReport({String barangKey}) {
    String namaPelapor = name;
    String laporan = _laporanController.text;
    String status = 'Rusak';
    String date = _dateController.text;
    String time = _timeController.text;
    String namaAlat = _namaAlatController.text;

    // BUAT VALIDASI FORMFIELD
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    Map<String, String> report = {
      'namaPelapor': namaPelapor,
      'nama': namaAlat,
      'laporan': laporan,
      'date': date,
      'time': time,
      'status': status,
      'kerjakan': 'false',
    };

    Map<String, String> barang = {
      'status': status,
    };

    _repref.child(barangKey).set(report).then((value) {
      _namaAlatController.clear();
      _lokasiController.clear();
      _divisiController.clear();
      valueDivisi = null;
    });

    _ref.child(barangKey).update(barang).then((value) {
      justReset();
      Navigator.pop(context);
    });
  }

  justReset() {
    _namaAlatController.clear();
    _lokasiController.clear();
    _divisiController.clear();
    valueDivisi = null;
    _laporanController.clear();
    _dateController.clear();
  }

  hapusBarangLaporan({String barangKey}) {
    if (_repref.child(barangKey) != null) _repref.child(barangKey).remove();
    _ref.child(barangKey).remove().whenComplete(() {
      justReset();
      Navigator.pop(context);
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
    if (status == 'Diperiksa') {
      color = Color(0xFFFFD54F);
    }
    return color;
  }
}
