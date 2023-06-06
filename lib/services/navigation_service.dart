import 'dart:developer';
import 'package:flutter/material.dart';

/// [NavigationService] is a service for navigating between pages or
/// showing modals or popUps and etc.
class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  NavigationService() {
    log('Navigation service initiated');
  }

  Future<dynamic> navigateTo(String routeName,
      {Object? arguments, pushReplacement = false}) {
    if (pushReplacement) {
      return navigatorKey.currentState!
          .pushReplacementNamed(routeName, arguments: arguments);
    }
    return navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  void goBack() {
    navigatorKey.currentState!.pop();
  }

  void goBackUntilTheFirstRoute() {
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  var overlays = <OverlayEntry>[];

  void closePopUp() {
    if (overlays.isNotEmpty) {
      overlays.last.remove();
      overlays.removeLast();
    }
  }
}
