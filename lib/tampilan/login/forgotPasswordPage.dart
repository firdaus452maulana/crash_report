import 'package:crash_report/models/authentication.dart';
import 'package:crash_report/tampilan/login/loginPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class forgotPasswordPage extends StatefulWidget {
  @override
  _forgotPasswordPageState createState() => _forgotPasswordPageState();
}

class _forgotPasswordPageState extends State<forgotPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final AuthenticationService _auth = AuthenticationService();
  TextEditingController _emailContoller = TextEditingController();

  Future<void> _resetPassword() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    await _auth.createResetPassword(_emailContoller.text);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => loginPage()));
    showToastResetSuccess();
  }

  void showToastResetSuccess() {
    Fluttertoast.showToast(
      msg: "tautan ubah kata sandi sudah dikirim ke\n" + _emailContoller.text,
      fontSize: 12,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Color(0xFF000000).withOpacity(0.05),
      textColor: Colors.black,
    );
  }

  // ERROR DIALOGBOX
  void _showErrorDialog() {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: Text(
                "Terjadi kesalahan.",
                style: GoogleFonts.openSans(fontWeight: FontWeight.bold),
              ),
              content: Text("Terjadi kesalahan, mohon isi kembali.",
                  style: GoogleFonts.openSans(fontSize: 12)),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/background.png'),
                    fit: BoxFit.fill)),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(left: 32, right: 32),
              padding: EdgeInsets.only(left: 24, right: 8, top: 24, bottom: 24),
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
              child: Form(
                key: _formKey,
                child: CupertinoScrollbar(
                  child: Container(
                    padding: EdgeInsets.only(right: 16),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // TULISAN RESET PASSWORD
                          Text(
                            "Ubah Kata Sandi",
                            style: GoogleFonts.openSans(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),

                          SizedBox(
                            height: 24,
                          ),

                          // TULISAN RESET PASSWORD
                          Text(
                            "Masukkan alamat email akun anda\n"
                            "untuk melakukan reset password",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.openSans(
                                color: Color(0xFF000000).withOpacity(0.25),
                                fontSize: 12),
                          ),

                          SizedBox(
                            height: 16,
                          ),

                          // REGISTERED EMAIL
                          TextFormField(
                            controller: _emailContoller,
                            cursorColor: Colors.black,
                            style: GoogleFonts.openSans(fontSize: 12),
                            keyboardType: TextInputType.emailAddress,
                            decoration: new InputDecoration(
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Icon(
                                    Icons.email,
                                    color: Color(0xFF000000).withOpacity(0.25),
                                    size: 16,
                                  ),
                                ),
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
                                    color: Color(0xFF000000).withOpacity(0.25)),
                                hintText: "email",
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
                                return "Email harus diisi!";
                              }
                              return null;
                            },
                            onSaved: (value) {},
                          ),

                          SizedBox(
                            height: 24,
                          ),

                          // BUTTON SUBMIT RESET PASSWORD
                          RaisedButton(
                            color: Color(0xFF031F4B),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            textColor: Colors.white,
                            child: Container(
                              height: 48,
                              alignment: Alignment.center,
                              child: Text(
                                "Ubah kata sandi",
                                style: GoogleFonts.openSans(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ),
                            onPressed: () {
                              _resetPassword();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
