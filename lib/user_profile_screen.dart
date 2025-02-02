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
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        automaticallyImplyLeading: false, // Removes back arrow
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Profile Picture
            GestureDetector(
              onTap: _pickImage,  // Let the user pick an image when tapped
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blue,
                backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                child: _profileImage == null ? Icon(Icons.person, size: 50, color: Colors.white) : null,
              ),
            ),
            SizedBox(height: 20),
            // Username
            isEditing
                ? TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(labelText: 'Username'),
                  )
                : Text('UserName: $username', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            // Email
            isEditing
                ? TextField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                  )
                : Text('Email: $email', style: TextStyle(fontSize: 16)),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Edit Profile Button
                if (!isEditing)
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isEditing = true;  // Enable edit mode
                      });
                    },
                    child: Text('Edit Profile'),
                  ),
                // Save or Cancel Buttons while editing
                if (isEditing)
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: _saveProfile,
                        child: Text('Save Changes'),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: _cancelEdit,
                        child: Text('Cancel'),
                      ),
                    ],
                  ),
                // Log Out Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.popUntil(context, ModalRoute.withName('/'));
                  },
                  child: Text('Log Out'),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/organizer');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/profile');
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
