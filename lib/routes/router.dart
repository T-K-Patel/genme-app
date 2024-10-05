import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:genme_app/components/drawer_wrapper.dart';
import 'package:genme_app/models/router_state.dart';
import 'package:genme_app/screens/Home.dart';
import 'package:genme_app/screens/LoginScreen.dart';
import 'package:genme_app/screens/cart/cart_screen.dart';
import 'package:genme_app/screens/orders/order_detail_screen.dart';
import 'package:genme_app/screens/orders/orders_screen.dart';
import 'package:genme_app/screens/profile/profile_screen.dart';
import 'package:genme_app/screens/search_screen.dart';
import 'package:genme_app/screens/splash_screen.dart';
import 'package:genme_app/state/auth/auth_bloc.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();
final drawerKey = GlobalKey<ScaffoldState>();

RouterState routerState = RouterState();

GoRouter router = GoRouter(
  initialLocation: '/splash',
  navigatorKey: _rootNavigatorKey,
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return DrawerWrapper(
          routerState: state,
          child: child,
        );
      },
      routes: [
        GoRoute(
          path: "/",
          builder: (context, state) => const HomeScreen(),
          routes: [
            GoRoute(
              path: "profile",
              builder: (context, state) => const ProfileScreen(),
            ),
          ]
        ),
        GoRoute(
          path: '/search',
          builder: (context, state) => const SearchScreen(),
        ),
        GoRoute(
          path: "/orders",
          builder: (context, state) => const OrdersScreen(),
          routes: [
            GoRoute(
              path: "/:id",
              builder: (context, state) => OrderDetailScreen(id:state.pathParameters['id']!),
            ),
          ],
        ),
        GoRoute(
          path: "/cart",
          builder: (context, state) => const CartScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/login/client',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),

  ],
  refreshListenable: routerState,
  redirect: (context,state) {
    if (routerState.redir!= null) {
      return routerState.redir;
    }
    AuthState authState = routerState.authState;
    if (authState is AuthStateInitial) {
      return '/login/client';
    }
    if(authState is AuthStateLoggedIn&&(
    state.fullPath == '/login/client' ||
    state.fullPath == '/splash'
    )) {
      return '/';
    }
    //
    if(authState is AuthStateLoggedOut&&(
    state.fullPath != '/login/client'&&
    state.fullPath != '/splash'
    )) {
      return '/login/client';
    }

    return null;
  },
);
