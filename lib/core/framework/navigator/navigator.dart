import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

import '../../../injectable.dart';

final navigator = getIt<NavigationHelper>();

@LazySingleton()
class NavigationHelper {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static final navigatorContext =
      navigator.navigatorKey.currentState?.overlay?.context;

  Future<dynamic> push({required Widget page}) {
    return navigatorKey.currentState!.push(animateRoute(page: page));
  }

  Future<dynamic> pushReplace({required Widget page}) {
    return navigatorKey.currentState!.pushReplacement(animateRoute(page: page));
  }

  Future<dynamic> pushAndClearStack({required Widget page}) {
    return navigatorKey.currentState!
        .pushAndRemoveUntil(animateRoute(page: page), (route) {
      return false;
    });
  }

  void popUntil() {
    navigatorKey.currentState!.popUntil((route) {
      return route.isFirst;
    });
  }

  void pop({dynamic result}) {
    return navigatorKey.currentState!.pop(result);
  }
}

Route animateRoute({required Widget page}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(
        CurveTween(
          curve: curve,
        ),
      );
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
