import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:note_app/utils/constants/animations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hive/hive.dart';
import 'package:note_app/views/homeScreen/HomeScreen.dart';

class UsernameScreen extends StatefulWidget {
  const UsernameScreen({super.key});

  @override
  State<UsernameScreen> createState() => _UsernameScreenState();
}

class _UsernameScreenState extends State<UsernameScreen> {
  File? _selectedImage;
  Box _noteBox = Hive.box('noteBox');
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 60,
                ),
                CircleAvatar(
                  radius: 70,
                  backgroundImage: _selectedImage != null
                      ? FileImage(_selectedImage!)
                      : AssetImage(
                          ImageConstants.avatar), // default avatar image
                ),
                SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () async {
                    final pickedFile = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      setState(() {
                        _selectedImage = File(pickedFile.path);
                        _storeImageInNoteBox(_selectedImage!);
                      });
                    }
                  },
                  child: Text('Edit Profile'),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _textController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      hintText: 'Enter your name',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10))),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Homescreen(),
                            ),
                            (Route<dynamic> route) => false,
                          );
                        },
                        child: Text(
                          "Skip",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        )),
                    TextButton(
                      onPressed: () {
                        if (_selectedImage != null) {
                          _storeImageInNoteBox(_selectedImage!);
                        }
                        _storeTextInNoteBox(_textController.text);
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => Homescreen()),
                          (Route<dynamic> route) => false,
                        );
                      },
                      child: Text(
                        "Next",
                        style: TextStyle(color: Colors.blue, fontSize: 16),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _storeImageInNoteBox(File image) async {
    Uint8List imageBytes = await image.readAsBytes();
    _noteBox.put('image', imageBytes);
  }

  void _storeTextInNoteBox(String text) {
    _noteBox.put('text', text);
  }
}
