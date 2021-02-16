import 'package:flutter/material.dart';

class loginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
          )
        ),
        child: SizedBox.expand(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              // LOGO PERANG
              Container(
                margin: EdgeInsets.only(top: 64),
                child: Image.asset(
                  'assets/logo_perang.png',
                  width: 100,
                  height: 100,
                ),
              ),

              // CONTAINER LOGIN
              Container(
                margin: EdgeInsets.only(top: 32),
                width: 280,
                height: 380,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(17.5)),

                child: Column(
                  children: <Widget>[

                    // TULISAN SIGN IN
                    Container(
                      child: Text("Sign In",
                      style: new TextStyle(
                        fontFamily: 'OpenSans Bold',
                        fontSize: 24,
                      ),),
                    margin: EdgeInsets.only(top: 32),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 24, left: 32),
                      child: Row(
                        children: [
                          // TULISAN EMPLOYEE
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Employee",
                                style: TextStyle(
                                  fontFamily: 'OpenSans Bold',
                                  fontSize: 12,
                                ),),
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  width: 70,
                                  height: 2,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                          ),

                          // TULISAN TECHNICIAN
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Technician",
                                  style: TextStyle(
                                    fontFamily: 'OpenSans Bold',
                                    fontSize: 12,
                                    color: Color(0xff000000).withOpacity(.25)
                                  ),),
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  width: 70,
                                  height: 2,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: Color(0xff000000).withOpacity(.25)
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
