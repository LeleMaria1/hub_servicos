// lib/services/professional_profile_service.dart
import 'package:flutter/foundation.dart';
import '../models/professional_model.dart';

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
            Review(
              clientName: 'Maria Silva',
              rating: 5.0,
              comment: 'Excelente profissional! Resolveu meu problema rapidamente.',
              date: '2024-01-15',
            ),
            Review(
              clientName: 'João Santos',
              rating: 4.5,
              comment: 'Muito prestativo e competente.',
              date: '2024-01-10',
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
              date: '2024-01-12',
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

  void clearProfile() {
    _professional = null;
    notifyListeners();
  }
}