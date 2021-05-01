import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/http_exception.dart';

class AuthProvider with ChangeNotifier {
  String _token;
  DateTime _expairyDate;
  String _userId;
  Timer _authTimer;

  String siteUrl = "https://edu-technology.net/main/public/api";

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

  Future<void> _authenticateUp(String email, String password,
      String passwordconfirmation, String username, String name,
      {String phonenumber}) async {
    debugPrint(email);
    debugPrint(password);
    debugPrint(passwordconfirmation);
    debugPrint(username);
    debugPrint(name);
    debugPrint(phonenumber);

    var headers = {
      'Content-Type': 'application/json',
      'X-Requested-With': 'XMLHttpRequest'
    };

    var request = http.MultipartRequest('POST', Uri.parse('$siteUrl/register'));

    request.fields.addAll({
      'email': email,
      'password': password,
      'password_confirmation': passwordconfirmation,
      'username': username,
      'name': name,
      'phone_number': phonenumber
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print("reasonPhrase is => ${response.reasonPhrase}");
      print("statuscode is  => ${response.statusCode}");
      print("contentLength is  => ${response.contentLength}");
      print("isRedirect is  => ${response.isRedirect}");
      print("persistentConnection is  => ${response.persistentConnection}");
      print("request is  => ${response.request}");
      print("stream is  => ${response.stream}");
    }
  }

  Future<void> _authenticateIn(String email, String password) async {
    debugPrint(email);
    debugPrint(password);

    var headers = {
      'Content-Type': 'application/json',
      'X-Requested-With': 'XMLHttpRequest'
    };
    var request = http.MultipartRequest('POST', Uri.parse('$siteUrl/login'));
    request.fields.addAll({
      'email': email,
      'password': password,
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print("reasonPhrase is => ${response.reasonPhrase}");
      print("statuscode is  => ${response.statusCode}");
      print("contentLength is  => ${response.contentLength}");
      print("isRedirect is  => ${response.isRedirect}");
      print("persistentConnection is  => ${response.persistentConnection}");
      print("request is  => ${response.request}");
      print("stream is  => ${response.stream}");
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

  Future<void> signUp(String email, String password,
      String passwordconfirmation, String username, String name,
      {String phonenumber}) async {
    return _authenticateUp(
        email, password, passwordconfirmation, username, name,
        phonenumber: phonenumber);
  }

  Future<void> logIn(String email, String password) async {
    return _authenticateIn(email, password);
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
