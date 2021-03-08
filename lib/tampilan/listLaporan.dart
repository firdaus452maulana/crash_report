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

class listLaporan extends StatefulWidget {
  @override
  _listLaporanState createState() => _listLaporanState();
}

class _listLaporanState extends State<listLaporan>
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
    _query = FirebaseDatabase.instance
        .reference()
        .child('listLaporan')
        .orderByChild('nama');
    _ambilPreference();
    _indogs();
  }

  Future<void> _indogs() async {
    await initializeDateFormatting('id_ID', null);
  }

  //LIST BARANG
  Widget _buildListBarang({Map barang, final theme}) {
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
                        margin: EdgeInsets.only(left: 24, top: 16, bottom: 16, right: 24),
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
                              barang['date'],
                              style: GoogleFonts.openSans(
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12,
                                  color: Colors.black.withOpacity(0.25)),
                            ),
                            Text(
                              barang['time'],
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
                            // TAB VIEW LAPORAN
                            Center(
                                child: Text("LIST BARANG")),

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
                                  return _buildListBarang(
                                      barang: barang, theme: theme);
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
    );
  }
}
