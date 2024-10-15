import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genme_app/routes/router.dart';
import 'package:genme_app/services/notification_service.dart';
import 'package:genme_app/state/auth/auth_bloc.dart';
import 'package:genme_app/state/auth/auth_provider.dart';
import 'package:genme_app/state/orderdetail/order_detail_bloc.dart';
import 'package:genme_app/state/orderdetail/order_detail_provider.dart';
import 'package:genme_app/state/orderdetail/order_detail_state.dart';
import 'package:genme_app/state/orders/orders_bloc.dart';
import 'package:genme_app/state/orders/orders_provider.dart';
import 'package:genme_app/state/profile/profile_bloc.dart';
import 'package:genme_app/state/profile/profile_provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (context) =>
              AuthBloc(AuthProvider())..add(const AuthEventCheck()),
        ),
        BlocProvider(
            lazy: false, create: (context) => ProfileBloc(ProfileProvider())
            // ..add(const ProfileEventInitialize()),
            ),
        BlocProvider(
          lazy: false,
          create: (context) =>
              OrdersBloc(OrderProvider()), // Initialize OrdersBloc
        ),
        BlocProvider(
          lazy: false,
          create: (context) => OrderDetailBloc(OrderDetailProvider()),
        ),
      ],
      child: MaterialApp.router(
        scaffoldMessengerKey: NotificationService.messengerKey,
        title: 'Genme',
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        builder: (context, child) {
          return BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              routerState.changeAuthState(state);
            },
            child: BlocListener<ProfileBloc, ProfileState>(
              listener: (context, state) {
                if (state is ProfileStateAuthError) {
                  context.read<AuthBloc>().add(const AuthEventLogout());
                }
              },
              child: BlocListener<OrdersBloc, OrdersState>(
                  listener: (context, state) {
                    if (state is OrderStateAuthError) {
                      context.read<AuthBloc>().add(const AuthEventLogout());
                    }
                  },
                  child: BlocListener<OrderDetailBloc, OrderDetailState>(
                    listener: (context, state) {
                      if (state is OrderDetailStateAuthError) {
                        context.read<AuthBloc>().add(const AuthEventLogout());
                      }
                    },
                    child: child,
                  )),
            ),
          );
        },
      ),
    );
  }
}
