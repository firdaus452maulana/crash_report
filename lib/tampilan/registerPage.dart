import '../models/authentication.dart';
import 'package:crash_report/tampilan/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';

class registerPage extends StatefulWidget {
  @override
  _registerPageState createState() => _registerPageState();
}

class _registerPageState extends State<registerPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  final auth = FirebaseAuth.instance;

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

  // SUBMIT
  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    try {

      UserCredential credential = await auth.createUserWithEmailAndPassword(email: _authData['email'], password: _authData['password']);
      User user = credential.user;
      user.sendEmailVerification();

      Navigator.of(context).pop();
      Navigator.push(context, MaterialPageRoute(builder: (context) => loginPage()));
      
      showToastSignUpSuccess();
    } catch (error) {
      var errorMessage = '';
      _showErrorDialog(errorMessage);
    }
  }

  void showToastSignUpSuccess() {
    Fluttertoast.showToast(
        msg: 'Sign Up Success',
        fontSize: 12,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.black);
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
                          TextFormField(
                            decoration: InputDecoration(labelText: "full name"),
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Field is required";
                              }
                              return null;
                            },
                            onSaved: (value) {},
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: "username"),
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Field is required";
                              }
                              return null;
                            },
                            onSaved: (value) {},
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: "email"),
                            keyboardType: TextInputType.emailAddress,
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
                          TextFormField(
                            decoration: InputDecoration(labelText: "password"),
                            obscureText: true,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Field is required";
                              } else if (value.length < 8) {
                                return "Password at least 8 characters";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _authData['password'] = value;
                            },
                          ),
                          RaisedButton(
                            child: Text("Sign Up"),
                            onPressed: () {
                              _submit();
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
