import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  // Replace with actual user data
  final String username = 'Priyangshu';
  final String userProfileImageUrl = 'URL_TO_USER_PROFILE_IMAGE';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Track Vision'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50, // Adjust the size of the profile picture
              backgroundImage: AssetImage('asset/profile.png'),
            ),
            SizedBox(height: 20),
            Text(
              'Hi $username',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Center(
                child: Card(
                  elevation: 20, // Increase the elevation for a stronger shadow
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        16.0), // Rounded corners with a radius of 16
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.asset(
                      "asset/map.png", // Replace with the path to your asset image
                      width: double
                          .infinity, // Make the image take full width of the card
                      height: 500, // Adjust the height of the image
                      fit: BoxFit
                          .cover, // Maintain aspect ratio and cover the card
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
