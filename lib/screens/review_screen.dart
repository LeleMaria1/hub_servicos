// lib/screens/review_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/review_service.dart';
import '../models/booking_model.dart';
import '../models/professional_model.dart';

class ReviewScreen extends StatelessWidget {
  final BookingModel booking;
  final ProfessionalModel professional;

  const ReviewScreen({
    Key? key,
    required this.booking,
    required this.professional,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return _ReviewScreenContent(booking: booking, professional: professional);
}
}

class _ReviewScreenContent extends StatelessWidget {
  final BookingModel booking;
  final ProfessionalModel professional;

  const _ReviewScreenContent({
    Key? key,
    required this.booking,
    required this.professional,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Avaliar Profissional',
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
      body: Consumer<ReviewService>(
        builder: (context, reviewService, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Informações do profissional
                _buildProfessionalInfo(),
                const SizedBox(height: 24),

                // Serviço realizado
                _buildServiceInfo(),
                const SizedBox(height: 32),

                // Avaliação por estrelas
                _buildRatingSection(reviewService),
                const SizedBox(height: 32),

                // Comentário
                _buildCommentSection(reviewService),
                const SizedBox(height: 24),

                // Mensagem de erro
                if (reviewService.errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      reviewService.errorMessage,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                      ),
                    ),
                  ),

                // Botão de enviar
                _buildSubmitButton(context, reviewService),
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
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Icon(Icons.person, color: Colors.blue, size: 30),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    professional.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    professional.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
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

  Widget _buildServiceInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Serviço Realizado',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            booking.serviceType,
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(
            'Realizado em ${_formatDate(booking.date)}',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingSection(ReviewService reviewService) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Como foi seu atendimento?',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Selecione de 1 a 5 estrelas',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 16),
        
        // Estrelas
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              final starRating = index + 1;
              return IconButton(
                onPressed: () {
                  reviewService.setRating(starRating.toDouble());
                },
                icon: Icon(
                  starRating <= reviewService.selectedRating
                      ? Icons.star
                      : Icons.star_border,
                  color: Colors.amber,
                  size: 40,
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 8),
        
        // Texto descritivo da avaliação
        Center(
          child: Text(
            _getRatingText(reviewService.selectedRating),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCommentSection(ReviewService reviewService) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Compartilhe sua experiência',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Conte como foi o serviço prestado',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          onChanged: (value) => reviewService.setComment(value),
          maxLines: 5,
          decoration: const InputDecoration(
            hintText: 'Escreva aqui sua avaliação detalhada...',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${reviewService.comment.length} caracteres (mínimo 10)',
          style: TextStyle(
            fontSize: 12,
            color: reviewService.comment.length >= 10 ? Colors.green : Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton(BuildContext context, ReviewService reviewService) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: reviewService.isLoading ? null : () => _submitReview(context, reviewService),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: reviewService.isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              )
            : const Text(
                'Enviar Avaliação',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
      ),
    );
  }

  String _getRatingText(double rating) {
    switch (rating.toInt()) {
      case 1:
        return 'Péssimo';
      case 2:
        return 'Ruim';
      case 3:
        return 'Regular';
      case 4:
        return 'Bom';
      case 5:
        return 'Excelente';
      default:
        return 'Selecione uma avaliação';
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _submitReview(BuildContext context, ReviewService reviewService) async {
    // CORREÇÃO: Passar o professional como segundo parâmetro
    final success = await reviewService.submitReview(booking, professional);
    
    if (success && context.mounted) {
      // Mostrar notificação de sucesso
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Avaliação enviada com sucesso!',
            style: TextStyle(fontSize: 16),
          ),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ),
      );

      // Voltar para a tela anterior
      Navigator.pop(context);
    } else if (context.mounted) {
      // Mostrar notificação de erro
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(reviewService.errorMessage),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }
}