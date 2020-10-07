import 'dart:async';

import 'package:client/models/signin_form_model.dart';
import 'package:client/models/user_model.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/signup_form_model.dart';

class AuthProvider with ChangeNotifier {
  final String host = 'http://10.0.2.2';
  final FlutterSecureStorage storage = FlutterSecureStorage();
  String token;
  Timer timer;
  bool isLoading = false;
  bool isLoggedin;

  Future<void> initAuth() async {
    try {
      String oldToken = await storage.read(key: 'token');
      if (oldToken == null) {
        isLoggedin = false;
      } else {
        token = oldToken;
        await refreshToken();
        if (token != null) {
          isLoggedin = true;
          initTimer();
        } else {
          isLoggedin = false;
        }
      }
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> refreshToken() async {
    try {
      http.Response response = await http.get(
        '$host/api/auth/refresh-token',
        headers: {'authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        token = json.decode(response.body);
        storage.write(key: 'token', value: token);
      } else {
        signout();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> signup(SignupForm signupForm) async {
    try {
      isLoading = true;
      http.Response response = await http.post(
        '$host/api/user',
        headers: {'Content-type': 'application/json'},
        body: json.encode(signupForm.toJson()),
      );
      isLoading = false;
      if (response.statusCode != 200) {
        return json.decode(response.body);
      }
      return null;
    } catch (e) {
      isLoading = false;
      rethrow;
    }
  }

  Future<dynamic> signin(SigninForm signinForm) async {
    try {
      isLoading = true;
      http.Response response = await http.post(
        '$host/api/auth',
        headers: {'Content-type': 'application/json'},
        body: json.encode(
          signinForm.toJson(),
        ),
      );
      final Map<String, dynamic> body = json.decode(response.body);
      if (response.statusCode == 200) {
        final User user = User.fromJson(body['user']);
        token = body['token'];
        storage.write(key: 'token', value: token);
        isLoggedin = true;
        initTimer();
        return user;
      } else {
        return body;
      }
    } catch (e) {
      isLoading = false;
      rethrow;
    }
  }

  void signout() {
    isLoggedin = false;
    token = null;
    storage.delete(key: 'token');
    if (timer != null) {
      timer.cancel();
    }
  }

  void initTimer() {
    timer = Timer.periodic(Duration(minutes: 10), (timer) {
      refreshToken();
    });
  }
}
