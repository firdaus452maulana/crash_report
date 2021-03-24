import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class historyLaporan extends StatefulWidget {
  @override
  _historyLaporanState createState() => _historyLaporanState();
}

class _historyLaporanState extends State<historyLaporan> {
  Query _queryHistory;

  @override
  void initState() {
    super.initState();
    _queryHistory =
        FirebaseDatabase.instance.reference().child('historyLaporan');
  }

  // LIST HISTORY LAPORAN
  Widget _buildHistoryLaporan({Map history, final theme}) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      alignment: Alignment.topLeft,
      //color: Colors.cyan,
      child: Container(
        //color: Colors.teal,
        child: Column(
          children: [

            Theme(
              data: theme,
              child: ExpansionTile(
                  title: Container(
                    margin: EdgeInsets.only(top: 8, bottom: 8),
                    //color: Colors.grey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          history['nama'] + " (" + history['barangKey'] + ")",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.openSans(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          history['dateSelesai'],
                          textAlign: TextAlign.left,
                          style: GoogleFonts.openSans(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w300,
                            fontSize: 12,
                            color: Colors.black.withOpacity(0.25),
                          ),
                        ),
                        Text(
                          history['timeSelesai'],
                          textAlign: TextAlign.left,
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
                  children: [
                    Container(
                      width: double.infinity,
                      //color: Colors.green,
                      margin: EdgeInsets.only(
                          left: 24, bottom: 16, right: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Teknisi yang mengerjakan",
                            style: GoogleFonts.openSans(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            history['namaTeknisi'],
                            style: GoogleFonts.openSans(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w300,
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),

                          Text(
                            "Tanggal Laporan",
                            style: GoogleFonts.openSans(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            history['dateMulai'],
                            style: GoogleFonts.openSans(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w300,
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            history['timeMulai'],
                            style: GoogleFonts.openSans(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w300,
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Tanggal selesai",
                            style: GoogleFonts.openSans(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            history['dateSelesai'],
                            style: GoogleFonts.openSans(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w300,
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            history['timeSelesai'],
                            style: GoogleFonts.openSans(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w300,
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Kondisi akhir",
                            style: GoogleFonts.openSans(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            history['status'],
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
                  ]
              ),
            ),
            Container(
              height: 1,
              color: Colors.black.withOpacity(0.25),
            ),
          ],
        ),
      ),
    );
  }

  // TAMPILAN
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            color: Color(0xFF031F4B),
            child: Container(
              margin: EdgeInsets.only(top: 38, left: 16, right: 16, bottom: 12),
              child: Row(
                children: [
                  Container(
                    //color: Colors.red,
                    alignment: Alignment.topLeft,
                    child: Text(
                      "RIWAYAT PELAPORAN",
                      style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                  Expanded(
                    child: Container(
                        alignment: Alignment.topRight,
                        //color: Colors.blue,
                        child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                            ))),
                  ),
                ],
              ),
            ),
          ),

          /*Container(
            height: 1,
            color: Colors.black,
          ),*/

          Expanded(
            child: FirebaseAnimatedList(
              query: _queryHistory,
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                Map history = snapshot.value;
                history['key'] = snapshot.key;
                return _buildHistoryLaporan(history: history, theme: theme);
              },
            ),
          ),
        ],
      ),
    );
  }
}
