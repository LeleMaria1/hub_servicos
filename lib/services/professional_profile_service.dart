// lib/services/professional_profile_service.dart
import 'package:flutter/foundation.dart';
import '../models/professional_model.dart';
import '../models/review.dart'; // Importar Review

class ProfessionalProfileService with ChangeNotifier {
  ProfessionalModel? _professional;
  bool _isLoading = false;

  ProfessionalModel? get professional => _professional;
  bool get isLoading => _isLoading;

  void loadProfessionalProfile(ProfessionalModel professional) {
    _isLoading = true;
    notifyListeners();

    // Simular carregamento de dados completos
    Future.delayed(const Duration(seconds: 1), () {
      _professional = _getCompleteProfessionalData(professional);
      _isLoading = false;
      notifyListeners();
    });
  }

  ProfessionalModel _getCompleteProfessionalData(ProfessionalModel basicData) {
    // Adicionar dados completos baseados no profissional básico
    switch (basicData.id) {
      case '1': // João Encanador
        return ProfessionalModel(
          id: basicData.id,
          name: basicData.name,
          categoryId: basicData.categoryId,
          description: basicData.description,
          rating: basicData.rating,
          completedJobs: basicData.completedJobs,
          hourlyRate: basicData.hourlyRate,
          imageUrl: '',
          services: basicData.services,
          experience: '15 anos',
          location: 'São Paulo - SP',
          reviews: [
            Review( // Usar Review em vez de ReviewModel
              clientName: 'Maria Silva',
              rating: 5.0,
              comment: 'Excelente profissional! Resolveu meu problema rapidamente.',
              date: '15/01/2024',
            ),
            Review(
              clientName: 'João Santos',
              rating: 4.5,
              comment: 'Muito prestativo e competente.',
              date: '10/01/2024',
            ),
          ],
        );

      case '2': // Carlos Hidráulica
        return ProfessionalModel(
          id: basicData.id,
          name: basicData.name,
          categoryId: basicData.categoryId,
          description: basicData.description,
          rating: basicData.rating,
          completedJobs: basicData.completedJobs,
          hourlyRate: basicData.hourlyRate,
          imageUrl: '',
          services: basicData.services,
          experience: '20 anos',
          location: 'São Paulo - SP',
          reviews: [
            Review(
              clientName: 'Ana Costa',
              rating: 5.0,
              comment: 'Profissional muito experiente e honesto.',
              date: '12/01/2024',
            ),
          ],
        );

      default:
        return ProfessionalModel(
          id: basicData.id,
          name: basicData.name,
          categoryId: basicData.categoryId,
          description: basicData.description,
          rating: basicData.rating,
          completedJobs: basicData.completedJobs,
          hourlyRate: basicData.hourlyRate,
          imageUrl: '',
          services: basicData.services,
          experience: '10 anos',
          location: 'São Paulo - SP',
          reviews: [],
        );
    }
  }

  void updateProfessionalReviews(String professionalId, List<Review> reviews) {
    if (_professional != null && reviews.isNotEmpty) {
      // Atualizar as reviews do professional
      _professional = _professional!.copyWith(reviews: reviews);
      notifyListeners();
    }
  }

  void clearProfile() {
    _professional = null;
    notifyListeners();
  }
}