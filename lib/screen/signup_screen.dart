import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:track_vision/config.dart';
import 'package:track_vision/screen/navigator.dart';
import 'package:track_vision/widget/button.dart';
import '../utils/image_pick.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  String _image = "";
  selectImage() async {
    final Uint8List? img = await pickImage(ImageSource.gallery);
    if (img != null) {
      final String base64Image = base64Encode(img);
      setState(() {
        _image = base64Image; // Store the base64-encoded image
      });
      print("IMAGE ___ - ${img}");
    }
  }

  bool _validate = false;
  void registerUser() async {
    print("Done ///");
    try {
      if (_emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty) {
        var resBody = {
          "username": _usernameController.text,
          "email": _emailController.text,
          "password": _passwordController.text,
          "profilePictureUrl": _image ?? "",
        };

        var response = await http.post(
          Uri.parse(registration),
          headers: {"Content-Type": "application/json"}, // Fix the header typo
          body: json.encode(resBody), // Encode the body as a JSON string
        );
        print("ress -  ${response.statusCode}");
        print("ressbody - ${response.body}");
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final String token = jsonResponse['token'];
        print("RES Token - ${token}");

        if (response.statusCode == 200 || response.statusCode == 201) {
          // ignore: use_build_context_synchronously
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (BuildContext context) => HomeScreen(userToken: token),
            ),
          );
        }
      } else {
        // Handle other status codes or errors here
        print('Registration failed. Status code: ');
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
                    "Create your account",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        _image != null
                            ? CircleAvatar(
                                radius: 64,
                                backgroundImage: MemoryImage(
                                  Uint8List.fromList(base64Decode(_image!)),
                                ))
                            : const CircleAvatar(
                                radius: 64,
                                backgroundImage: NetworkImage(
                                    "https://cdn.pixabay.com/photo/2017/11/10/05/48/user-2935527_1280.png"),
                              ),
                        Positioned(
                          bottom: -10,
                          left: 80,
                          child: IconButton(
                            onPressed: selectImage,
                            icon: const Icon(Icons.add_a_photo),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: _usernameController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Username',
                        hintStyle:
                            TextStyle(color: Colors.white.withOpacity(0.7)),
                        filled: true,
                        fillColor: Colors.black.withOpacity(0.7),
                        border: const OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Username';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
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
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
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
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      registerUser(); // Wait for registerUser() to complete
                    },
                    child: TButton(buttonTask: "Signup"),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
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
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.blue.withOpacity(0.8),
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
