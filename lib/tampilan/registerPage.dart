import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/authentication.dart';
import 'package:crash_report/tampilan/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';

class registerPage extends StatefulWidget {
  @override
  _registerPageState createState() => _registerPageState();
}

class _registerPageState extends State<registerPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  bool _secureText = true;
  String valueDivisi;

  List divisi = ["Divisi 1", "Divisi 2", "Divisi 3"];

  final auth = FirebaseAuth.instance;
  final AuthenticationService _auth = AuthenticationService();

  TextEditingController _emailContoller = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  // ERROR DIALOGBOX
  void _showErrorDialog() {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: Text(
                "Something went wrong.",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: Text("Terjadi kesalahan, mohon isi kembali.", style: TextStyle(fontSize: 12)),
            ));
  }

  void showToastSignUpSuccess() {
    Fluttertoast.showToast(
        msg: 'Sign Up Success',
        fontSize: 12,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Color(0xFF000000).withOpacity(0.05),
        textColor: Colors.black);
  }

  // SUBMIT
  Future<void> _signUp() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    dynamic result = await _auth.createPegawai(_nameController.text,
        valueDivisi, _emailContoller.text, _passwordController.text);
    if (result == null) {
      print("Something went wrong");
      _showErrorDialog();
    } else {
      print(result.toString());
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => loginPage()));
      //Navigator.pop(context);
      showToastSignUpSuccess();
    }
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
              child: Container(
                margin: EdgeInsets.only(left: 32, right: 32),
                padding:
                    EdgeInsets.only(left: 24, right: 8, top: 24, bottom: 24),
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
                            // TULISAN SIGN UP
                            Text(
                              "Sign Up",
                              style: GoogleFonts.openSans(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),

                            SizedBox(
                              height: 24,
                            ),

                            // FULL NAME
                            TextFormField(
                              controller: _nameController,
                              cursorColor: Colors.black,
                              style: TextStyle(fontSize: 12),
                              keyboardType: TextInputType.text,
                              decoration: new InputDecoration(
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.only(left: 8),
                                    child: Icon(
                                      Icons.person,
                                      color:
                                          Color(0xFF000000).withOpacity(0.25),
                                      size: 16,
                                    ),
                                  ),
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30)),
                                      borderSide: BorderSide(
                                          color: Color(0xFF000000)
                                              .withOpacity(0.15))),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30)),
                                      borderSide: BorderSide(
                                          color: Color(0xFF031F4B))),
                                  filled: false,
                                  contentPadding: EdgeInsets.only(
                                      left: 24.0, right: 24.0),
                                  hintStyle: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF000000)
                                          .withOpacity(0.25)),
                                  hintText: "full name",
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30)),
                                      borderSide:
                                          BorderSide(color: Colors.red)),
                                  focusedErrorBorder:
                                      OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30)), borderSide: BorderSide(color: Colors.red, width: 1)),
                                  errorStyle: TextStyle(fontSize: 10)),
                              obscureText: false,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Field is required";
                                }
                                return null;
                              },
                            ),

                            SizedBox(
                              height: 16,
                            ),

                            // EMAIL
                            TextFormField(
                              controller: _emailContoller,
                              cursorColor: Colors.black,
                              style: TextStyle(fontSize: 12),
                              keyboardType: TextInputType.emailAddress,
                              decoration: new InputDecoration(
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.only(left: 8),
                                    child: Icon(
                                      Icons.email,
                                      color:
                                          Color(0xFF000000).withOpacity(0.25),
                                      size: 16,
                                    ),
                                  ),
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30)),
                                      borderSide: BorderSide(
                                          color: Color(0xFF000000)
                                              .withOpacity(0.15))),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30)),
                                      borderSide: BorderSide(
                                          color: Color(0xFF031F4B))),
                                  filled: false,
                                  contentPadding: EdgeInsets.only(
                                      left: 24.0, right: 24.0),
                                  hintStyle: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF000000)
                                          .withOpacity(0.25)),
                                  hintText: "email",
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30)),
                                      borderSide:
                                          BorderSide(color: Colors.red)),
                                  focusedErrorBorder:
                                      OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30)), borderSide: BorderSide(color: Colors.red, width: 1)),
                                  errorStyle: TextStyle(fontSize: 10)),
                              obscureText: false,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Field is required";
                                }
                                return null;
                              },
                              onSaved: (value) {
                              },
                            ),

                            SizedBox(
                              height: 16,
                            ),

                            // PASSWORD
                            TextFormField(
                              controller: _passwordController,
                              cursorColor: Colors.black,
                              style: TextStyle(fontSize: 12),
                              decoration: new InputDecoration(
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Icon(
                                    Icons.lock,
                                    color:
                                        Color(0xFF000000).withOpacity(0.25),
                                    size: 16,
                                  ),
                                ),
                                suffixIcon: Padding(
                                  padding: EdgeInsets.only(right: 8),
                                  child: IconButton(
                                    icon: Icon(
                                      _secureText
                                          ? Icons.remove_red_eye
                                          : Icons.remove,
                                      color:
                                          Color(0xFF000000).withOpacity(0.25),
                                      size: 16,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _secureText = !_secureText;
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
                                        BorderRadius.all(Radius.circular(30)),
                                    borderSide: BorderSide(
                                        color: Color(0xFF000000)
                                            .withOpacity(0.15))),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    borderSide:
                                        BorderSide(color: Color(0xFF031F4B))),
                                filled: true,
                                contentPadding:
                                    EdgeInsets.only(left: 24.0, right: 24.0),
                                hintStyle: TextStyle(
                                    fontSize: 12,
                                    color:
                                        Color(0xFF000000).withOpacity(0.25)),
                                hintText: "password",
                                errorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    borderSide:
                                        BorderSide(color: Colors.red)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 1)),
                                errorStyle: TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                              obscureText: true,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Field is required";
                                }
                                return null;
                              },
                            ),

                            SizedBox(
                              height: 16,
                            ),

                            // DIVISI
                            Container(
                              padding: EdgeInsets.only(left: 24, right: 24),
                              width: 500,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color(0xFF000000)
                                          .withOpacity(0.15)),
                                  borderRadius: BorderRadius.circular(30)),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                    color:
                                        Color(0xFF000000).withOpacity(0.25),
                                    size: 20,
                                  ),
                                  hint: Text(
                                    "divisi",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF000000)
                                            .withOpacity(.25)),
                                  ),
                                  value: valueDivisi,
                                  onChanged: (newValue) {
                                    setState(() {
                                      valueDivisi = newValue;
                                    });
                                  },
                                  items: divisi.map((valueItem) {
                                    return DropdownMenuItem(
                                      value: valueItem,
                                      child: Text(
                                        valueItem,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF000000)),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 16,
                            ),

                            Stack(
                              alignment: AlignmentDirectional.center,
                              children: [

                                Container(
                                  margin:
                                      EdgeInsets.only(left: 24, right: 24),
                                  height: 1,
                                  color: Color(0xFF000000).withOpacity(0.25),
                                ),

                                Container(
                                  alignment: Alignment.center,
                                  width: 24,
                                  height: 24,
                                  color: Colors.white,
                                  child: Text(
                                    "or",
                                    style: TextStyle(fontSize: 12, color: Color(0xFF000000).withOpacity(0.25)),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(
                              height: 24,
                            ),

                            // BUTTON SUBMIT SIGN UP
                            RaisedButton(
                              color: Color(0xFF031F4B),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              textColor: Colors.white,
                              child: Container(
                                height: 48,
                                alignment: Alignment.center,
                                child: Text(
                                  "Sign Up",
                                  style: GoogleFonts.openSans(
                                      fontSize: 12, fontWeight: FontWeight.bold),
                                ),
                              ),
                              onPressed: () {
                                _signUp();
                              },
                            ),

                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Already have an account?",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF000000)
                                              .withOpacity(.25)),
                                    ),
                                    Container(
                                      width: 54,
                                      child: FlatButton(
                                        padding: EdgeInsets.all(0.0),
                                        child: Text(
                                          "Sign In",
                                          style: GoogleFonts.openSans(
                                              fontSize: 12, fontWeight: FontWeight.bold),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      loginPage()));
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
        ));
  }
}
