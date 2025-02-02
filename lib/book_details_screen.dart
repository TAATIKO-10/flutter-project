import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BookDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> book;

  BookDetailsScreen({required this.book});

  @override
  Widget build(BuildContext context) {
    String title = book['title'] ?? 'Unknown Title';
    String author = book['author'] ?? 'Unknown Author';
    String status = book['status'] ?? 'Unknown Status';
    double rating = (book['rating'] ?? 0.0).toDouble();
    Uint8List? coverBytes = book['coverBytes']; // Get image bytes

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Book Cover Image
            Center(
              child: coverBytes != null
                  ? Image.memory(coverBytes, width: 150, height: 200, fit: BoxFit.cover)
                  : Icon(Icons.image_not_supported, size: 100, color: Colors.grey), // Show placeholder if no image
            ),
            SizedBox(height: 20),

            // Book Title
            Text(
              title,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // Book Author
            Text(
              'Author: $author',
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
            SizedBox(height: 10),

            // Book Status
            Text(
              'Status: $status',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10),

            // Book Rating
            Row(
              children: [
                Text(
                  'Rating: ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                RatingBar.builder(
                  initialRating: rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 25,
                  itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                  ignoreGestures: true, // User cannot change rating
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (newRating) {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
