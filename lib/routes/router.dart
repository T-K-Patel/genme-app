import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:genme_app/state/orderdetail/order_detail_bloc.dart';
import 'package:genme_app/state/orderdetail/order_detail_event.dart';
import 'package:genme_app/state/orders/orders_bloc.dart';
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
            ]),
        GoRoute(
          path: '/search',
          builder: (context, state) => const SearchScreen(),
        ),
        GoRoute(
          path: "/orders",
          builder: (context, state) {
            return BlocProvider.value(
              value: BlocProvider.of<OrdersBloc>(context),
              child: const OrdersScreen(),
            );
          },
          routes: [
            GoRoute(
              path: ":id",
              builder: (context, state) {
                final id = state.pathParameters['id']!;

                // Access the already provided OrderDetailBloc instance and trigger the event
                // context.read<OrderDetailBloc>().add(FetchOrderDetail(id));

                return OrderDetailScreen(id: id);
              },
            ),

            // GoRoute(
            //   path: ":id",
            //   builder: (context, state) {
            //     final id = state.pathParameters['id']!;
            //     return BlocProvider(
            //       // Use the existing OrderDetailBloc provided by MyApp
            //       create: (context) => OrderDetailBloc(
            //         BlocProvider.of<OrderDetailBloc>(context).provider,
            //       )..add(FetchOrderDetail(id)),
            //       child: OrderDetailScreen(id: id),
            //     );
            //   },
            // ),
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
  redirect: (context, state) {
    if (routerState.redir != null) {
      return routerState.redir;
    }
    AuthState authState = routerState.authState;
    if (authState is AuthStateUninitialized) {
      if (state.fullPath != "/splash") {
        return "/splash";
      }
      return null;
    }
    if (authState is AuthStateInitial) {
      if (state.fullPath == '/login/client') {
        return null;
      }
      return '/login/client';
    }
    if (authState is AuthStateLoggedIn &&
        (state.fullPath == '/login/client' || state.fullPath == '/splash')) {
      return '/';
    }
    
    if (authState is AuthStateLoggedOut &&
        (state.fullPath != '/login/client' && state.fullPath != '/splash')) {
      return '/login/client';
    }

    return null;
  },
);
