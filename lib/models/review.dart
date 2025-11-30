// lib/models/review.dart
class Review {
  final String clientName;
  final double rating;
  final String comment;
  final String date;

  Review({
    required this.clientName,
    required this.rating,
    required this.comment,
    required this.date,
  });
}