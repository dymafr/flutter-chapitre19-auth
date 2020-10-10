import 'package:client/models/user_model.dart';
import 'package:client/providers/auth_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserProvider with ChangeNotifier {
  final String host = 'http://10.0.2.2';
  User user;
  AuthProvider authProvider;

  update(AuthProvider newAuthProvider) {
    authProvider = newAuthProvider;
    if (user == null && authProvider.isLoggedin) {
      fetchCurrentUser();
    }
  }

  Future<void> fetchCurrentUser() async {
    http.Response response = await http.get(
      '$host/api/user/current',
      headers: {'authorization': 'Bearer ${authProvider.token}'},
    );
    if (response.statusCode == 200) {
      updateUser(
        User.fromJson(
          json.decode(response.body),
        ),
      );
    }
  }

  void updateUser(User updatedUser) {
    user = updatedUser;
    notifyListeners();
  }
}
