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
showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Book'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: authorController,
                decoration: InputDecoration(labelText: 'Author'),
              ),
              SizedBox(height: 10),
              Text('Rating'),
              RatingBar.builder(
                initialRating: rating,
                minRating: 1,
                direction: Axis.horizontal,
                itemCount: 5,
                itemSize: 25,
                itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (newRating) {
                  rating = newRating;
                },
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: status,
                decoration: InputDecoration(labelText: 'Status'),
                items: ['Read', 'Want to Read']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  if (newValue != null) {
                    status = newValue;
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  books[index] = {
                    'title': titleController.text,
                    'author': authorController.text,
                    'rating': rating,
                    'status': status,
                  };
                });
                Navigator.of(context).pop();
              },
              child: Text('Update', style: TextStyle(color: Colors.blue)),
            ),
          ],
        );
      },
    );
  }
