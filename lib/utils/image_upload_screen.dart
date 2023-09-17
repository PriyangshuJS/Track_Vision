import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'image_pick.dart';
import '../screen/first_page.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text("Upload Map"),
      children: [
        SimpleDialogOption(
          padding: const EdgeInsets.all(20),
          child: const Text("Choose from Gallery"),
          onPressed: () async {
            Navigator.of(context).pop();
            Uint8List file = await pickImage(ImageSource.gallery);
            setState(() {});
          },
        ),
        SimpleDialogOption(
          padding: const EdgeInsets.all(20),
          child: const Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => FirstPage()));
          },
        ),
      ],
    );
  }
}
