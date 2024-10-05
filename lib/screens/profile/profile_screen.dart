import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Picture and Name
              Row(
                children: [
                  // Profile Image
                  CircleAvatar(
                    radius: screenWidth * 0.12, // Responsive avatar size
                    backgroundImage: const NetworkImage(
                        'https://imgv3.fotor.com/images/slider-image/A-clear-image-of-a-woman-wearing-red-sharpened-by-Fotors-image-sharpener.jpg'), // Replace with actual image URL
                  ),
                  SizedBox(width: screenWidth * 0.05), // Space between image and text

                  // Name and Username
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Krish',
                        style: TextStyle(
                          fontSize: screenWidth * 0.07, // Responsive font size
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '@Krish_IITD',
                        style: TextStyle(
                          fontSize: screenWidth * 0.04, // Responsive font size
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.03), // Space between rows

              // Profile Details
              buildProfileDetail(context, 'Gender', 'Male'),
              buildProfileDetail(context, 'Legal Name', 'Krish'),
              buildProfileDetail(context, 'Username', '@Krish_IITD'),
              buildProfileDetail(context, 'GST Number', '(307) 555-0133'),
              buildProfileDetail(context, 'BTN', '(307) 555-0133'),
              buildProfileDetail(context, 'DLN', '(307) 555-0133'),
              buildProfileDetail(context, 'PAN', '(307) 555-0133'),
              buildProfileDetail(context, 'Address', 'abcd Gully, Delhi, India - 10012'),
            ],
          ),
        ),
      ),
    );
  }

  // Method to build each profile detail row
  Widget buildProfileDetail(BuildContext context, String label, String value) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: screenWidth * 0.04, // Responsive font size
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: TextStyle(
                fontSize: screenWidth * 0.04, // Responsive font size
                color: Colors.grey,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
