import 'dart:io';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:crash_report/tampilan/sideBar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class mainMenuPegawai extends StatefulWidget {
  @override
  _mainMenuPegawaiState createState() => _mainMenuPegawaiState();
}

class _mainMenuPegawaiState extends State<mainMenuPegawai>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollController;
  String valueStatus;

  TextEditingController _laporanController;

  String valueDivisi;

  List divisi = ["Divisi 1", "Divisi 2", "Divisi 3"];

  Query _queryBarang, _queryKomplain;
  DatabaseReference _ref, _compref, _comprefAdmin;
  String uid = '';
  String name = '';
  String role = '';
  File image;
  String valueKomplainStr;
  String komplainNoteKey;
  Map<dynamic, dynamic> isiBarang, isiKomplain, isiKomplainAdmin;
  String isiBarangStr, isiKomplainStr, isiKomplainAdminStr;

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _scrollController = ScrollController();
    _queryBarang = FirebaseDatabase.instance
        .reference()
        .child('listBarang')
        .orderByChild('nama');
    _queryKomplain =
        FirebaseDatabase.instance.reference().child('listKomplain');
    _ref = FirebaseDatabase.instance.reference().child('listBarang');
    _compref =
        FirebaseDatabase.instance.reference().child('listKomplainPegawai');
    _comprefAdmin =
        FirebaseDatabase.instance.reference().child('listKomplainAdmin');
    _ambilPreference();
    _indogs();
    _cekIsiBarang();
    _cekIsiKomplain();
  }

  Future<void> _indogs() async {
    await initializeDateFormatting('id_ID', null);
  }

  _cekIsiKomplainAdmin({String barangKey}) async {
    DataSnapshot snapshotKomplain = await _comprefAdmin.child(barangKey).once();
    Map isiKomplain = snapshotKomplain.value;
    isiKomplainStr = isiKomplain.toString();
    print("isiKomplainAdmin: " + isiKomplain.toString());
  }

  _cekIsiKomplain() {
    _compref.child(uid).once().then((value) {
      isiKomplain = value.value;
      isiKomplainStr = isiKomplain.toString();
      print("isi komplain: " + isiKomplainStr.toString());
      if (isiKomplain == null) {
        FirebaseDatabase.instance
            .reference()
            .child('trigger')
            .child('adaKomplainPegawai')
            .update({uid: 'false'});
      } else {
        FirebaseDatabase.instance
            .reference()
            .child('trigger')
            .child('adaKomplainPegawai')
            .update({uid: 'true'});
      }
    });
  }

  _cekIsiBarang() {
    _ref.once().then((value) {
      isiBarang = value.value;
      isiBarangStr = isiBarang.toString();
      print("isi barang: " + isiBarangStr.toString());
      if (isiBarang == null) {
        FirebaseDatabase.instance
            .reference()
            .child('trigger')
            .update({'adaBarang': 'false'});
      } else {
        FirebaseDatabase.instance
            .reference()
            .child('trigger')
            .update({'adaBarang': 'true'});
      }
    });
  }

  //BUILD VIEW IMAGE
  Widget _viewImage(String barangKey) {
    List<NetworkImage> _listOfImages = <NetworkImage>[];
    return StreamBuilder(
        stream: _ref.child(barangKey).child('image').onValue,
        builder: (context, AsyncSnapshot<Event> snapshot) {
          if (snapshot.hasData) {
            _listOfImages.clear();
            DataSnapshot dataValues = snapshot.data.snapshot;
            Map<dynamic, dynamic> values = dataValues.value;
            values.forEach((key, values) {
              _listOfImages.add(NetworkImage(values['URL']));
            });
            return Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(10.0),
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Carousel(
                      boxFit: BoxFit.cover,
                      images: _listOfImages,
                      autoplay: false,
                      indicatorBgPadding: 3.0,
                      dotPosition: DotPosition.bottomCenter,
                      dotSize: 5.0,
                      dotSpacing: 16.0,
                      animationCurve: Curves.fastOutSlowIn,
                      animationDuration: Duration(milliseconds: 2000)),
                ),
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  // LIST BARANG
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
                padding: EdgeInsets.only(right: 24, left: 24, top: 24),
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
                        margin: EdgeInsets.only(
                            left: 24, top: 16, bottom: 16, right: 72),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                          Container(
                              //color: Colors.grey[200],
                              margin: EdgeInsets.only(bottom: 24.0),
                              child: (barang['image'] == "")
                                  ? Text(
                                      "Belum Ada Gambar yang Ditampilkan",
                                      style: GoogleFonts.openSans(
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12,
                                      ),
                                    )
                                  : _viewImage(barang['key'])
                              // _viewImage(barang['key']),
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
                                          "Komplain",
                                          style: GoogleFonts.openSans(
                                            fontSize: 12,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        _showDialogKomplain(barang['key']);
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

  //DIALOG ADD KOMPLAIN
  Widget _showDialogKomplain(String barangKey) {
    getBarangDetail(barangKey: barangKey);
    _cekIsiKomplainAdmin(barangKey: barangKey);
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
                          top: 16, bottom: 8, left: 8, right: 8),
                      margin: EdgeInsets.only(bottom: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        //posisi
                        mainAxisSize: MainAxisSize.min,
                        // untuk mengatur agar widget column mengikuti widget
                        children: <Widget>[
                          Container(
                              child: Text(
                            "Komplain Kerusakan",
                            style: GoogleFonts.openSans(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),),
                          SizedBox(height: 16),

                          Container(
                            child: TextFormField(
                              cursorColor: Colors.black,
                              style: GoogleFonts.openSans(fontSize: 12),
                              maxLines: 10,
                              controller: _laporanController,
                              decoration: new InputDecoration(
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      borderSide: BorderSide(
                                          color: Color(0xFF000000)
                                              .withOpacity(0.15))),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      borderSide:
                                          BorderSide(color: Color(0xFF031F4B))),
                                  filled: false,
                                  contentPadding: EdgeInsets.only(
                                      left: 24.0,
                                      right: 24.0,
                                      top: 12.0,
                                      bottom: 12.0),
                                  hintStyle: GoogleFonts.openSans(
                                      fontSize: 12,
                                      color:
                                          Color(0xFF000000).withOpacity(0.15)),
                                  hintText: "Komplain Kerusakan",
                                  errorBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      borderSide:
                                          BorderSide(color: Colors.red)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
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
                              onChanged: (value) {
                                valueKomplainStr = value;
                              },
                            ),
                          ),

                          //Button
                          Container(
                            margin: EdgeInsets.only(top: 12),
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
                                  "Kirim",
                                  style: GoogleFonts.openSans(
                                    fontSize: 12,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                updateKomplain(barangKey: barangKey);
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
                            radius: 10,
                            backgroundColor: Color(0xFF031F4B),
                            child: Icon(
                              Icons.close,
                              size: 14,
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

  /*_cekUidKomplain(String komplainKey) async {
    DataSnapshot snapshotKomplain =
        await _compref.child(komplainKey).child('komplain').child(uid).once();
    Map komplainNote = snapshotKomplain.value;
    komplainNote['key'] = snapshotKomplain.key;
    komplainNoteKey = snapshotKomplain.key;
    print("komplainNote: " + komplainNoteKey.toString());
    print("komplainKey: " + komplainKey.toString());
  }*/

  /*Widget _buildListKomplainNote({Map komplainNote, String komplainKey}) {
    return Container(
      child: Column(
        children: [
          RaisedButton(
            onPressed: () {
              _cekUidKomplain(komplainKey);
            },
          ),
          Text(komplainNote['note']),
        ],
      ),
    );
  }*/

  //LIST KOMPLAIN
  Widget _buildListKomplain({Map komplain, final theme}) {
    //String komplainKey = komplain['key'];
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
              Container(
                margin: EdgeInsets.only(
                    left: 24, top: 16, bottom: 16, right: 24),
                alignment: Alignment.topRight,
                //color: Colors.red,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      komplain['date'],
                      textAlign: TextAlign.right,
                      style: GoogleFonts.openSans(
                        fontStyle: FontStyle.normal,
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      komplain['time'],
                      textAlign: TextAlign.right,
                      style: GoogleFonts.openSans(
                        fontStyle: FontStyle.normal,
                        fontSize: 12,
                        color: Colors.black,
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
                        margin: EdgeInsets.only(
                            left: 24, top: 16, bottom: 16, right: 72),
                        child: Row(
                          //posisi
                          mainAxisSize: MainAxisSize.min,
                          // untuk mengatur agar widget column mengikuti widget
                          children: <Widget>[
                            Text(
                              komplain['nama'],
                              style: GoogleFonts.openSans(
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
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
                      margin: EdgeInsets.only(left: 24, bottom: 32, right: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Catatan Komplain",
                            textAlign: TextAlign.right,
                            style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            komplain['note'],
                            textAlign: TextAlign.right,
                            style: GoogleFonts.openSans(
                              fontStyle: FontStyle.normal,
                              fontSize: 12,
                              color: Colors.black.withOpacity(0.25),
                            ),
                          ),
                          /*Container(
                            height: 100,
                            child: FirebaseAnimatedList(
                              query: _compref
                                  .child(uid)
                                  .child('komplain')
                                  .orderByKey(),
                              itemBuilder: (BuildContext context,
                                  DataSnapshot snapshot,
                                  Animation<double> animation,
                                  int index) {
                                Map komplain = snapshot.value;
                                komplain['key'] = snapshot.key;
                                return _buildListKomplainNote(
                                    komplainNote: komplain,
                                    komplainKey: komplainKey);
                              },
                            ),
                          ),*/
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

  // AMBIL SHARED PREFERENCES
  Future<void> _ambilPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      uid = preferences.getString('uid');
      name = preferences.getString('name');
      role = preferences.getString('role');
    });
  }

  //TAMPILAN
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
              Container(
                margin: EdgeInsets.only(left: 32, right: 32, top: 24),
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
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(0),
                  margin:
                      EdgeInsets.only(top: 24, bottom: 28, left: 16, right: 16),
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
                                text: "Daftar Barang",
                              ),
                              Tab(
                                text: "List Komplain",
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
                                  StreamBuilder(
                                    stream: FirebaseDatabase.instance
                                        .reference()
                                        .child('trigger')
                                        .onValue,
                                    builder: (BuildContext context,
                                        AsyncSnapshot<Event> snapshot) {
                                      if (snapshot.hasData) {
                                        _cekIsiBarang();
                                        Map valueTrigger =
                                            snapshot.data.snapshot.value;
                                        if (valueTrigger['adaBarang'] !=
                                            "false") {
                                          _cekIsiBarang();
                                          return MediaQuery.removePadding(
                                            context: context,
                                            removeTop: true,
                                            child: CupertinoScrollbar(
                                              controller: _scrollController,
                                              child: FirebaseAnimatedList(
                                                padding: EdgeInsets.all(0),
                                                query: _queryBarang,
                                                itemBuilder: (BuildContext
                                                        context,
                                                    DataSnapshot snapshot,
                                                    Animation<double> animation,
                                                    int index) {
                                                  Map barang = snapshot.value;
                                                  barang['key'] = snapshot.key;
                                                  if (barang == null) {
                                                    return Container(
                                                      height: 100,
                                                      color: Colors.red,
                                                    );
                                                  } else {
                                                    return _buildListBarang(
                                                        barang: barang,
                                                        theme: theme);
                                                  }
                                                },
                                              ),
                                            ),
                                          );
                                        } else {
                                          _cekIsiBarang();
                                          return MediaQuery.removePadding(
                                            context: context,
                                            removeTop: true,
                                            child: CupertinoScrollbar(
                                                controller: _scrollController,
                                                child: Center(
                                                  child: Text(
                                                    "Belum ada barang",
                                                    style: GoogleFonts.openSans(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black
                                                            .withOpacity(0.25)),
                                                  ),
                                                )),
                                          );
                                        }
                                      } else {
                                        return Container();
                                      }
                                    },
                                  ),

                                  // TAB VIEW KOMPLAIN
                                  StreamBuilder(
                                    stream: FirebaseDatabase.instance
                                        .reference()
                                        .child('trigger')
                                        .child('adaKomplainPegawai')
                                        .onValue,
                                    builder: (BuildContext context,
                                        AsyncSnapshot<Event> snapshot) {
                                      if (snapshot.hasData) {
                                        _cekIsiKomplain();
                                        Map valueTrigger =
                                            snapshot.data.snapshot.value;
                                        if (valueTrigger[uid] != "false") {
                                          _cekIsiKomplain();
                                          return MediaQuery.removePadding(
                                            context: context,
                                            removeTop: true,
                                            child: CupertinoScrollbar(
                                              controller: _scrollController,
                                              child: FirebaseAnimatedList(
                                                query: _compref
                                                    .child(uid)
                                                    .child('komplain')
                                                    .orderByKey(),
                                                itemBuilder: (BuildContext
                                                        context,
                                                    DataSnapshot snapshot,
                                                    Animation<double> animation,
                                                    int index) {
                                                  Map komplain = snapshot.value;
                                                  //komplain['key'] = snapshot.key;
                                                  return _buildListKomplain(
                                                      komplain: komplain,
                                                      theme: theme);
                                                },
                                              ),
                                            ),
                                          );
                                        } else {
                                          _cekIsiKomplain();
                                          return MediaQuery.removePadding(
                                            context: context,
                                            removeTop: true,
                                            child: CupertinoScrollbar(
                                                controller: _scrollController,
                                                child: Center(
                                                  child: Text(
                                                    "Anda belum pernah komplain",
                                                    style: GoogleFonts.openSans(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black
                                                            .withOpacity(0.25)),
                                                  ),
                                                )),
                                          );
                                        }
                                      } else {
                                        return Container();
                                      }
                                    },
                                  ),
                                ]),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  getBarangDetail({String barangKey}) async {
    DataSnapshot snapshot = await _ref.child(barangKey).once();

    Map barang = snapshot.value;
    String nama, lokasi, divisi, komplain;

    nama = barang['nama'];
    lokasi = barang['letak'];
    divisi = barang['divisi'];
  }

  _isiKomplain() {}

  updateKomplain({String barangKey}) async {
    DateTime now = DateTime.now();
    DateFormat format = new DateFormat("d/LL/yyyy", "id_ID");
    String formattedDate = format.format(now);

    DataSnapshot snapshot = await _ref.child(barangKey).once();
    DataSnapshot snapshotKomplain = await _comprefAdmin.child(barangKey).once();

    Map barang = snapshot.value;
    Map isiKomplain = snapshotKomplain.value;
    String nama, lokasi, divisi, komplain, status;

    nama = barang['nama'];
    lokasi = barang['letak'];
    divisi = barang['divisi'];
    status = barang['status'];

    if (isiKomplainStr == "null") {
      print("isiKomplain: " + isiKomplain.toString());
      _compref.child(uid).child('komplain').child(barangKey).set({
        'nama': nama,
        'note': valueKomplainStr,
        'date': formattedDate,
        'time':
            "${now.hour.toString()}:${now.minute.toString().padLeft(2, '0')}",
      });
      _comprefAdmin.child(barangKey).set({
        'letak': lokasi,
        'nama': nama,
        'divisi': divisi,
      }).then((value) {
        _comprefAdmin.child(barangKey).child('komplain').child(uid).set({
          'note': valueKomplainStr,
          'namaPekomplain': name,
          'uidPekomplain': uid,
          'date': formattedDate,
          'time':
              "${now.hour.toString()}:${now.minute.toString().padLeft(2, '0')}",
        });
      });
      resetAndClose();
      SnackBar snackbar = SnackBar(content: Text('Komplain Tersampaikan'));
      scaffoldKey.currentState.showSnackBar(snackbar);
    } else {
      print("isiKomplain: " + isiKomplain.toString());
      _compref.child(uid).child('komplain').child(barangKey).set({
        'nama': nama,
        'note': valueKomplainStr,
        'date': formattedDate,
        'time':
            "${now.hour.toString()}:${now.minute.toString().padLeft(2, '0')}",
      });
      _comprefAdmin.child(barangKey).child('komplain').child(uid).set({
        'note': valueKomplainStr,
        'namaPekomplain': name,
        'uidPekomplain': uid,
        'date': formattedDate,
        'time':
            "${now.hour.toString()}:${now.minute.toString().padLeft(2, '0')}",
      });
      resetAndClose();
      SnackBar snackbar = SnackBar(content: Text('Komplain Tersampaikan'));
      scaffoldKey.currentState.showSnackBar(snackbar);
    }
  }

  resetAndClose() {
    Navigator.pop(context);
  }

  Color getStatusColor(String status) {
    Color color = Theme.of(context).accentColor;

    if (status == 'Normal') {
      color = Color(0xFF628C57);
    }
    if (status == 'Rusak') {
      color = Color(0xFFFF6A6A);
    }
    if (status == 'Dalam Perbaikan') {
      color = Color(0xFFFFD54F);
    }
    return color;
  }
}
