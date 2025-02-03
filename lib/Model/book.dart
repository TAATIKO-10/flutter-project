class Book {
  final String title;
  final String author;
  final String cover;
  final double rating;
  final String status;
  final String pdfUrl;
  Book({
    required this.title,
    required this.author,
    this.cover = '',
    this.rating = 0.0,
    this.status = 'Want to Read',
    this.pdfUrl = '',
  });
  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      title: map['title'] ?? 'Unknown Title',
      author: map['author'] ?? 'Unknown Author',
      cover: map['cover'] ?? '',
      rating: (map['rating'] ?? 0.0).toDouble(),
      status: map['status'] ?? 'Want to Read',
      pdfUrl: map['pdfUrl'] ?? '',
    );
  }
