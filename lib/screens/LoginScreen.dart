import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genme_app/services/notification_service.dart';
import 'package:genme_app/state/auth/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

        // double screenWidth = MediaQuery.of(context).size.width;
    var orientation = MediaQuery.of(context).orientation;

    bool isPortrait = orientation == Orientation.portrait;

    return SafeArea(
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthStateError) {
            NotificationService.showSnackBar(
              state.exception.toString(),
              duration: const Duration(seconds: 2),
              backgroundColor: Colors.red,
              textStyle: const TextStyle(color: Colors.white),
            );
          }
        },
        child: Scaffold(
          body: Stack(
            children: [
              // SingleChildScrollView should come before the Positioned element
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                        height: screenHeight *
                            0.30), // Space to move form below the circle
                    Padding(
                      padding: EdgeInsets.all(screenWidth * 0.05),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Email Address Label
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Username',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.015),
                          // Email Address Input Field
                          TextField(
                            controller: usernameController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.email_outlined),
                              hintText: "Enter your username...",
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: Colors.blue,
                                  width: 2,
                                ),
                              ),
                              filled: true,
                              contentPadding:
                                  EdgeInsets.all(screenWidth * 0.04),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide.none,
                              ),
                              fillColor:
                                  const Color.fromARGB(255, 240, 240, 240),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: screenHeight * 0.035),

                          // Password Label
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Password',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.015),
                          // Password Input Field
                          TextField(
                            controller: passwordController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock_outline),
                              hintText: "Enter your password...",
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: Colors.blue,
                                  width: 2,
                                ),
                              ),
                              filled: true,
                              contentPadding:
                                  EdgeInsets.all(screenWidth * 0.04),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide.none,
                              ),
                              fillColor:
                                  const Color.fromARGB(255, 240, 240, 240),
                            ),
                            obscureText: true,
                          ),
                          SizedBox(height: screenHeight * 0.065),

                          // Sign In Button
                          SizedBox(
                            width: double.infinity,
                            height: screenHeight * 0.08,
                            child: BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, state) {
                                bool isLoading = state is AuthStateLoading;

                                return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    backgroundColor:
                                        const Color.fromARGB(255, 18, 21, 114),
                                  ),
                                  onPressed: isLoading
                                      ? null // Disable the button while loading
                                      : () {
                                          context.read<AuthBloc>().add(
                                                AuthEventLogin(
                                                  username: usernameController
                                                      .text
                                                      .trim(),
                                                  password: passwordController
                                                      .text
                                                      .trim(),
                                                ),
                                              );
                                        },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (isLoading)
                                        const Center(
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.white),
                                          ),
                                        )
                                      else
                                        const Text(
                                          'Sign In',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      const SizedBox(width: 8),
                                      if (!isLoading)
                                        const Icon(Icons.arrow_forward,
                                            color: Colors.white),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),

                          SizedBox(height: screenHeight * 0.025),
                        ],
                      ),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Developed by ",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "GenMe",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          " with 💚",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.01),
                  ],
                ),
              ),
              // Positioned Circle (ClipOval) should come last
              Positioned(
                left: -screenWidth * 0.62,
                top: -screenHeight *
                    0.82, // Adjust this value to control how much the circle goes off-screen
                child: ClipOval(
                  child: Container(
                    color: Colors.black,
                    width: screenWidth *
                        2.25, // Large width to ensure the circle overflows horizontally
                    height: isPortrait ? screenHeight * 1.08 : screenHeight * 1.1, // Adjust height to control the overall shape
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.05,
                        horizontal: screenWidth * 0.55,
                      ), // Adjust padding to place content lower
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment
                            .end, // Align content at the bottom
                        children: [
                          Center(
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Center(
                            child: Text(
                              'Log in to access your personalized Medinest experience',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
