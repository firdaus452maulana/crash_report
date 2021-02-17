import 'package:crash_report/loginPage.dart';
import 'package:crash_report/registerPage.dart';
import 'package:flutter/material.dart';

class registerPage extends StatelessWidget {

  final GlobalKey<FormState> _formKey = GlobalKey();

  void _submit(){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Colors.blue
              ),
            ),

            Center(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17.5)
                ),
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
                            validator: (value){
                              if(value.isEmpty){
                                return "Field is required";
                              }
                              return null;
                            },
                            onSaved: (value){

                            },
                          ),

                          TextFormField(
                            decoration: InputDecoration(labelText: "username"),
                            keyboardType: TextInputType.name,
                            validator: (value){
                              if(value.isEmpty){
                                return "Field is required";
                              }
                              return null;
                            },
                            onSaved: (value){

                            },
                          ),

                          TextFormField(
                            decoration: InputDecoration(labelText: "email"),
                            keyboardType: TextInputType.name,
                            validator: (value){
                              if(value.isEmpty){
                                return "Field is required";
                              }
                              return null;
                            },
                            onSaved: (value){

                            },
                          ),

                          TextFormField(
                            decoration: InputDecoration(labelText: "password"),
                            obscureText: true,
                            validator: (value){
                              if(value.isEmpty){
                                return "Field is required";
                              }
                              return null;
                            },
                            onSaved: (value){

                            },
                          ),


                          RaisedButton(
                            child: Text("Sign Up"),
                            onPressed: (){
                              _submit();
                            },
                          ),

                          FlatButton(
                            child: Text("Sign In"),
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => loginPage()));
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        )
    );
  }
}
