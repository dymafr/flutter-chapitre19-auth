import 'package:flutter/widgets.dart';

class SigninForm {
  String email;
  String password;
  SigninForm({
    @required this.email,
    @required this.password,
  });

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }
}
