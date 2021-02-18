import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Authentication{

  Future<void> signUp(String fullName, String username, String email, String password) async {

    const URL = 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithCustomToken?key=AIzaSyDQRx03x4N9EYUun3R7mkY6zMozKPIENm4';

    final response = await http.post(URL, body: json.encode(
      {
        'email' : email,
        'password' : password,
        'returnSecureToken' : true,
      }
    ));

    final responseData = json.decode(response.body);
    print(responseData);

  }
}