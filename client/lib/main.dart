import 'package:client/providers/auth_provider.dart';
import 'package:client/providers/user_provider.dart';
import 'package:client/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import './views/home_view.dart';
import './views/not_found_view.dart';
import './views/auth/signin_view.dart';
import './views/auth/signup_view.dart';
import './views/profile_view.dart';

void main() {
  runApp(MyAuth());
}

class MyAuth extends StatefulWidget {
  @override
  _MyAuthState createState() => _MyAuthState();
}

class _MyAuthState extends State<MyAuth> {
  final AuthProvider authProvider = AuthProvider();

  @override
  void initState() {
    authProvider.initAuth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: authProvider),
        ChangeNotifierProxyProvider<AuthProvider, UserProvider>(
            create: (_) => UserProvider(),
            update: (_, authProvider, oldUserProvider) {
              oldUserProvider.update(authProvider);
              return oldUserProvider;
            }),
      ],
      child: MaterialApp(
        title: 'my auth',
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        home: SplashView(),
        onGenerateRoute: (settings) {
          if (settings.name == HomeView.routeName) {
            return MaterialPageRoute(builder: (_) => HomeView());
          } else if (settings.name == SigninView.routeName) {
            return MaterialPageRoute(builder: (_) => SigninView());
          } else if (settings.name == SignupView.routeName) {
            return MaterialPageRoute(builder: (_) => SignupView());
          } else if (settings.name == ProfileView.routeName) {
            return MaterialPageRoute(builder: (_) => ProfileView());
          } else {
            return null;
          }
        },
        onUnknownRoute: (settings) =>
            MaterialPageRoute(builder: (_) => NotFoundView()),
      ),
    );
  }
}
