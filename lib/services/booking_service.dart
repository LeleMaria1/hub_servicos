// lib/services/booking_service.dart
import 'package:flutter/foundation.dart';
import '../models/booking_model.dart';
import '../models/professional_model.dart';

class BookingService with ChangeNotifier {
  BookingModel? _currentBooking;
  bool _isLoading = false;
  String _errorMessage = '';
  DateTime _selectedDate = DateTime.now();
  String _selectedTime = '';
  String _serviceDescription = '';
  String _address = '';

  BookingModel? get currentBooking => _currentBooking;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  DateTime get selectedDate => _selectedDate;
  String get selectedTime => _selectedTime;
  String get serviceDescription => _serviceDescription;
  String get address => _address;

  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void setSelectedTime(String time) {
    _selectedTime = time;
    notifyListeners();
  }

  void setServiceDescription(String description) {
    _serviceDescription = description;
    notifyListeners();
  }

  void setAddress(String address) {
    _address = address;
    notifyListeners();
  }

  Future<bool> createBooking(ProfessionalModel professional) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    // Simular processamento
    await Future.delayed(const Duration(seconds: 2));

    try {
      // Validar dados
      if (_selectedTime.isEmpty) {
        throw Exception('Selecione um horário');
      }
      if (_address.isEmpty) {
        throw Exception('Informe o endereço do serviço');
      }
      if (_serviceDescription.isEmpty) {
        throw Exception('Descreva o serviço necessário');
      }

      // Calcular preço (exemplo: 2 horas de trabalho)
      final totalPrice = professional.hourlyRate * 2;

      // Criar agendamento
      _currentBooking = BookingModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        professionalId: professional.id,
        professionalName: professional.name,
        clientId: 'current_user', // Em produção, viria do AuthService
        serviceType: professional.services.first,
        date: _selectedDate,
        time: _selectedTime,
        address: _address,
        description: _serviceDescription,
        totalPrice: totalPrice,
        status: 'pending',
      );

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

  void clearBooking() {
    _currentBooking = null;
    _selectedDate = DateTime.now();
    _selectedTime = '';
    _serviceDescription = '';
    _address = '';
    notifyListeners();
  }
}