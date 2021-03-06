import 'package:crash_report/tampilan/login/forgotPasswordPage.dart';
import 'package:crash_report/tampilan/mainMenu/mainMenuTeknisi.dart';
import 'package:crash_report/tampilan/mainMenu/mainMenuPegawai.dart';
import 'package:crash_report/tampilan/mainMenu/mainMenuAdmin.dart';
import 'package:crash_report/tampilan/register/daftarSebagaiPage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class loginPage extends StatefulWidget {
  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  DatabaseReference userData =
      FirebaseDatabase.instance.reference().child('users');

  bool _secureText = true;
  String uid, bagian, name, role;

  TextEditingController _emailContoller = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _clearPreference();
  }

  // NAVIGASI KE HALAMAN HOME PEGAWAI, ADMIN, DAN TEKNISI
  _navSignInSuccess() {
    if (bagian == "pegawai") {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => mainMenuPegawai()),
            (route) => false,
      );
    }

    if (bagian == "admin") {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => mainMenuAdmin()),
        (route) => false,
      );
    }

    if (bagian == "teknisi") {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => mainMenuTeknisi()),
        (route) => false,
      );
    }
  }

  Future<void> _clearPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.clear();
    });
  }

  // FUNGSI SUBMIT LOGIN
  Future<void> _signIn() async {
    // BUAT VALIDASI FORMFIELD
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    // PROSES LOGIN
    try {
      UserCredential credential = await auth.signInWithEmailAndPassword(
          email: _emailContoller.text, password: _passwordController.text);
      User user = credential.user;
      uid = user.uid.toString();

      try {
        // AMBIL DATA DARI REALTIME DATABASE
        await userData.child(uid).once().then((DataSnapshot snapshot) {
          Map<dynamic, dynamic>.from(snapshot.value).forEach((key, values) {
            setState(() {
              print("snapshot value: " + values.toString());
              if (key == 'name') {
                name = values.toString();
                print("nama: " + name);
              } else if (key == 'bagian') {
                bagian = values.toString();
                print("bagian: " + bagian);
              } else if (key == 'role') {
                role = values.toString();
                print("divisi: " + role);
              } else {
                print("bukan value yg dicari");
              }
            });
          });
        });

        // NYIMPAN SHARE PREFERENCE
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('bagian', bagian);
        preferences.setString('uid', uid);
        preferences.setString('name', name);
        preferences.setString('role', role);

        try {
          _navSignInSuccess();
        } catch (error) {
          print(error.message);
        }
      } catch (error) {
        print(error.message);
      }
      showToastSignInSuccess();
    } catch (error) {
      //print(error.message);
      var errorMessage = 'Terjadi kesalahan, mohon isi kembali.';
      _showErrorDialog(errorMessage);
    }
  }

  // TOAST LOGIN BERHASIL
  void showToastSignInSuccess() {
    Fluttertoast.showToast(
        msg: 'Login Berhasil',
        fontSize: 12,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Color(0xFF515151),
        textColor: Colors.white);
  }

  // ERROR DIALOGBOX
  void _showErrorDialog(String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: Text(
                "Terjadi kesalahan.",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: Text(msg, style: TextStyle(fontSize: 12)),
            ));
  }

  // TAMPILAN
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/background.png'),
                      fit: BoxFit.fill)),
            ),
            Center(
              child: SingleChildScrollView(
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 32,
                      ),
                      Image.asset(
                        'assets/logo_perang_only.png',
                        scale: 24,
                      ),

                      SizedBox(
                        height: 4,
                      ),
                      Text(
                          'S I A P',
                          style: GoogleFonts.montserrat(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Color(0xFF031F4B),
                          )
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Container(
                        child: Container(
                          margin: EdgeInsets.only(left: 32, right: 32, bottom: 32),
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
                          child: Stack(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(
                                    left: 24, right: 8, top: 24, bottom: 24),
                                child: Form(
                                  key: _formKey,
                                  child: Container(
                                    //color: Colors.yellow,
                                    padding: EdgeInsets.only(right: 16),
                                    child: Column(
                                      children: [
                                        Container(
                                          //color: Colors.red,
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(left: 15,top: 10, right: 15),
                                          child: Text(
                                            "Masuk",
                                            style: GoogleFonts.openSans(
                                                fontSize: 26,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 24,
                                        ),

                                        // EMAIL
                                        Container(
                                          //color: Colors.blue,
                                          child: TextFormField(
                                            controller: _emailContoller,
                                            cursorColor: Colors.black,
                                            style: TextStyle(fontSize: 12),
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            decoration: new InputDecoration(
                                                prefixIcon: Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 8),
                                                  child: Icon(
                                                    Icons.email,
                                                    color: Color(0xFF000000)
                                                        .withOpacity(0.25),
                                                    size: 16,
                                                  ),
                                                ),
                                                fillColor: Colors.white,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(30)),
                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(30)),
                                                    borderSide: BorderSide(
                                                        color: Color(0xFF000000)
                                                            .withOpacity(
                                                                0.15))),
                                                focusedBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(30)),
                                                    borderSide: BorderSide(
                                                        color:
                                                            Color(0xFF031F4B))),
                                                filled: false,
                                                contentPadding:
                                                    EdgeInsets.only(left: 24.0),
                                                hintStyle: TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xFF000000)
                                                        .withOpacity(0.25)),
                                                hintText: "email",
                                                errorBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(30)),
                                                    borderSide: BorderSide(color: Colors.red)),
                                                focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30)), borderSide: BorderSide(color: Colors.red, width: 1)),
                                                errorStyle: TextStyle(fontSize: 10)),
                                            obscureText: false,
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return "Email harus diisi";
                                              }
                                              return null;
                                            },
                                            onSaved: (value) {},
                                          ),
                                        ),

                                        SizedBox(height: 16),

                                        // PASSWORD
                                        Container(
                                          child: TextFormField(
                                            controller: _passwordController,
                                            cursorColor: Colors.black,
                                            style: TextStyle(fontSize: 12),
                                            decoration: new InputDecoration(
                                              prefixIcon: Padding(
                                                padding:
                                                    EdgeInsets.only(left: 8),
                                                child: Icon(
                                                  Icons.lock,
                                                  color: Color(0xFF000000)
                                                      .withOpacity(0.25),
                                                  size: 16,
                                                ),
                                              ),
                                              suffixIcon: Padding(
                                                padding:
                                                    EdgeInsets.only(right: 8),
                                                child: IconButton(
                                                  icon: Icon(
                                                    _secureText
                                                        ? Icons.remove_red_eye
                                                        : Icons.remove,
                                                    color: Color(0xFF000000)
                                                        .withOpacity(0.25),
                                                    size: 16,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      _secureText =
                                                          !_secureText;
                                                    });
                                                  },
                                                ),
                                              ),
                                              fillColor: Colors.transparent,
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(30),
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(30)),
                                                  borderSide: BorderSide(
                                                      color: Color(0xFF000000)
                                                          .withOpacity(0.15))),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(30)),
                                                  borderSide: BorderSide(
                                                      color:
                                                          Color(0xFF031F4B))),
                                              filled: true,
                                              contentPadding:
                                                  EdgeInsets.only(left: 24.0),
                                              hintStyle: TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0xFF000000)
                                                      .withOpacity(0.25)),
                                              hintText: "kata sandi",
                                              errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(30)),
                                                  borderSide: BorderSide(
                                                      color: Colors.red)),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  30)),
                                                      borderSide: BorderSide(
                                                          color: Colors.red,
                                                          width: 1)),
                                              errorStyle: TextStyle(
                                                fontSize: 10,
                                              ),
                                            ),
                                            obscureText: _secureText,
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return "Password harus diisi";
                                              }
                                              return null;
                                            },
                                          ),
                                        ),

                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: FlatButton(
                                            splashColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          forgotPasswordPage()));
                                              _emailContoller.clear();
                                              _passwordController.clear();
                                            },
                                            child: Text(
                                              "Lupa Kata Sandi ?",
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ),
                                        ),

                                        SizedBox(height: 12),

                                        RaisedButton(
                                          color: Color(0xFF031F4B),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          textColor: Colors.white,
                                          child: Container(
                                            height: 48,
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Masuk",
                                              style: GoogleFonts.openSans(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          onPressed: () {
                                            _signIn();
                                          },
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 30,bottom: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Belum memiliki akun ?",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xFF000000)
                                                        .withOpacity(.25)),
                                              ),
                                              SizedBox(width: 4,),
                                              Container(
                                                //color: Colors.red,
                                                child: GestureDetector(
                                                  child: Text(
                                                    "Daftar",
                                                    style: GoogleFonts.openSans(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                daftarSebagai()));
                                                    _emailContoller.clear();
                                                    _passwordController.clear();
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
