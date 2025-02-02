import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BookOrganizerScreen extends StatefulWidget {
  @override
  _BookOrganizerScreenState createState() => _BookOrganizerScreenState();
}

class _BookOrganizerScreenState extends State<BookOrganizerScreen> {
  List<Map<String, dynamic>> books = []; // Empty list initially

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

  // Confirm Edit Dialog
  void _confirmEdit(int index) {
    TextEditingController titleController =
        TextEditingController(text: books[index]['title']);
    TextEditingController authorController =
        TextEditingController(text: books[index]['author']);
    double rating = books[index]['rating'];
    String status = books[index]['status'];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Organizer'),
        centerTitle: true,
      ),
      body: _selectedIndex == 0
          ? ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  child: ListTile(
                    title: Text(book['title'] ?? 'Unknown Title'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(book['author'] ?? 'Unknown Author'),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Text('Rating: '),
                            RatingBar.builder(
                              initialRating:
                                  book['rating']?.toDouble() ?? 1.0,
                              minRating: 1,
                              direction: Axis.horizontal,
                              itemCount: 5,
                              itemSize: 20,
                              itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (newRating) {
                                setState(() {
                                  books[index]['rating'] = newRating;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            _confirmEdit(index);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            _confirmDelete(index);
                          },
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/details', arguments: book);
                    },
                  ),
                );
              },
            )
          : Center(
              child: Text("User Profile Screen"), // Change this to your user profile content
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            final newBook = await Navigator.pushNamed(context, '/addEdit')
                as Map<String, dynamic>?;
            if (newBook != null && newBook.containsKey('title')) {
              setState(() {
                books.add(newBook);
              });
            }
          } catch (e) {
            print("Error: $e");
          }
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'User',
          ),
        ],
      ),
    );
  }
}
