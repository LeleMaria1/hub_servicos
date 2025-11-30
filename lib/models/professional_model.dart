// Mantenha apenas o ProfessionalModel:
import 'review.dart'; // Importar do arquivo separado

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
  final List<Review> reviews; // Usar Review do arquivo separado

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

  ProfessionalModel copyWith({
    String? id,
    String? name,
    String? categoryId,
    String? description,
    double? rating,
    int? completedJobs,
    double? hourlyRate,
    String? imageUrl,
    List<String>? services,
    String? experience,
    String? location,
    List<Review>? reviews,
  }) {
    return ProfessionalModel(
      id: id ?? this.id,
      name: name ?? this.name,
      categoryId: categoryId ?? this.categoryId,
      description: description ?? this.description,
      rating: rating ?? this.rating,
      completedJobs: completedJobs ?? this.completedJobs,
      hourlyRate: hourlyRate ?? this.hourlyRate,
      imageUrl: imageUrl ?? this.imageUrl,
      services: services ?? this.services,
      experience: experience ?? this.experience,
      location: location ?? this.location,
      reviews: reviews ?? this.reviews,
    );
  }
}