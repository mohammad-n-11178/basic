import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  String _token;
  DateTime _expairyDate;
  String _userId;
  Timer _authTimer;

  String siteUrl = "https://edu-technology.net/main/api";

  List finalErrorsList = [];
  String error = 'there is an error.';

  bool get isAuth {
    return _token != null;
  }

  String get token {
    if (_expairyDate != null &&
        _expairyDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String get userId {
    return _userId;
  }

  Future<void> _register(
      String email,
      String password,
      String passwordconfirmation,
      String username,
      String name,
      String deviceLanguage) async {
    debugPrint("email is $email");
    debugPrint(password);
    debugPrint(passwordconfirmation);
    debugPrint(username);
    debugPrint(name);

    var headers = {
      'Content-Type': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      "X-localization": deviceLanguage,
    };
    var request = http.MultipartRequest('POST', Uri.parse('$siteUrl/register'));

    request.fields.addAll({
      'email': email,
      'password': password,
      'password_confirmation': passwordconfirmation,
      'username': username,
      'name': name,
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    try {
      if (response.statusCode == 200) {
        await response.stream.bytesToString().then((value) {
          print(value);
        });
      } else if (response.statusCode == 422) {
        finalErrorsList.clear();
        print(response.statusCode);
        print(response.reasonPhrase);
        print("here 2");
        var responseStreemed = await http.Response.fromStream(response);
        var jsonResponse = json.decode(responseStreemed.body);
        print(jsonResponse['message']);
        print("here 3");
        var errorMap = jsonResponse['errors'] as Map<String, dynamic>;
        if (errorMap.entries.isNotEmpty) {
          var errorList = errorMap.values.toList();
          errorList.forEach((element) {
            for (Object i in element) {
              finalErrorsList.add(i);
            }
          });
        }
        throw error;
      } else {
        print(response.statusCode);
        throw error;
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> _authenticateIn(
      String email, String password, String deviceLanguage) async {
    debugPrint(email);
    debugPrint(password);
    finalErrorsList.clear();
    var headers = {
      'Content-Type': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      "X-localization": deviceLanguage
    };
    var request = http.MultipartRequest('POST', Uri.parse('$siteUrl/login'));
    request.fields.addAll({
      'login': email,
      'password': password,
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    try {
      if (response.statusCode == 200) {
        await response.stream.bytesToString().then((value) {
          print(value);
          print("here 1");
        });
      } else if (response.statusCode == 401) {
        String error = 'there is an error.';
        var responseStreemed = await http.Response.fromStream(response);
        var jsonResponse = json.decode(responseStreemed.body);
        print(jsonResponse['error']);
        print("here 2");
        error = "your data is invalid.\nrewrite your details and try again";
        throw error;
      } else {
        throw error;
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> signUp(
      String email,
      String password,
      String passwordconfirmation,
      String username,
      String name,
      String deviceLanguage) async {
    return _register(
        email, password, passwordconfirmation, username, name, deviceLanguage);
  }

  Future<void> logIn(
      String email, String password, String deviceLanguage) async {
    return _authenticateIn(email, password, deviceLanguage);
  }

  Future<bool> tryAutoLogIn() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey("userData")) return false;

    final extractedData =
        json.decode(prefs.getString("userData")) as Map<String, Object>;

    // because we stored the expiryDate as a String now we want to convert it to Date
    final expiryDate = DateTime.parse(extractedData['expiryDate']);

    if (expiryDate.isBefore(DateTime.now())) return false;

    _token = extractedData['token'];
    _userId = extractedData['userId'];
    _expairyDate = expiryDate;

    notifyListeners();
    _autoLogout();
    return true;
  }

  Future<void> logOut() async {
    _token = null;
    _userId = null;
    _expairyDate = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpiry = _expairyDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logOut);
  }
}




  // final url = "http://main.edu-technology.net/public/api/$urlSegment";
  // try {
  //   final res = await http.post(url,
  //       body: json.encode({
  //         'email': email,
  //         'password': password,
  //         'returnSecureToken': true,
  //       }));
  //   final responseData = json.decode(res.body);
  //   if (responseData['error'] != null) {
  //     HttpException(responseData['error']['message']);
  //   }
  //   _token = responseData['idToken'];
  //   _userId = responseData['localId'];
  //   _expairyDate = DateTime.now()
  //       .add(Duration(seconds: int.parse(responseData['expiresIn'])));
  //   _autoLogout();

  //   notifyListeners();

  //   final prefs = await SharedPreferences.getInstance();
  //   String userData = json.encode({
  //     'token': _token,
  //     'userId': _userId,
  //     'expiryDate': _expairyDate.toIso8601String()
  //   });
  //   prefs.setString('userData', userData);
  // } catch (e) {
  //   throw e;
  // }
