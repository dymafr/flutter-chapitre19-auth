import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import './auth_provider.dart';
import '../models/user_model.dart';

class UserProvider extends ChangeNotifier {
  // final String host = 'http://10.0.2.2';
  final String host = 'http://localhost';
  User? user;
  late AuthProvider authProvider;

  update(AuthProvider newAuthProvider) {
    authProvider = newAuthProvider;
    if (user == null && authProvider.isLoggedin == true) {
      fetchCurrentUser();
    }
  }

  Future<void> fetchCurrentUser() async {
    try {
      http.Response response = await http.get(
        Uri.parse('$host/api/user/current'),
        headers: {'authorization': 'Bearer ${authProvider.token}'},
      );
      if (response.statusCode == 200) {
        updateUser(
          User.fromJson(
            json.decode(response.body),
          ),
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  void updateUser(User updatedUser) {
    user = updatedUser;
    notifyListeners();
  }
}
