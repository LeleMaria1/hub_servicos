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
// No final do arquivo lib/models/booking_model.dart, adicione:
extension BookingModelCopyWith on BookingModel {
  BookingModel copyWith({
    String? id,
    String? professionalId,
    String? professionalName,
    String? clientId,
    String? serviceType,
    DateTime? date,
    String? time,
    String? address,
    String? description,
    double? totalPrice,
    String? status,
  }) {
    return BookingModel(
      id: id ?? this.id,
      professionalId: professionalId ?? this.professionalId,
      professionalName: professionalName ?? this.professionalName,
      clientId: clientId ?? this.clientId,
      serviceType: serviceType ?? this.serviceType,
      date: date ?? this.date,
      time: time ?? this.time,
      address: address ?? this.address,
      description: description ?? this.description,
      totalPrice: totalPrice ?? this.totalPrice,
      status: status ?? this.status,
    );
  }
}