class BookOrganizerScreen extends StatefulWidget {
  @override
  _BookOrganizerScreenState createState() => _BookOrganizerScreenState();
}

// For managing the bottom navigation
  int _selectedIndex = 0;

  // Handle Bottom Navigation Changes
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigate to the appropriate screen based on the selected index
    if (index == 0) {
      // Navigate to Home (Login screen)
      Navigator.pushReplacementNamed(context, '/');
    } else if (index == 1) {
      // Navigate to User Profile screen
      Navigator.pushReplacementNamed(context, '/profile');
    }
  }
