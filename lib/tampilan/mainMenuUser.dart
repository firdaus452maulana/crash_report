import 'package:flutter/material.dart';

enum DialogAction {save, close}

class addBarang{
  String namaAlat;
  String lokasi;
  String divisi;
}

class mainMenuUser extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          return showDialog(
              context: context,
            builder: (context) {
                return AlertDialog(
                  content: Column (
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    //posisi
                    mainAxisSize: MainAxisSize.min,
                    // untuk mengatur agar widget column mengikuti widget
                    children: <Widget>[
                      TextFormField
                    ],
                  ),
                )
            }
          );
        },
      ),
    );
  }
}
