import 'package:flutter/material.dart';
import 'package:book_keeping_app/screens/add_edit_book_screen.dart';
import 'package:book_keeping_app/screens/book_details_screen.dart';
import 'package:book_keeping_app/screens/book_organizer_screen.dart';
import 'package:book_keeping_app/screens/login_screen.dart';
import 'package:book_keeping_app/screens/user_profile_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget { 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/organizer': (context) => BookOrganizerScreen(),
        '/addEdit': (context) => AddEditBookScreen(),
        '/profile': (context) => UserProfileScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/details') {
          final Map<String, dynamic> args =
              settings.arguments as Map<String, dynamic>? ?? {};

          return MaterialPageRoute(
            builder: (context) => BookDetailsScreen(book: args),
          );
        }
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(child: Text('Error: Route not found')),
          ),
        );
      },
    );
  }
}
