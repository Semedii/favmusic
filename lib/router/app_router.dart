import 'package:favmusic/screens/home_page.dart';
import 'package:favmusic/screens/latest_music_page.dart';
import 'package:favmusic/screens/login_page.dart';
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
      // path: '/',
      // builder: (BuildContext context, GoRouterState state) {
      //   return const HomePage();
      // },
      routes: <RouteBase>[
        GoRoute(
          path: 'LatestMusic',
          builder: (BuildContext context, GoRouterState state) {
            return  LatestMusicPage();
          },
        ),
      ],
    ),
  ],
);
}