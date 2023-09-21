import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../config.dart';

class ProfileScreen extends StatefulWidget {
  final String authToken;

  ProfileScreen({required this.authToken});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? userProfile;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    try {
      final userData = await fetchUserProfile(widget.authToken);
      setState(() {
        userProfile = userData;
      });
    } catch (error) {
      // Handle error (e.g., show an error message)
      print('Error loading user profile: $error');
    }
  }

  Future<Map<String, dynamic>> fetchUserProfile(String authToken) async {
    try {
      final response = await http.get(
        Uri.parse(registration), // Replace with your actual backend URL
        headers: {
          "Authorization": "Bearer $authToken"
        }, // Send the JWT token for authentication
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> userData = json.decode(response.body);
        return userData;
      } else {
        throw Exception('Failed to fetch user profile');
      }
    } catch (error) {
      throw error.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'asset/login_wallpaper.jpg',
          height: MediaQuery.of(context).size.height / 3,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),

        // Profile Avatar
        Container(
          height: MediaQuery.of(context).size.height / 3,
          width: MediaQuery.of(context).size.width,
          color: Colors.transparent,
          child: Center(
            child: CircleAvatar(
              radius: 90,
              backgroundImage: AssetImage('asset/profile.png'),
              // You can replace this with the user's profile picture from the userProfile data
            ),
          ),
        ),

        // Content
        Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 3),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name: ${userProfile?['username'] ?? 'Loading...'}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Email: ${userProfile?['email'] ?? 'Loading...'}',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Map History:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount:
                            10, // Replace with the actual number of posts
                        itemBuilder: (context, index) {
                          // Your list item builder here
                          // Example: Display map history based on userProfile data
                          // userProfile?['mapHistory'][index]['mapName']
                          // userProfile?['mapHistory'][index]['date']
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
