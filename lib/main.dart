import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uzuri/app/app.dart';
import 'package:uzuri/authPages/auth.dart';
import 'package:uzuri/authPages/login.dart';
import 'package:uzuri/authPages/register.dart';
import 'package:uzuri/ws/Constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    title: 'Uzuri',
    theme: ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    initialRoute: '/',
    routes: {
      "/": (context) => SplashPage(),
      "/auth": (context) => AuthPages(),
      "/login": (context) => LoginPage(),
      "/register": (context) => RegisterPage(),
      "/app": (context) => AppPage()
    },
  ));
}

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SharedPreferences.getInstance().then((SharedPreferences prefs) {
      dynamic userId =
          prefs.getInt("token") != null ? prefs.getInt("token") : false;
      bool check =
          prefs.getBool("login") != null ? prefs.getBool("login") : false;
      if (userId != false) {
        Constants.token = userId;
      }
      if (check) {
        Navigator.pushReplacementNamed(context, '/app');
      } else {
        Navigator.pushReplacementNamed(context, '/auth');
      }
    });

    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Image.asset(
            'assets/images/uzuri_logo.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
