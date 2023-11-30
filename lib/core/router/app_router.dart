// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:base_templet/core/dependency_injection/injection_container.dart';
import 'package:base_templet/core/session_management/session.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter goRouter = GoRouter(
    navigatorKey: injection<GlobalKey<NavigatorState>>(),
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: "/",
        name: "root",
        redirect: (context, state) {
          if ((injection<GlobalSession>().getToken()?.isEmpty ?? true)) {
            return "/auth";
          } else {
            return "/home";
          }
        },
      ),
    ],
  );
}
