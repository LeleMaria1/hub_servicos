// lib/models/professional_model.dart (atualizado)
class ProfessionalModel {
  final String id;
  final String name;
  final String categoryId;
  final String description;
  final double rating;
  final int completedJobs;
  final double hourlyRate;
  final String imageUrl;
  final List<String> services;
  final String experience;
  final String location;
  final List<Review> reviews;

  ProfessionalModel({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.description,
    required this.rating,
    required this.completedJobs,
    required this.hourlyRate,
    required this.imageUrl,
    required this.services,
    required this.experience,
    required this.location,
    required this.reviews,
  });
}

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