// lib/services/professionals_service.dart
import 'package:flutter/foundation.dart';
import '../models/professional_model.dart';
import '../models/category_model.dart';

class ProfessionalsService with ChangeNotifier {
  List<ProfessionalModel> _professionals = [];
  bool _isLoading = false;
  String _selectedCategory = '';

  List<ProfessionalModel> get professionals => _professionals;
  bool get isLoading => _isLoading;
  String get selectedCategory => _selectedCategory;

  void loadProfessionalsByCategory(String categoryId) {
    _isLoading = true;
    _selectedCategory = categoryId;
    notifyListeners();

    // Simular carregamento
    Future.delayed(const Duration(seconds: 1), () {
      _professionals = _getMockProfessionals(categoryId);
      _isLoading = false;
      notifyListeners();
    });
  }

  List<ProfessionalModel> _getMockProfessionals(String categoryId) {
    switch (categoryId) {
      case '1': // Encanamento
        return [
          ProfessionalModel(
            id: '1',
            name: 'João Encanador',
            categoryId: '1',
            description: 'Especialista em desentupimentos e instalações',
            rating: 4.8,
            completedJobs: 127,
            hourlyRate: 80.00,
            imageUrl: '',
            services: ['Desentupimento', 'Instalação', 'Manutenção'],
          ),
          ProfessionalModel(
            id: '2',
            name: 'Carlos Hidráulica',
            categoryId: '1',
            description: '20 anos de experiência em obras residenciais',
            rating: 4.9,
            completedJobs: 254,
            hourlyRate: 95.00,
            imageUrl: '',
            services: ['Reforma', 'Instalação', 'Manutenção Preventiva'],
          ),
        ];

      case '2': // Elétrica
        return [
          ProfessionalModel(
            id: '3',
            name: 'Pedro Eletricista',
            categoryId: '2',
            description: 'Instalações elétricas residenciais e comerciais',
            rating: 4.7,
            completedJobs: 89,
            hourlyRate: 75.00,
            imageUrl: '',
            services: ['Instalação', 'Manutenção', 'Quadros Elétricos'],
          ),
        ];

      case '3': // Limpeza
        return [
          ProfessionalModel(
            id: '4',
            name: 'Maria Limpeza',
            categoryId: '3',
            description: 'Limpeza residencial e pós-obra',
            rating: 4.9,
            completedJobs: 312,
            hourlyRate: 60.00,
            imageUrl: '',
            services: ['Limpeza Residencial', 'Organização', 'Pós-Obra'],
          ),
        ];

      default:
        return [];
    }
  }

  void clearProfessionals() {
    _professionals = [];
    _selectedCategory = '';
    notifyListeners();
  }
}