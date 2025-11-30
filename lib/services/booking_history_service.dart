// lib/services/booking_history_service.dart
import 'package:flutter/foundation.dart';
import '../models/booking_model.dart';

class BookingHistoryService with ChangeNotifier {
  List<BookingModel> _bookings = [];
  bool _isLoading = false;

  List<BookingModel> get bookings => _bookings;
  bool get isLoading => _isLoading;

  BookingHistoryService() {
    _loadBookings();
  }

  void _loadBookings() {
    _isLoading = true;
    notifyListeners();

    // Simular carregamento de dados
    Future.delayed(const Duration(seconds: 1), () {
      _bookings = [
        BookingModel(
          id: '1',
          professionalId: '1',
          professionalName: 'João Encanador',
          clientId: 'current_user',
          serviceType: 'Desentupimento',
          date: DateTime.now().add(const Duration(days: 2)),
          time: '10:00',
          address: 'Rua das Flores, 123 - São Paulo, SP',
          description: 'Desentupimento de pia da cozinha',
          totalPrice: 160.00,
          status: 'confirmed',
        ),
        BookingModel(
          id: '2',
          professionalId: '4',
          professionalName: 'Maria Limpeza',
          clientId: 'current_user',
          serviceType: 'Limpeza Residencial',
          date: DateTime.now().subtract(const Duration(days: 5)),
          time: '14:00',
          address: 'Rua das Flores, 123 - São Paulo, SP',
          description: 'Limpeza completa do apartamento',
          totalPrice: 120.00,
          status: 'completed',
        ),
        BookingModel(
          id: '3',
          professionalId: '3',
          professionalName: 'Pedro Eletricista',
          clientId: 'current_user',
          serviceType: 'Instalação',
          date: DateTime.now().subtract(const Duration(days: 10)),
          time: '09:00',
          address: 'Rua das Flores, 123 - São Paulo, SP',
          description: 'Instalação de tomadas na sala',
          totalPrice: 150.00,
          status: 'completed',
        ),
      ];
      _isLoading = false;
      notifyListeners();
    });
  }

  void addBooking(BookingModel booking) {
    _bookings.insert(0, booking);
    notifyListeners();
  }

  void cancelBooking(String bookingId) {
    final index = _bookings.indexWhere((booking) => booking.id == bookingId);
    if (index != -1) {
      _bookings[index] = _bookings[index].copyWith(status: 'cancelled');
      notifyListeners();
    }
  }
}