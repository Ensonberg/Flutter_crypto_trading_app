import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ravenpay_assessment/features/home/presentation/screens/home_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();
final _aristNavigatorKey = GlobalKey<NavigatorState>();
final router = GoRouter(
    initialLocation: Routes.HOMEPAGE,
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    restorationScopeId: "app",
    routes: [
      GoRoute(
        path: Routes.HOMEPAGE,
        name: Routes.HOMEPAGE,
        builder: (context, state) => const HomeScreen(),
      )
    ]);

abstract class Routes {
  Routes._();
  static const HOMEPAGE = "/homePage";
}
