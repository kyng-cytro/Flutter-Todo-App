import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/core/auth/functions/auth_state.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _checklogin(context);
    super.initState();
  }

  _checklogin(context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("loggedin") != null &&
        prefs.getBool("loggedin") == true) {
      try {
        await Provider.of<AuthState>(context, listen: false).checkedloggedin();
      } catch (e) {
        print(e);
        Timer(
          Duration(seconds: 3),
          () => Navigator.of(context).pushReplacementNamed("/intro"),
        );
        return;
      }
      if (Provider.of<AuthState>(context, listen: false).isLoggedIn) {
        Timer(
          Duration(seconds: 3),
          () => Navigator.of(context).pushReplacementNamed("/home"),
        );
      } else {
        Timer(
          Duration(seconds: 3),
          () => Navigator.of(context).pushReplacementNamed("/intro"),
        );
      }
      return;
    } else {
      Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacementNamed("/intro"),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffbbc2d8),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/appicon.png",
              height: 150,
            ),
            SizedBox(
              height: 40,
            ),
            SizedBox(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
