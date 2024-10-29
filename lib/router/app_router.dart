import 'package:favmusic/screens/home_page.dart';
import 'package:favmusic/screens/login_page.dart';
import 'package:favmusic/screens/main_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class AppRouter{
static final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return  LoginPage();
      },
      routes: <RouteBase>[
         GoRoute(
          path: 'HomePage',
          builder: (BuildContext context, GoRouterState state) {
            return  HomePage();
          },
        ),
        GoRoute(
          path: 'MainPage',
          builder: (BuildContext context, GoRouterState state) {
            return  MainPage();
          },
        ),
      ],
    ),
  ],
);
}