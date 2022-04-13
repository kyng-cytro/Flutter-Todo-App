import 'package:flutter/material.dart';
import 'package:todo_app/core/auth/pages/intro_screen.dart';
import 'package:todo_app/general/pages/home.dart';

class RouteGen {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/intro':
        return MaterialPageRoute(builder: (_) => IntroPage());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomePage());
      default:
        return MaterialPageRoute(builder: (_) => IntroPage());
    }
  }
}
