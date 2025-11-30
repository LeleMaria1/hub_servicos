// lib/widgets/booking_history_card.dart
import 'package:flutter/material.dart';
import 'package:hub_servicos/models/professional_model.dart';
import '../models/booking_model.dart';

class BookingHistoryCard extends StatelessWidget {
  final BookingModel booking;
  final VoidCallback onTap;

  const BookingHistoryCard({
    Key? key,
    required this.booking,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cabeçalho com profissional e status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      booking.professionalName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getStatusColor(booking.status),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _getStatusText(booking.status),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              
              // Serviço e data
              Text(
                booking.serviceType,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              
              Text(
                '${_formatDate(booking.date)} às ${booking.time}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              
              // Endereço (resumido)
              Text(
                _truncateAddress(booking.address),
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              
              // Valor
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'R\$${booking.totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: 16,
                  ),
                ],
              ),
              
              // Botão de avaliação para serviços concluídos
              if (booking.status == 'completed') ...[
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      // Navegar para tela de avaliação
                      _navigateToReviewScreen(context);
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.blue,
                      side: const BorderSide(color: Colors.blue),
                    ),
                    child: const Text('Avaliar Serviço'),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'confirmed':
        return Colors.green;
      case 'completed':
        return Colors.blue;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'pending':
        return 'PENDENTE';
      case 'confirmed':
        return 'CONFIRMADO';
      case 'completed':
        return 'CONCLUÍDO';
      case 'cancelled':
        return 'CANCELADO';
      default:
        return status.toUpperCase();
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _truncateAddress(String address) {
    if (address.length <= 40) return address;
    return '${address.substring(0, 37)}...';
  }

  // Substitua o método _navigateToReviewScreen por este:
  void _navigateToReviewScreen(BuildContext context) {
    // Criar professional mock baseado no booking
    final professional = ProfessionalModel(
      id: booking.professionalId,
      name: booking.professionalName,
      categoryId: '1',
      description: 'Profissional qualificado',
      rating: 4.5,
      completedJobs: 50,
      hourlyRate: booking.totalPrice / 2,
      imageUrl: '',
      services: [booking.serviceType],
      experience: 'Experiência comprovada',
      location: 'São Paulo - SP',
      reviews: [],
    );

    Navigator.pushNamed(
      context,
      '/review',
      arguments: {
        'booking': booking,
        'professional': professional,
      },
    );
  }
    
    // Para implementação completa, descomente:
    /*
    Navigator.pushNamed(
      context,
      '/review',
      arguments: {
        'booking': booking,
        'professional': professional, // Precisaria receber o professional
      },
    );
    */
}
