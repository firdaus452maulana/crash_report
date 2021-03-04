import 'package:crash_report/tampilan/sideBar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class listbarangPage_teknisi extends StatefulWidget {
  @override
  _listbarangPage_teknisiState createState() => _listbarangPage_teknisiState();
}

class _listbarangPage_teknisiState extends State<listbarangPage_teknisi>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  TextEditingController _namaAlatController,
      _lokasiController,
      _divisiController;

  Query _query;
  DatabaseReference _ref;
  String uid, name, role;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
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

  Widget _buildListBarang({Map barang}) {
    Color statusColor = getStatusColor(barang['status']);
    return Container(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: sideBar(),
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
                      labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                      unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
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
                      child: new TabBarView(
                          controller: _tabController,
                          //physics: NeverScrollableScrollPhysics(),
                          children: [
                            // TAB VIEW LIST BARANG
                            FirebaseAnimatedList(
                              query: _query,
                              itemBuilder: (BuildContext context,
                                  DataSnapshot snapshot,
                                  Animation<double> animation,
                                  int index) {
                                Map barang = snapshot.value;
                                return _buildListBarang(barang: barang);
                              },
                            ),

                            // TAB VIEW LAPORAN
                            Center(child: Text("wow\nlol")),
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
