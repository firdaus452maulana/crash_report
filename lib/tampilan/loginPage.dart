import 'package:crash_report/tampilan/homePage.dart';
import 'package:crash_report/tampilan/registerPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/authentication.dart';
import 'package:provider/provider.dart';

class loginPage extends StatefulWidget {
  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  // SUBMIT
  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    try {
      await Provider.of<Authentication>(context, listen: false)
          .signIn(_authData['email'], _authData['password']);
    } catch (error) {
      var errorMessage = 'Email atau password salah!';
      _showErrorDialog(errorMessage);
    }
  }

  // ERROR DIALOGBOX
  void _showErrorDialog(String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: Text(
                "Something went wrong.",
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo_perang.png',
                    scale: 16,
                  ),
                  SizedBox(
                    height: 28,
                  ),
                  Container(
                    child: Container(
                      margin: EdgeInsets.only(left: 32, right: 32),
                      height: 380,
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
                            padding: EdgeInsets.all(32),
                            child: Form(
                              key: _formKey,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Text(
                                      "Sign In",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24),
                                    ),
                                    SizedBox(
                                      height: 24,
                                    ),

                                    // EMAIL
                                    Container(
                                      child: TextFormField(
                                        cursorColor: Colors.black,
                                        style: TextStyle(fontSize: 12),
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: new InputDecoration(
                                            fillColor: Colors.white,
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30)),
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
                                                    .withOpacity(0.15)),
                                            hintText: "email",
                                            errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.all(Radius.circular(30)),
                                                borderSide: BorderSide(color: Colors.red)),
                                            focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30)), borderSide: BorderSide(color: Colors.red, width: 1)),
                                            errorStyle: TextStyle(fontSize: 12)),
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
                                    ),

                                    SizedBox(height: 16),

                                    // PASSWORD
                                    Container(
                                      child: TextFormField(
                                        cursorColor: Colors.black,
                                        style: TextStyle(fontSize: 12),
                                        decoration: new InputDecoration(
                                          fillColor: Colors.transparent,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(30),
                                            ),
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
                                          filled: true,
                                          contentPadding: EdgeInsets.only(
                                              left: 24.0, right: 24.0),
                                          hintStyle: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFF000000)
                                                  .withOpacity(0.15)),
                                          hintText: "password",
                                          errorBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30)),
                                              borderSide: BorderSide(
                                                  color: Colors.red)),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(30)),
                                                  borderSide: BorderSide(
                                                      color: Colors.red,
                                                      width: 1)),
                                          errorStyle: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        obscureText: true,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return "Field is required";
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          _authData['password'] = value;
                                        },
                                      ),
                                    ),

                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: FlatButton(
                                        onPressed: () {},
                                        child: Text(
                                          "Forgot Password?",
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
                                          "Sign In",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                      ),
                                      onPressed: () {
                                        _submit();
                                      },
                                    ),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Don't have an account?",
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
                                              "Sign Up",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          registerPage()));
                                            },
                                          ),
                                        ),
                                      ],
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
          ],
        ));
  }
}
