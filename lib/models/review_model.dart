// lib/models/review_model.dart
class ReviewModel {
  final String id;
  final String bookingId;
  final String professionalId;
  final String clientName;
  final double rating;
  final String comment;
  final DateTime date;

  ReviewModel({
    required this.id,
    required this.bookingId,
    required this.professionalId,
    required this.clientName,
    required this.rating,
    required this.comment,
    required this.date,
  });
}