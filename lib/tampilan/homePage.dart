import 'package:crash_report/tampilan/login/loginPage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class homePage extends StatefulWidget {
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String uid, name, role;
  Query _queryLaporan, _queryBarang;
  bool searchState = false;
  DatabaseReference userData =
      FirebaseDatabase.instance.reference().child('users');
  DatabaseReference _listBarangRef;
  String valueChoose = "Lokasi";
  List listItem = ["nama Barang", "Divisi", "Lokasi"];

  // BUAT NGERUN FUNGSI PAS APP START
  @override
  void initState() {
    _queryBarang = FirebaseDatabase.instance
        .reference()
        .child('listBarang')
        .orderByChild('letak');
    _listBarangRef = FirebaseDatabase.instance.reference().child('listBarang');

    _ambilPreference();
    _getUserData();
  }

  _sortBy(){
    if (valueChoose == 'nama Barang'){
      _queryBarang = FirebaseDatabase.instance
          .reference()
          .child('listBarang')
          .orderByChild('nama');
    }
    if (valueChoose == 'Divisi'){
      _queryBarang = FirebaseDatabase.instance
          .reference()
          .child('listBarang')
          .orderByChild('divisi');
    }
    if (valueChoose == 'Lokasi'){
      _queryBarang = FirebaseDatabase.instance
          .reference()
          .child('listBarang')
          .orderByChild('letak');
    }
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

  // AMBIL SHARED PREFERENCES
  Future<void> _ambilPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      uid = preferences.getString('uid');
      name = preferences.getString('name');
      role = preferences.getString('role');
    });
  }

  Future<void> _getUserData() async {
    // AMBIL DATA DARI REALTIME DATABASE
    await userData.child(uid).once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic>.from(snapshot.value).forEach((key, values) {
        setState(() {
          print("snapshot value: " + values.toString());
          if (key == 'name') {
            name = values.toString();
            print("nama pegawai: " + name);
          } else {
            print("bukan bagian");
          }
        });
      });
    });
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

  //LIST BARANG
  Widget _buildListBarang({Map barang}) {
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
              ExpansionTile(
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
            ],
          )),
    );
  }

  // TAMPILAN
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          DropdownButton(
            hint: Text("Select Sort By"),
            dropdownColor: Colors.grey,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 30,
            isExpanded: true,
            style: TextStyle(color: Colors.black, fontSize: 22),
            value: valueChoose,
            onChanged: (newValue) {
              setState(() {
                valueChoose = newValue;
                _sortBy();
              });
            },
            items: listItem.map((valueItem) {
              return DropdownMenuItem(
                value: valueItem,
                child: Text(valueItem),
              );
            }).toList(),
          ),
          Container(
            height: 500,
            color: Colors.red,
            child: FirebaseAnimatedList(
              query: _queryBarang,
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                Map barang = snapshot.value;
                barang['key'] = snapshot.key;
                return _buildListBarang(barang: barang);
              },
            ),
          ),
        ],
      ),
    );
  }
}
