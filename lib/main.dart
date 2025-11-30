// lib/main.dart
import 'package:flutter/material.dart';
import 'package:hub_servicos/screens/chat_screen.dart';
import 'package:hub_servicos/screens/settings_screen.dart';
import 'package:provider/provider.dart';
import 'screens/auth_screen.dart';
import 'screens/home_screen.dart';
import 'screens/professionals_screen.dart';
import 'screens/professional_profile_screen.dart';
import 'screens/booking_screen.dart';
import 'screens/booking_confirmation_screen.dart';
import 'screens/booking_history_screen.dart';
import 'screens/review_screen.dart';
import 'services/auth_service.dart';
import 'services/home_service.dart';
import 'services/review_service.dart'; // Adicionar import
import 'models/category_model.dart';
import 'models/professional_model.dart';
import 'models/booking_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => ReviewService()), // Provider global
      ],
      child: MaterialApp(
        title: 'Hub de Serviços',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: const AuthScreen(),
        routes: {
          '/home': (context) => ChangeNotifierProvider(
                create: (context) => HomeService(),
                child: const HomeScreen(),
              ),
          '/professionals': (context) {
            final category = ModalRoute.of(context)!.settings.arguments as CategoryModel;
            return ProfessionalsScreen(category: category);
          },
          '/professional-profile': (context) {
            final professional = ModalRoute.of(context)!.settings.arguments as ProfessionalModel;
            return ProfessionalProfileScreen(professional: professional);
          },
          '/schedule': (context) {
            final professional = ModalRoute.of(context)!.settings.arguments as ProfessionalModel;
            return BookingScreen(professional: professional);
          },
          '/booking-confirmation': (context) {
            final booking = ModalRoute.of(context)!.settings.arguments as BookingModel;
            return BookingConfirmationScreen(booking: booking);
          },
          '/booking-history': (context) => const BookingHistoryScreen(),
          '/review': (context) {
            final args = ModalRoute.of(context)!.settings.arguments as Map;
            return ReviewScreen(
              booking: args['booking'] as BookingModel,
              professional: args['professional'] as ProfessionalModel,
            );
          },
          // No MaterialApp do main.dart, adicione:
          '/chat': (context) {
            final professional = ModalRoute.of(context)!.settings.arguments as ProfessionalModel;
            return ChatScreen(professional: professional);
          },
          // No MaterialApp do main.dart, adicione:
          '/settings': (context) => const SettingsScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}