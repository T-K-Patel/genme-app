import 'package:flutter/material.dart';
import 'package:genme_app/widget/custom_app_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Using MediaQuery to take the entire height
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 18, 21, 114),
          shape: BoxShape.rectangle,
        ),
        child: SingleChildScrollView(
          clipBehavior: Clip.none,
          child: Column(
            children: [
              const CustomAppBar(),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Medicine Name Label
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Name of the Medicine',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Medicine Name Input Field
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Enter the Name...",
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                            width: 2,
                          ),
                        ),
                        filled: true,
                        contentPadding: const EdgeInsets.all(16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: const Color.fromARGB(255, 240, 240, 240),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 32),

                    // Quantity Label
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Quantity',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Quantity Input Field
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Enter quantity...",
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                            width: 2,
                          ),
                        ),
                        filled: true,
                        contentPadding: const EdgeInsets.all(16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: const Color.fromARGB(255, 240, 240, 240),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 40),

                    // Add to Cart Button
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // Add to cart Logic here
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 60),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          'ADD TO CART',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // const CircularProgressIndicator()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
