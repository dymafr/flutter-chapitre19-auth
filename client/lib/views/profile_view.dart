import 'package:client/models/user_model.dart';
import 'package:client/providers/auth_provider.dart';
import 'package:client/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_view.dart';

class ProfileView extends StatelessWidget {
  static const String routeName = '/profile';

  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: ListView(
          reverse: true,
          children: [
            ListTile(
              tileColor: Theme.of(context).primaryColor,
              title: const Text(
                'Déconnexion',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Provider.of<AuthProvider>(context, listen: false).signout();
                Navigator.pushNamed(context, HomeView.routeName);
              },
            )
          ],
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: user != null
            ? Text(
                user.username,
                style: const TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
