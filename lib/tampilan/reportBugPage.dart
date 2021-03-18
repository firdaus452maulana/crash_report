import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class reportBugPage extends StatefulWidget {
  @override
  _reportBugPageState createState() => _reportBugPageState();
}

class _reportBugPageState extends State<reportBugPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailBodyController = TextEditingController();
  String valueEmailBody;
  String uid = '';
  String name = '';
  String role = '';

  // INIT STATE
  @override
  void initState() {
    super.initState();
    _ambilPreference();
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

  _sendEmail() async {
    final Email email = Email(
      body: "Dari: ${name} (${uid})\n\n${_emailBodyController.text}",
      subject: 'Hubungi Tim Pengembang',
      recipients: ['perang.airnav@gmail.com'],
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
      print(platformResponse);
    } catch (error) {
      platformResponse = error.toString();
      print('error?: ' + platformResponse);
    }
  }

  // TOAST EMAIL SENT
  void showToastSuccess() {
    Fluttertoast.showToast(
        msg: 'Email telah dikirim',
        fontSize: 12,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Color(0xFF000000).withOpacity(0.05),
        textColor: Colors.black);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 24),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
          ),

          Center(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 4, right: 4),
                      width: double.infinity,
                      child: Text(
                        "Hubungi Tim Pengembang",
                        style: GoogleFonts.openSans(
                            fontWeight: FontWeight.bold, fontSize: 32),
                        textAlign: TextAlign.start,
                      ),

                    ),

                    SizedBox(
                      height: 12,
                    ),

                    Container(
                      margin: EdgeInsets.only(left: 4, right: 4),
                      width: double.infinity,
                      child: Text(
                        "Jangan ragu untuk memberi kritik dan saran agar tim developer dapat menjadi lebih baik.",
                        style: GoogleFonts.openSans(color: Colors.black.withOpacity(0.25), fontSize: 12),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        style: TextStyle(fontSize: 12),
                        maxLines: 10,
                        controller: _emailBodyController,
                        decoration: new InputDecoration(
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                                borderSide: BorderSide(
                                    color: Color(0xFF000000).withOpacity(0.15))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                                borderSide: BorderSide(color: Color(0xFF031F4B))),
                            filled: false,
                            contentPadding:
                                EdgeInsets.only(left: 16.0, right: 16.0, top: 16),
                            hintStyle: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF000000).withOpacity(0.25)),
                            hintText: "Tuliskan pesan anda di sini...",
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                                borderSide: BorderSide(color: Colors.red)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                                borderSide: BorderSide(color: Colors.red, width: 1)),
                            errorStyle: TextStyle(fontSize: 10)),
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    RaisedButton(
                      color: Color(0xFF031F4B),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      textColor: Colors.white,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          "Kirim",
                          style: GoogleFonts.openSans(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                      onPressed: () {
                        _sendEmail();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
