import 'package:flutter/material.dart';
import './auth/signup_view.dart';
import './auth/signin_view.dart';

class HomeView extends StatelessWidget {
  static String routeName = '/home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        alignment: Alignment.center,
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Bienvenue sur Dyma',
              style: TextStyle(
                fontSize: 35,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
            ),
            FlatButton(
              color: Colors.grey.shade900,
              onPressed: () {
                Navigator.pushNamed(context, SignupView.routeName);
              },
              child: Text(
                'S\'inscrire',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            FlatButton(
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.pushNamed(context, SigninView.routeName);
              },
              child: Text(
                'Connexion',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
