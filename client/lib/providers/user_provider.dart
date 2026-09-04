import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../models/user_model.dart';
import 'auth_provider.dart';

class UserProvider extends ChangeNotifier {
  // Changer à localhost si Web
  final String host = 'http://10.0.2.2';
  User? user;
  late AuthProvider authProvider;

  void update(AuthProvider newAuthProvider) {
    authProvider = newAuthProvider;
    if (user == null && (authProvider.isLoggedin ?? false)) {
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
        updateUser(User.fromJson(json.decode(response.body)));
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
