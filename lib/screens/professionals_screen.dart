// lib/screens/professionals_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/professionals_service.dart';
import '../models/category_model.dart';
import '../models/professional_model.dart';
import '../widgets/professional_card.dart';

class ProfessionalsScreen extends StatelessWidget {
  final CategoryModel category;

  const ProfessionalsScreen({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfessionalsService(),
      child: _ProfessionalsScreenContent(category: category),
    );
  }
}

class _ProfessionalsScreenContent extends StatelessWidget {
  final CategoryModel category;

  const _ProfessionalsScreenContent({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final professionalsService = Provider.of<ProfessionalsService>(context);

    // Carregar profissionais quando a tela é aberta
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (professionalsService.selectedCategory != category.id) {
        professionalsService.loadProfessionalsByCategory(category.id);
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Profissionais - ${category.name}',
          style: const TextStyle(
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
      body: Consumer<ProfessionalsService>(
        builder: (context, service, child) {
          if (service.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (service.professionals.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.people_outline,
                    size: 80,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Nenhum profissional encontrado',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Filtros e informações
                Text(
                  '${service.professionals.length} profissionais disponíveis',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 16),

                // Lista de profissionais
                Expanded(
                  child: ListView.builder(
                    itemCount: service.professionals.length,
                    itemBuilder: (context, index) {
                      final professional = service.professionals[index];
                      return ProfessionalCard(
                        professional: professional,
                        onTap: () {
                          // Navegar para perfil do profissional (próxima tela)
                          Navigator.pushNamed(
                            context,
                            '/professional-profile',
                            arguments: professional,
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}