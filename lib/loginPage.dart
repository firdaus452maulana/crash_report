import 'package:crash_report/registerPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class loginPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey();

  void _submit() {}

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
                height: 480,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(17.5)),
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(32),
                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Text("Sign In", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
                              SizedBox(height: 24,),
                              TextFormField(
                                decoration:
                                    InputDecoration(labelText: "username"),
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
                                decoration:
                                    InputDecoration(labelText: "password"),
                                obscureText: true,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Field is required";
                                  }
                                  return null;
                                },
                                onSaved: (value) {},
                              ),


                              Align(
                                alignment: Alignment.centerRight,
                                child: FlatButton(
                                  onPressed: (){},
                                  child: Text("Forgot Password?", style: TextStyle(fontSize: 12),),
                                ),
                              ),


                              SizedBox(height: 24),

                              RaisedButton(
                                color: Color(0xFF031F4B),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
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
                              style: TextStyle(fontSize: 12, color: Color(0xFF000000).withOpacity(.25)),
                            ),
                            FlatButton(
                              padding: EdgeInsets.all(0.0),
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => registerPage()));
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
        ));
  }
}
