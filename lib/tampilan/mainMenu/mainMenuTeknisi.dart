import 'dart:io';
import 'package:crash_report/tampilan/historyLaporan.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:crash_report/tampilan/sideBar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class mainMenuTeknisi extends StatefulWidget {
  @override
  _mainMenuTeknisiState createState() => _mainMenuTeknisiState();
}

class _mainMenuTeknisiState extends State<mainMenuTeknisi>
    with SingleTickerProviderStateMixin {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  TabController _tabController;
  ScrollController _scrollController;
  String valueStatus;

  List divisi = ["Dalam Perbaikan", "Rusak", "Normal"];

  Query _queryLaporan, _queryBarang;
  DatabaseReference _listLaporanRef, _listBarangRef, _historyLaporanRef;
  String uid = '';
  String name = '';
  String role = '';
  File image;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _scrollController = ScrollController();
    _listLaporanRef =
        FirebaseDatabase.instance.reference().child('listLaporan');
    _listBarangRef = FirebaseDatabase.instance.reference().child('listBarang');
    _historyLaporanRef =
        FirebaseDatabase.instance.reference().child('historyLaporan');
    _queryLaporan = FirebaseDatabase.instance
        .reference()
        .child('listLaporan')
        .orderByChild('nama');
    _queryBarang = FirebaseDatabase.instance
        .reference()
        .child('listBarang')
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
        ],
      ),
    );
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
                          Container(
                            height: 100,
                            //color: Colors.grey[200],
                            child: FirebaseAnimatedList(
                              query: _listBarangRef
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
                          ),
                          Container(
                            width: double.infinity,
                            //color: Colors.green,
                            padding: EdgeInsets.all(0),
                            margin: EdgeInsets.only(bottom: 24),
                            alignment: Alignment.center,
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
                      margin: EdgeInsets.only(left: 24, bottom: 32, right: 24),
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
                          SizedBox(height: 8),
                          Text(
                            'Status Pelaporan',
                            style: GoogleFonts.openSans(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          /*Text(
                            laporan['key'],
                            style: GoogleFonts.openSans(
                                fontWeight: FontWeight.w300,
                                fontSize: 12,
                                color: Colors.black.withOpacity(0.25)),
                          ),*/
                          Container(
                            height: 24,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.15),
                                    spreadRadius: 0,
                                    blurRadius: 2,
                                    offset: Offset(0, 0),
                                  )
                                ]),
                            child: DropdownButtonFormField(
                              icon: Icon(Icons.expand_more),
                              iconSize: 16,
                              decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black.withOpacity(0.25)),
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                      borderSide: BorderSide(
                                          color: Colors.transparent)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                      borderSide: BorderSide(
                                          color: Colors.transparent)),
                                  filled: false,
                                  contentPadding:
                                      EdgeInsets.only(left: 16.0, right: 16.0),
                                  hintStyle: GoogleFonts.openSans(
                                      fontSize: 12,
                                      color:
                                          Color(0xFF000000).withOpacity(0.25)),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                      borderSide:
                                          BorderSide(color: Colors.red)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                      borderSide: BorderSide(
                                          color: Colors.transparent)),
                                  errorStyle:
                                      GoogleFonts.openSans(fontSize: 10)),
                              value: valueStatus = laporan['status'],
                              onChanged: (newValue) {
                                setState(() {
                                  valueStatus = newValue;
                                  _updateStatus(barangKey: laporan['key']);
                                });
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
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            child: RaisedButton(
                              color: Color(0xFF031F4B),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              textColor: Colors.white,
                              child: Text(
                                "Selesai",
                                style: GoogleFonts.openSans(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                _selesaiLaporan(
                                    barangKey: laporan['key'],
                                    nama: laporan['nama'],
                                    date: laporan['date'],
                                    time: laporan['time']);
                              },
                            ),
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

  //SUBMIT PROGRESS LAPORAN
  _selesaiLaporan({String barangKey, String nama, String date, String time}) {
    DateTime now = DateTime.now();
    DateFormat format = new DateFormat("EEEE, d LLLL yyyy", "id_ID");
    String formattedDate = format.format(now);

    _historyLaporanRef.push().set({
      'barangKey': barangKey,
      'nama': nama,
      'dateMulai': date,
      'dateSelesai': formattedDate,
      'timeMulai': time,
      'timeSelesai':
          "${now.hour.toString()}:${now.minute.toString().padLeft(2, '0')}",
      'namaTeknisi': name,
      'status': valueStatus,
    });
    if (_listLaporanRef.child(barangKey) != null) {
      _listLaporanRef.child(barangKey).remove();
    }
  }

  // WARNA STATUS
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

  // AMBIL SHARED PREFERENCES
  Future<void> _ambilPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      uid = preferences.getString('uid');
      name = preferences.getString('name');
      role = preferences.getString('role');
    });
  }

  // UPDATE STATUS BARANG (LAPORAN)
  _updateStatus({String barangKey}) {
    _listLaporanRef.child(barangKey).update({
      'status': valueStatus,
    });
    _listBarangRef.child(barangKey).update({
      'status': valueStatus,
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
                                  MediaQuery.removePadding(
                                    context: context,
                                    removeTop: true,
                                    child: CupertinoScrollbar(
                                      controller: _scrollController,
                                      child: FirebaseAnimatedList(
                                        query: _queryBarang,
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

                                  // TAB VIEW LIST LAPORAN
                                  MediaQuery.removePadding(
                                    context: context,
                                    removeTop: true,
                                    child: CupertinoScrollbar(
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
}
