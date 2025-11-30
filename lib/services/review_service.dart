// lib/services/review_service.dart
import 'package:flutter/foundation.dart';
import '../models/review_model.dart';
import '../models/booking_model.dart';
import '../models/professional_model.dart';

class ReviewService with ChangeNotifier {
  double _selectedRating = 0.0;
  String _comment = '';
  bool _isLoading = false;
  String _errorMessage = '';
  List<ReviewModel> _reviews = [];

  double get selectedRating => _selectedRating;
  String get comment => _comment;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  List<ReviewModel> get reviews => _reviews;

  void setRating(double rating) {
    _selectedRating = rating;
    notifyListeners();
  }

  void setComment(String comment) {
    _comment = comment;
    notifyListeners();
  }

  Future<bool> submitReview(BookingModel booking, ProfessionalModel professional) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    // Simular processamento
    await Future.delayed(const Duration(seconds: 2));

    try {
      // Validar dados
      if (_selectedRating == 0.0) {
        throw Exception('Selecione uma avaliação');
      }
      if (_comment.isEmpty) {
        throw Exception('Escreva um comentário');
      }
      if (_comment.length < 10) {
        throw Exception('O comentário deve ter pelo menos 10 caracteres');
      }

      // Criar nova avaliação
      final newReview = ReviewModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        bookingId: booking.id,
        professionalId: professional.id,
        clientName: 'Cliente', // Em produção, viria do AuthService
        rating: _selectedRating,
        comment: _comment,
        date: DateTime.now(),
      );

      // Adicionar à lista de avaliações
      _reviews.add(newReview);

      // Debug: imprimir avaliações salvas
      debugPrintReviews();

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Método para obter avaliações de um profissional específico
  List<ReviewModel> getReviewsByProfessional(String professionalId) {
    return _reviews.where((review) => review.professionalId == professionalId).toList();
  }

  void clearForm() {
    _selectedRating = 0.0;
    _comment = '';
    _errorMessage = '';
    notifyListeners();
  }

  // Método para debug: imprimir avaliações salvas
  void debugPrintReviews() {
    if (kDebugMode) {
      print('=== AVALIAÇÕES SALVAS ===');
      print('Total de avaliações: ${_reviews.length}');
      for (var review in _reviews) {
        print('Profissional ID: ${review.professionalId}');
        print('Cliente: ${review.clientName}');
        print('Rating: ${review.rating}');
        print('Comentário: ${review.comment}');
        print('Data: ${review.date}');
        print('---');
      }
    }
  }
}