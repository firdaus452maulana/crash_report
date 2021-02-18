import 'package:crash_report/homePage.dart';
import 'package:crash_report/registerPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class loginPage extends StatelessWidget {
  String _email, _password;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                      height: 480,
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
                                    TextFormField(
                                      decoration: new InputDecoration(
                                          fillColor: Colors.white,
                                          border: InputBorder.none,
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30)),
                                              borderSide: BorderSide(
                                                  color: Color(0xFF000000)
                                                      .withOpacity(0.25))),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30)),
                                              borderSide: BorderSide(
                                                  color: Color(0xFF031F4B))),
                                          filled: true,
                                          contentPadding: EdgeInsets.only(
                                              bottom: 10.0,
                                              left: 24.0,
                                              right: 24.0),
                                          hintStyle: TextStyle(fontSize: 12),
                                          hintText: "email"),
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "Field is required";
                                        }
                                        return null;
                                      },
                                      onSaved: (value) => _email = value,
                                    ),

                                    SizedBox(height: 16),

                                    TextFormField(
                                      decoration: new InputDecoration(
                                          fillColor: Colors.white,
                                          border: InputBorder.none,
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30)),
                                              borderSide: BorderSide(
                                                  color: Color(0xFF000000)
                                                      .withOpacity(0.25))),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30)),
                                              borderSide: BorderSide(
                                                  color: Color(0xFF031F4B))),
                                          filled: true,
                                          contentPadding: EdgeInsets.only(
                                              bottom: 10.0,
                                              left: 24.0,
                                              right: 24.0),
                                          hintStyle: TextStyle(fontSize: 12),
                                          hintText: "password"),
                                      obscureText: true,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "Field is required";
                                        }
                                        return null;
                                      },
                                      onSaved: (value) => _password = value,
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
                                    SizedBox(height: 24),
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
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
                                ],
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

/*Future<void> _submit() async {
    final formState = _formKey.currentState;
    if(formState.validate()){
      formState.save();
      try{
        AuthResult result =  await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        FirebaseUser user = result.user;
        Navigator.push(context, MaterialPageRoute(builder: (context) => homePage()));
      }catch(e){
        print(e.message);
      }
    }
  }*/
}
