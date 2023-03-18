import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../../models/signup_form_model.dart';
import './signin_view.dart';
import '../../providers/auth_provider.dart';

class SignupView extends StatefulWidget {
  static const String routeName = '/signup';

  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  late SignupForm signupForm;
  FormState get form => key.currentState!;

  @override
  void initState() {
    signupForm = SignupForm(email: '', username: '', password: '');
    super.initState();
  }

  Future<void> submitForm() async {
    if (form.validate()) {
      form.save();
      final error = await Provider.of<AuthProvider>(context, listen: false)
          .signup(signupForm);
      if (error == null && mounted) {
        Navigator.pushNamed(context, SigninView.routeName);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding:
            const EdgeInsets.only(top: 50, bottom: 20, left: 20, right: 20),
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Inscription',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
            ),
            Form(
              key: key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'email',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 3),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade900,
                      filled: true,
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    onSaved: (newValue) {
                      signupForm.email = newValue!;
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                  ),
                  const Text(
                    'username',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 3),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade900,
                      filled: true,
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    onSaved: (newValue) {
                      signupForm.username = newValue!;
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                  ),
                  const Text(
                    'password',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 3),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade900,
                      filled: true,
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    onSaved: (newValue) {
                      signupForm.password = newValue!;
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    onPressed: submitForm,
                    child: const Text(
                      'S\'inscrire',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
