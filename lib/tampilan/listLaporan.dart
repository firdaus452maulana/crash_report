import 'package:flutter/material.dart';
import 'package:path/path.dart' as Path;
import 'package:crash_report/tampilan/sideBar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class listLaporan extends StatefulWidget {
  @override
  _listLaporanState createState() => _listLaporanState();
}

class _listLaporanState extends State<listLaporan> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  Query _query;

  //Tampilan List barang
  Widget _buildListBarang({Map barang, final theme}){
    Color statuColor = getStatusColor(barang['status']);
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
        child: Theme(
            data: theme,
            child: ExpansionTile(
                trailing: Text(''),
                title: Padding(
                  padding: const EdgeInsets.only(top: 122.0, bottom: 12.0, left: 0.0, right: 0.0),
                  child: Stack(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        //Posisi
                        mainAxisSize: MainAxisSize.min,
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
                                color: Colors.black.withOpacity(0.25)
                            ),
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
                      )
                    ],
                  ),
                )
            )
        ),
      ),
    );
  }
  //TAMPILAN
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: Stack(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(left: 24, right: 24, bottom: 24, top: 180),
                child: FirebaseAnimatedList(
                    query: _query,
                    itemBuilder: (BuildContext context, DataSnapshot snapshot,
                        Animation<double> animation, int index) {
                      Map barang = snapshot.value;
                      return _buildListBarang(barang: barang, theme: theme);
                    },
                ),
            ),
          ],
      ),
    );
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
