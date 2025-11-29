// lib/models/professional_model.dart
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
  });
}