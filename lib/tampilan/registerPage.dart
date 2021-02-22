import '../models/authentication.dart';
import 'package:crash_report/tampilan/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "packag"
    "e:cloud_firestore/cloud_firestore.dart";
import '../models/firebase.dart';

class registerPage extends StatefulWidget {
  @override
  _registerPageState createState() => _registerPageState();
}

class _registerPageState extends State<registerPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  String valueDivisi;
  String _uid = '';

  List divisi = [
    "Divisi 1", "Divisi 2", "Divisi 3"
  ];

  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  final auth = FirebaseAuth.instance;
  final AuthenticationService _auth = AuthenticationService();

  TextEditingController _emailContoller = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _roleController = TextEditingController();

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
              content: Text("Ulangi pengisian data", style: TextStyle(fontSize: 12)),
            ));
  }

  void showToastSignUpSuccess() {
    Fluttertoast.showToast(
        msg: 'Sign Up Success',
        fontSize: 12,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Color(0xFF000000).withOpacity(0.15),
        textColor: Colors.black);
  }

  // SUBMIT
  Future<void> _signUp() async {
    dynamic result = await _auth.createNewUser(_nameController.text, _roleController.text, _emailContoller.text, _passwordController.text);
    if (result == null) {
      print("Something went wrong");
      //_showErrorDialog();
    } else {
      print(result.toString());
      Navigator.push(context, MaterialPageRoute(builder: (context) => loginPage()));
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
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17.5)),
                child: Container(
                  height: 380,
                  width: 280,
                  padding: EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // FULL NAME
                          TextFormField(
                            controller: _nameController,
                            cursorColor: Colors.black,
                            style: TextStyle(fontSize: 12),
                            keyboardType:
                            TextInputType.emailAddress,
                            decoration: new InputDecoration(
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
                                contentPadding: EdgeInsets.only(
                                    left: 24.0, right: 24.0),
                                hintStyle: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF000000)
                                        .withOpacity(0.15)),
                                hintText: "email",
                                errorBorder:
                                OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30)), borderSide: BorderSide(color: Colors.red)),
                                focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30)), borderSide: BorderSide(color: Colors.red, width: 1)),
                                errorStyle: TextStyle(fontSize: 10)),
                            obscureText: false,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Field is required";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _authData['email'] = value;
                            },
                          ),

                          DropdownButton(
                            hint: Text("Pilih Divisi"),
                            value: valueDivisi,
                            onChanged: (newValue){
                              setState(() {
                                valueDivisi = newValue;
                              });
                            },
                            items: divisi.map((valueItem) {
                              return DropdownMenuItem(
                                value: valueItem,
                                child: Text(valueItem),
                              );
                            }).toList(),
                          ),

                          // DIVISI
                          TextFormField(
                            controller: _roleController,
                            decoration: InputDecoration(labelText: "divisi"),
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Field is required";
                              }
                              return null;
                            },
                          ),

                          // EMAIL
                          TextFormField(
                            controller: _emailContoller,
                            cursorColor: Colors.black,
                            style: TextStyle(fontSize: 12),
                            keyboardType:
                            TextInputType.emailAddress,
                            decoration: new InputDecoration(
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
                                contentPadding: EdgeInsets.only(
                                    left: 24.0, right: 24.0),
                                hintStyle: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF000000)
                                        .withOpacity(0.15)),
                                hintText: "email",
                                errorBorder:
                                OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30)), borderSide: BorderSide(color: Colors.red)),
                                focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30)), borderSide: BorderSide(color: Colors.red, width: 1)),
                                errorStyle: TextStyle(fontSize: 10)),
                            obscureText: false,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Field is required";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _authData['email'] = value;
                            },
                          ),

                          // PASSWORD
                          TextFormField(
                            controller: _passwordController,
                            decoration: InputDecoration(labelText: "password"),
                            obscureText: true,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Field is required";
                              } else if (value.length < 6) {
                                return "Password at least 6 characters";
                              }
                              return null;
                            },
                          ),

                          RaisedButton(
                            child: Text("Sign Up"),
                            onPressed: () {
                              _signUp();
                            },
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              margin: EdgeInsets.only(bottom: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Don't have an account?",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color:
                                            Color(0xFF000000).withOpacity(.25)),
                                  ),
                                  FlatButton(
                                    child: Text("Sign In"),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  loginPage()));
                                    },
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
            )
          ],
        ));
  }
}
