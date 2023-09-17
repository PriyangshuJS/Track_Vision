import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'first_page.dart';
import '../utils/image_upload_screen.dart';
import 'profile_sreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
    ProfileScreen(),
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
