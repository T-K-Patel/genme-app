import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:genme_app/state/auth/auth_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  // fetch data from api and navigate to login screen

  @override
  void initState() {
    super.initState();
    // context.read<AuthBloc>().add(const AuthEventCheck());
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("SPLASH SCREEN BUILT WITH NO DOUBT\n,\n.\nk\nm\ny\ng\nf\nf");
    }
    // Screen with gradient background and genme text in center
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.deepPurple, Color.fromARGB(255, 18, 21, 114)]),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'genme',
                  style: TextStyle(
                    fontSize: 56,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CircularProgressIndicator(
                color: Colors.white,
                strokeCap: StrokeCap.round,
              )
            ],
          ),
        ),
      ),
    );
  }
}
