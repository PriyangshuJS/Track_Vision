import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:track_vision/screen/navigator.dart';
import 'package:track_vision/screen/signup_screen.dart';
import 'package:track_vision/widget/button.dart';
import 'package:http/http.dart' as http;

import '../config.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _validate = false;
  Future<void> loginUser() async {
    try {
      if (_emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty) {
        var resBody = {
          "email": _emailController.text,
          "password": _passwordController.text,
        };

        var response = await http.post(
          Uri.parse(registration), // Replace with your actual backend URL
          headers: {"Content-Type": "application/json"},
          body: json.encode(resBody),
        );
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final String token = jsonResponse['token'];
        print("RES Token - ${token}");
        if (response.statusCode == 200 || response.statusCode == 201) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (BuildContext context) => HomeScreen(userToken: token),
            ),
          );
        } else {
          // Handle other status codes or errors here
          print('Registration failed. Status code: ${response.statusCode}');
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('asset/login_wallpaper.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(top: 30),
              color: Colors.black.withOpacity(0.7),
              height: MediaQuery.of(context).size.height * 3 / 4,
              child: Column(
                children: [
                  Text(
                    "Enter your login information",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _emailController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle:
                          TextStyle(color: Colors.white.withOpacity(0.7)),
                      filled: true,
                      fillColor: Colors.black.withOpacity(0.7),
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    style: const TextStyle(color: Colors.white),
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle:
                          TextStyle(color: Colors.white.withOpacity(0.7)),
                      filled: true,
                      fillColor: Colors.black.withOpacity(0.7),
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      loginUser();
                    },
                    child: const TButton(buttonTask: "Login"),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => SignupScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                            color: Colors.blue.withOpacity(0.8),
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
