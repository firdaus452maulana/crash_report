import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'http_exception.dart';

class Authentication with ChangeNotifier {
  Future<void> signUp(String email, String password) async {
    const URL =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDQRx03x4N9EYUun3R7mkY6zMozKPIENm4';

    try {
      final response = await http.post(URL,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));

      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }

//      print(responseData);

    } catch (error) {
      throw error;
    }
  }

  Future<void> signIn(String email, String password) async {
    const URL =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDQRx03x4N9EYUun3R7mkY6zMozKPIENm4';

    try {
      final response = await http.post(URL,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));

      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }

//      print(responseData);

    } catch (error) {
      throw error;
    }
  }
}
