// lib/models/booking_model.dart
class BookingModel {
  final String id;
  final String professionalId;
  final String professionalName;
  final String clientId;
  final String serviceType;
  final DateTime date;
  final String time;
  final String address;
  final String description;
  final double totalPrice;
  final String status; // 'pending', 'confirmed', 'completed', 'cancelled'

  BookingModel({
    required this.id,
    required this.professionalId,
    required this.professionalName,
    required this.clientId,
    required this.serviceType,
    required this.date,
    required this.time,
    required this.address,
    required this.description,
    required this.totalPrice,
    required this.status,
  });
}