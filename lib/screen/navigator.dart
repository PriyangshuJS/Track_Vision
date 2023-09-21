import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'first_page.dart';
import '../utils/image_upload_screen.dart';
import 'profile_sreen.dart';

class HomeScreen extends StatefulWidget {
  String userToken;
  HomeScreen({required this.userToken, super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  void navigatorBar(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  final pages = <Widget>[
    FirstPage(),
    const UploadScreen(),
    ProfileScreen(
        authToken:
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NTBjM2ZjMWY3YzVkMzZlMGE5NjI3M2MiLCJpYXQiOjE2OTUzMDE1NjksImV4cCI6MTY5NTMwNTE2OX0.ZLAL6ZwttlWPAOiF1rbbGUCWbmOPvVPESO69Va_R-78"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: GNav(
          backgroundColor: Colors.white,
          tabBackgroundColor: Colors.grey.shade900,
          color: Colors.black,
          onTabChange: (index) => navigatorBar(index),
          activeColor: Colors.white,
          gap: 10,
          tabs: const [
            GButton(icon: Icons.home, text: "Home"),
            GButton(icon: Icons.add, text: "Upload"),
            GButton(icon: Icons.account_circle, text: "Profile")
          ],
        ),
      ),
    );
  }
}
