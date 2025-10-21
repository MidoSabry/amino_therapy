import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
StatefulNavigationShell? globalNavigationShell;

class Get {
  static BuildContext? get context => navigatorKey.currentContext;
  static NavigatorState? get navigatorState => navigatorKey.currentState;
}

List<String> documentTypes = [
  'Definition Letter',
  'Salary Domiciliation Letter',
  'Clearance Letter',
  'With Basic',
  'With Details',
];
