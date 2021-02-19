import 'package:crash_report/models/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future createNewUser(String name, String username, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      await DatabaseManager().userSetup(name, username, user.uid);
      return user;
    } catch (e) {
      print(e.toString());
    }
  }
}

/*class Authentication with ChangeNotifier {
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
}*/
