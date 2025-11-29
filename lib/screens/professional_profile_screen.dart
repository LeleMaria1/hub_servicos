// lib/screens/professional_profile_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/professional_profile_service.dart';
import '../models/professional_model.dart';
import '../widgets/review_card.dart';

class ProfessionalProfileScreen extends StatelessWidget {
  final ProfessionalModel professional;

  const ProfessionalProfileScreen({Key? key, required this.professional}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfessionalProfileService(),
      child: _ProfessionalProfileScreenContent(professional: professional),
    );
  }
}

class _ProfessionalProfileScreenContent extends StatelessWidget {
  final ProfessionalModel professional;

  const _ProfessionalProfileScreenContent({Key? key, required this.professional}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileService = Provider.of<ProfessionalProfileService>(context);

    // Carregar perfil completo quando a tela é aberta
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (profileService.professional?.id != professional.id) {
        profileService.loadProfessionalProfile(professional);
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Perfil do Profissional',
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
      body: Consumer<ProfessionalProfileService>(
        builder: (context, service, child) {
          if (service.isLoading || service.professional == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final prof = service.professional!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Cabeçalho do perfil
                _buildProfileHeader(prof),
                const SizedBox(height: 24),

                // Serviços oferecidos
                _buildServicesSection(prof),
                const SizedBox(height: 24),

                // Sobre o profissional
                _buildAboutSection(prof),
                const SizedBox(height: 24),

                // Avaliações
                _buildReviewsSection(prof),
                const SizedBox(height: 80), // Espaço para o botão flutuante
              ],
            ),
          );
        },
      ),
      
      // Botão flutuante para agendar
      floatingActionButton: _buildScheduleButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildProfileHeader(ProfessionalModel prof) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Foto do profissional
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(40),
              ),
              child: const Icon(
                Icons.person,
                color: Colors.blue,
                size: 40,
              ),
            ),
            const SizedBox(width: 16),
            
            // Informações principais
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    prof.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    prof.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  
                  // Rating e jobs
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        prof.rating.toString(),
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(width: 16),
                      const Icon(Icons.work, color: Colors.green, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '${prof.completedJobs} jobs concluídos',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  
                  // Preço por hora
                  Text(
                    'R\$${prof.hourlyRate.toStringAsFixed(2)}/hora',
                    style: const TextStyle(
                      fontSize: 18,
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

  Widget _buildServicesSection(ProfessionalModel prof) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Serviços Oferecidos',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: prof.services.map((service) {
            return Chip(
              label: Text(service),
              backgroundColor: Colors.blue.withOpacity(0.1),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildAboutSection(ProfessionalModel prof) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Sobre',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        _buildInfoRow('Experiência', prof.experience),
        _buildInfoRow('Localização', prof.location),
        _buildInfoRow('Tipo de serviços', 'Residencial e Comercial'),
      ],
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsSection(ProfessionalModel prof) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Avaliações',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        
        if (prof.reviews.isEmpty)
          const Text(
            'Nenhuma avaliação ainda',
            style: TextStyle(color: Colors.grey),
          )
        else
          Column(
            children: prof.reviews.map((review) {
              return ReviewCard(review: review);
            }).toList(),
          ),
      ],
    );
  }

  Widget _buildScheduleButton(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        onPressed: () {
          // Navegar para tela de agendamento (próxima tela)
          final profileService = Provider.of<ProfessionalProfileService>(context, listen: false);
          Navigator.pushNamed(
            context,
            '/schedule',
            arguments: profileService.professional!,
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Agendar Serviço',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}