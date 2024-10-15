import 'package:flutter/material.dart';

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
  }

  @override
  Widget build(BuildContext context) {
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
