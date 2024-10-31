import 'package:favmusic/model/track.dart';
import 'package:favmusic/router/authentication_wrapper.dart';
import 'package:favmusic/screens/home_page.dart';
import 'package:favmusic/screens/play_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class AppRouter{
static final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return  AuthenticationWrapper();
      },
      routes: <RouteBase>[
         GoRoute(
          path: 'HomePage',
          builder: (BuildContext context, GoRouterState state) {
            return  HomePage();
          },
        ),
         GoRoute(
          path: 'PlayPage',
          builder: (BuildContext context, GoRouterState state) {
            Track track = state.extra as Track; 
            return  PlayPage(track: track);
          },
        ),
      ],
    ),
  ],
);
}