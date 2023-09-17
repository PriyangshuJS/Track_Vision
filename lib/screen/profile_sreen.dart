import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
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

        Container(
          height: MediaQuery.of(context).size.height / 3,
          width: MediaQuery.of(context).size.width,
          color: Colors.transparent,
          child: Center(
            child: CircleAvatar(
              radius: 90,
              backgroundImage: NetworkImage(
                  "https://cdn.pixabay.com/photo/2020/06/21/15/54/bohemian-5325610_1280.png"),
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
                      'UserName:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Maps:',
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
                          // Replace with your post item widget
                          return ListTile(
                            title: Text('Map1 ${index + 1}'),
                            // Add post content and actions here
                          );
                        },
                      ),
                    ),
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
