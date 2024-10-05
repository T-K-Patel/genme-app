import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genme_app/routes/router.dart';
import 'package:genme_app/state/auth/auth_bloc.dart';
import 'package:genme_app/state/auth/auth_provider.dart';
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
            create: (context) => AuthBloc(AuthProvider())..add(const AuthEventInitialize()),
          ),
          BlocProvider(
            create: (context) => ProfileBloc(ProfileProvider())..add(const ProfileEventInitialize()),
          ),
        ],
        child: MaterialApp.router(
          // theme: ThemeData(fontFamily: 'SF_Pro_Display', useMaterial3: false),
          title: 'Genme',
          debugShowCheckedModeBanner: false,
          routerConfig: router,
          builder: (context, child) {
            return BlocListener<AuthBloc, AuthState>(
              listener: (context, state) => {routerState.changeAuthState(state)},
              child: child,
            );
          },
        ),
    );
  }
}
