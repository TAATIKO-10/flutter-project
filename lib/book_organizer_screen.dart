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
// Confirm Delete Dialog
  void _confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Book'),
          content: Text('Are you sure you want to delete this book?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  books.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
