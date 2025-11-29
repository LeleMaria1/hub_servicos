// lib/services/home_service.dart
import 'dart:ui';

import 'package:flutter/foundation.dart';
import '../models/category_model.dart';
import '../models/service_model.dart';

class HomeService with ChangeNotifier {
  List<CategoryModel> _categories = [];
  List<ServiceModel> _popularServices = [];
  bool _isLoading = false;

  List<CategoryModel> get categories => _categories;
  List<ServiceModel> get popularServices => _popularServices;
  bool get isLoading => _isLoading;

  HomeService() {
    _loadData();
  }

  void _loadData() {
    _isLoading = true;
    notifyListeners();

    // Simular carregamento de dados
    Future.delayed(const Duration(seconds: 1), () {
      _categories = [
        CategoryModel(
          id: '1',
          name: 'Encanamento',
          icon: '🚰',
          color: const Color(0xFF4FC3F7),
        ),
        CategoryModel(
          id: '2',
          name: 'Elétrica',
          icon: '⚡',
          color: const Color(0xFFFFB74D),
        ),
        CategoryModel(
          id: '3',
          name: 'Limpeza',
          icon: '🧹',
          color: const Color(0xFF81C784),
        ),
        CategoryModel(
          id: '4',
          name: 'Pintura',
          icon: '🎨',
          color: const Color(0xFFBA68C8),
        ),
        CategoryModel(
          id: '5',
          name: 'Montagem',
          icon: '🛠️',
          color: const Color(0xFFF06292),
        ),
        CategoryModel(
          id: '6',
          name: 'Jardinagem',
          icon: '🌿',
          color: const Color(0xFF4DB6AC),
        ),
      ];

      _popularServices = [
        ServiceModel(
          id: '1',
          name: 'Desentupimento',
          price: 120.00,
          categoryId: '1',
          description: 'Desentupimento de pias e vasos sanitários',
          rating: 4.8,
        ),
        ServiceModel(
          id: '2',
          name: 'Instalação de Chuveiro',
          price: 80.00,
          categoryId: '2',
          description: 'Instalação e manutenção de chuveiros elétricos',
          rating: 4.6,
        ),
        ServiceModel(
          id: '3',
          name: 'Limpeza Residencial',
          price: 150.00,
          categoryId: '3',
          description: 'Limpeza completa da residência',
          rating: 4.9,
        ),
      ];

      _isLoading = false;
      notifyListeners();
    });
  }

  List<ServiceModel> getServicesByCategory(String categoryId) {
    return _popularServices.where((service) => service.categoryId == categoryId).toList();
  }
}