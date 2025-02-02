import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}
class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  String username = 'User';  // Initial username
  String email = 'user@gmail.com';  // Initial email
  bool isEditing = false;  // To track if the user is in edit mode
  File? _profileImage;  // To store the picked profile image

  // TextEditing controllers to handle the changes
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  // Function to save changes
  void _saveProfile() {
    setState(() {
      username = _usernameController.text;
      email = _emailController.text;
      isEditing = false;  // Turn off editing mode
    });
  }
   // Function to cancel editing
  void _cancelEdit() {
    setState(() {
      isEditing = false;  // Exit editing mode without saving changes
    });
  }
    // Function to pick a profile image
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);  // Save the picked image
      });
    }
  }
  @override
  void initState() {
    super.initState();
    _usernameController.text = username;
    _emailController.text = email;
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
