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
