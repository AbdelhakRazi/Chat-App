import 'package:chat_app/main.dart';
import 'package:chat_app/views/routes/routes_names.dart';
import 'package:chat_app/views/screens/ChatScreens/SearchScreen.dart';
import 'package:chat_app/views/screens/Landing/ChooseScreen.dart';
import 'package:chat_app/views/screens/authPages/Login..dart';
import 'package:chat_app/views/screens/authPages/SignUp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // home
      case AppRoutes.login:
        return _pageAnimatedRoute(Login(), settings);
      case AppRoutes.signup:
        return _pageAnimatedRoute(SignUp(), settings);
      case AppRoutes.choose:
        return _pageAnimatedRoute(ChooseScreen(), settings);
      case AppRoutes.search:
        return _pageAnimatedRoute(SearchScreen(), settings);
      // default
      default:
        return _pageAnimatedRoute(MyApp(), settings);
    }
  }

  /// Create Custom Transition for Navigation
  static Route<dynamic> _pageAnimatedRoute(
      Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  /// Navigation Without Transition (Animtaion)
  static Route<dynamic> _pageSimpleRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, _, __) => page,
    );
  }

  ///Navigation With IOS Transition
  static Route<dynamic> _pageCupertino(Widget page, RouteSettings settings) {
    return CupertinoPageRoute(builder: (_) => page, settings: settings);
  }
}
