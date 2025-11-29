// lib/screens/booking_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/booking_service.dart';
import '../models/professional_model.dart';

class BookingScreen extends StatelessWidget {
  final ProfessionalModel professional;

  const BookingScreen({Key? key, required this.professional}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BookingService(),
      child: _BookingScreenContent(professional: professional),
    );
  }
}

class _BookingScreenContent extends StatefulWidget {
  final ProfessionalModel professional;

  const _BookingScreenContent({Key? key, required this.professional}) : super(key: key);

  @override
  State<_BookingScreenContent> createState() => _BookingScreenContentState();
}

class _BookingScreenContentState extends State<_BookingScreenContent> {
  final _addressController = TextEditingController();
  final _descriptionController = TextEditingController();

  // Horários disponíveis
  final List<String> _availableTimes = [
    '08:00', '09:00', '10:00', '11:00',
    '14:00', '15:00', '16:00', '17:00',
  ];

  @override
  void initState() {
    super.initState();
    _addressController.addListener(_onAddressChanged);
    _descriptionController.addListener(_onDescriptionChanged);
  }

  void _onAddressChanged() {
    Provider.of<BookingService>(context, listen: false)
        .setAddress(_addressController.text);
  }

  void _onDescriptionChanged() {
    Provider.of<BookingService>(context, listen: false)
        .setServiceDescription(_descriptionController.text);
  }

  @override
  void dispose() {
    _addressController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Agendar Serviço',
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
      body: Consumer<BookingService>(
        builder: (context, bookingService, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Informações do profissional
                _buildProfessionalInfo(),
                const SizedBox(height: 24),

                // Seção de data
                _buildDateSection(bookingService),
                const SizedBox(height: 24),

                // Seção de horário
                _buildTimeSection(bookingService),
                const SizedBox(height: 24),

                // Endereço
                _buildAddressSection(),
                const SizedBox(height: 24),

                // Descrição do serviço
                _buildDescriptionSection(),
                const SizedBox(height: 32),

                // Resumo e preço
                _buildPriceSummary(bookingService),
                const SizedBox(height: 40),

                // Botão de agendar
                _buildBookButton(bookingService),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfessionalInfo() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Icon(Icons.person, color: Colors.blue),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.professional.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.professional.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'R\$${widget.professional.hourlyRate.toStringAsFixed(2)}/hora',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSection(BookingService bookingService) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Data do Serviço',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatDate(bookingService.selectedDate),
                style: const TextStyle(fontSize: 16),
              ),
              IconButton(
                icon: const Icon(Icons.calendar_today, color: Colors.blue),
                onPressed: () => _selectDate(bookingService),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimeSection(BookingService bookingService) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Horário',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _availableTimes.map((time) {
            final isSelected = bookingService.selectedTime == time;
            return ChoiceChip(
              label: Text(time),
              selected: isSelected,
              onSelected: (selected) {
                bookingService.setSelectedTime(selected ? time : '');
              },
              selectedColor: Colors.blue,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildAddressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Endereço do Serviço',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _addressController,
          decoration: const InputDecoration(
            hintText: 'Digite o endereço onde o serviço será realizado',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          maxLines: 2,
        ),
      ],
    );
  }

  Widget _buildDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Descrição do Serviço',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _descriptionController,
          decoration: const InputDecoration(
            hintText: 'Descreva detalhadamente o serviço necessário',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _buildPriceSummary(BookingService bookingService) {
    final totalPrice = widget.professional.hourlyRate * 2; // 2 horas estimadas

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Resumo do Orçamento',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildPriceRow('Taxa por hora', widget.professional.hourlyRate),
            _buildPriceRow('Tempo estimado', 2, isHours: true),
            const Divider(),
            _buildPriceRow('Total', totalPrice, isTotal: true),
            const SizedBox(height: 8),
            const Text(
              '* O valor final pode variar após avaliação do profissional',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, double value, {bool isHours = false, bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: isTotal ? Colors.blue : Colors.grey[700],
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            isHours ? '${value.toInt()} horas' : 'R\$${value.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 14,
              color: isTotal ? Colors.blue : Colors.grey[700],
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookButton(BookingService bookingService) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: bookingService.isLoading ? null : () => _bookService(bookingService),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: bookingService.isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              )
            : const Text(
                'Confirmar Agendamento',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Future<void> _selectDate(BookingService bookingService) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: bookingService.selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null && picked != bookingService.selectedDate) {
      bookingService.setSelectedDate(picked);
    }
  }

  void _bookService(BookingService bookingService) async {
    final success = await bookingService.createBooking(widget.professional);
    
    if (success && mounted) {
      // Mostrar notificação de sucesso
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Serviço agendado com sucesso!',
            style: TextStyle(fontSize: 16),
          ),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ),
      );

      // Voltar para a tela anterior (perfil do profissional)
      Navigator.pop(context);
    } else if (mounted) {
      // Mostrar notificação de erro
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(bookingService.errorMessage),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }
}