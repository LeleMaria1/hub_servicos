// lib/screens/booking_history_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/booking_history_service.dart';
import '../models/booking_model.dart';
import '../widgets/booking_history_card.dart';

class BookingHistoryScreen extends StatelessWidget {
  const BookingHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BookingHistoryService(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Meus Agendamentos',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.grey),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: const _BookingHistoryContent(),
      ),
    );
  }
}

class _BookingHistoryContent extends StatelessWidget {
  const _BookingHistoryContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bookingHistoryService = Provider.of<BookingHistoryService>(context);

    if (bookingHistoryService.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (bookingHistoryService.bookings.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.history_toggle_off,
              size: 80,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 16),
            const Text(
              'Nenhum agendamento encontrado',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Seus agendamentos aparecerão aqui',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    // Separar agendamentos por status
    final upcomingBookings = bookingHistoryService.bookings
        .where((booking) => booking.status == 'pending' || booking.status == 'confirmed')
        .toList();

    final completedBookings = bookingHistoryService.bookings
        .where((booking) => booking.status == 'completed')
        .toList();

    final cancelledBookings = bookingHistoryService.bookings
        .where((booking) => booking.status == 'cancelled')
        .toList();

    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          // Abas
          Container(
            color: Colors.white,
            child: const TabBar(
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.blue,
              tabs: [
                Tab(text: 'Agendados'),
                Tab(text: 'Concluídos'),
                Tab(text: 'Cancelados'),
              ],
            ),
          ),
          
          // Conteúdo das abas
          Expanded(
            child: TabBarView(
              children: [
                // Aba: Agendados
                _buildBookingsList(
                  context,
                  upcomingBookings,
                  'Nenhum agendamento futuro',
                  'Seus próximos agendamentos aparecerão aqui',
                ),
                
                // Aba: Concluídos
                _buildBookingsList(
                  context,
                  completedBookings,
                  'Nenhum serviço concluído',
                  'Seus serviços concluídos aparecerão aqui',
                ),
                
                // Aba: Cancelados
                _buildBookingsList(
                  context,
                  cancelledBookings,
                  'Nenhum serviço cancelado',
                  'Seus serviços cancelados aparecerão aqui',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingsList(BuildContext context, List<BookingModel> bookings, String emptyTitle, String emptySubtitle) {
    if (bookings.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_today,
              size: 60,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 16),
            Text(
              emptyTitle,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              emptySubtitle,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final booking = bookings[index];
        return BookingHistoryCard(
          booking: booking,
          onTap: () {
            // Navegar para detalhes do agendamento (opcional)
            _showBookingDetails(context, booking);
          },
        );
      },
    );
  }

  void _showBookingDetails(BuildContext context, BookingModel booking) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return _buildBookingDetails(context, booking);
      },
    );
  }

  Widget _buildBookingDetails(BuildContext context, BookingModel booking) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Detalhes do Agendamento',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildDetailItem('Profissional:', booking.professionalName),
          _buildDetailItem('Serviço:', booking.serviceType),
          _buildDetailItem('Data:', '${_formatDate(booking.date)} às ${booking.time}'),
          _buildDetailItem('Endereço:', booking.address),
          _buildDetailItem('Descrição:', booking.description),
          _buildDetailItem('Status:', _getStatusText(booking.status)),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 8),
          _buildDetailItem(
            'Valor Total:',
            'R\$${booking.totalPrice.toStringAsFixed(2)}',
            isTotal: true,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Fechar'),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                color: isTotal ? Colors.blue : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'pending':
        return 'Pendente';
      case 'confirmed':
        return 'Confirmado';
      case 'completed':
        return 'Concluído';
      case 'cancelled':
        return 'Cancelado';
      default:
        return status;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}