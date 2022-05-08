import 'package:flutter/material.dart';
import 'package:tiktok_clone/views/screens/screens.dart';

MaterialPageRoute onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SignUpScreen.route:
      return MaterialPageRoute(
        builder: (_) => SignUpScreen(),
      );
    case LoginScreen.route:
      return MaterialPageRoute(
        builder: (_) => LoginScreen(),
      );
    case HomeScreen.route:
      return MaterialPageRoute(
        builder: (_) => const HomeScreen(),
      );

    default:
      return MaterialPageRoute(
        builder: (_) => const UnkownScreen(),
      );
  }
}
