// lib/main.dart
import 'package:flutter/material.dart';
import 'package:hub_servicos/models/category_model.dart';
import 'package:hub_servicos/screens/professionals_screen.dart';
import 'package:provider/provider.dart';
import 'screens/auth_screen.dart';
import 'screens/home_screen.dart';
import 'services/auth_service.dart';
import 'services/home_service.dart';

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
      ],
      child: MaterialApp(
        title: 'Hub de Serviços',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: const AuthScreen(),
        // No MaterialApp do main.dart, adicione:
        routes: {
          '/home': (context) => ChangeNotifierProvider(
                create: (context) => HomeService(),
                child: const HomeScreen(),
              ),
          '/professionals': (context) {
            final category = ModalRoute.of(context)!.settings.arguments as CategoryModel;
            return ProfessionalsScreen(category: category);
          },
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}