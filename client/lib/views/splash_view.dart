import 'package:client/providers/auth_provider.dart';
import 'package:client/views/home_view.dart';
import 'package:client/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class SplashView extends StatelessWidget {
  static String routeName = '/splash';
  @override
  Widget build(BuildContext context) {
    final bool isLogggedin = Provider.of<AuthProvider>(context).isLoggedin;
    if (isLogggedin != null) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (isLogggedin == false) {
          Navigator.pushReplacementNamed(context, HomeView.routeName);
        } else if (isLogggedin == true) {
          Navigator.pushReplacementNamed(context, ProfileView.routeName);
        }
      });
    }
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        alignment: Alignment.center,
        child: Text(
          'Dyma',
          style: TextStyle(
            fontSize: 45,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
