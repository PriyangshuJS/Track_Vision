import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:track_vision/screen/login_screen.dart';

import 'screen/navigator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Track Vision',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}
// AnimatedSplashScreen(
//           duration: 2000,
//           splash: Image.asset(
//             'asset/icon.png',
//             fit: BoxFit.cover,
//           ),
//           nextScreen: HomeScreen(),
//           splashTransition: SplashTransition.fadeTransition,
//           //pageTransitionType: PageTransitionType.scale,
//           backgroundColor: Colors.black),