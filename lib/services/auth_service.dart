// lib/services/auth_service.dart
import 'package:flutter/foundation.dart';
import '../models/user_model.dart';

class AuthService with ChangeNotifier {
  UserModel? _currentUser;
  bool _isLoading = false;
  String _errorMessage = '';

  // Lista de usuários "cadastrados" (mock)
  final List<UserModel> _registeredUsers = [
    UserModel(
      id: '1',
      name: 'Usuário Teste',
      email: 'teste@email.com',
      phone: '(11) 99999-9999',
      userType: 'client',
    ),
  ];

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Login agora verifica se o usuário existe
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    // Simular delay de rede
    await Future.delayed(const Duration(seconds: 2));

    try {
      if (email.isEmpty || password.isEmpty) {
        throw Exception('Email e senha são obrigatórios');
      }

      // Verificar se o usuário existe na lista de cadastrados
      final user = _registeredUsers.firstWhere(
        (user) => user.email == email,
        orElse: () => UserModel(
          id: '',
          name: '',
          email: '',
          phone: '',
          userType: '',
        ),
      );

      if (user.id.isEmpty) {
        throw Exception('Usuário não encontrado. Faça o cadastro primeiro.');
      }

      // Verificar senha (mock - na prática seria hash)
      if (password != '123456') { // Senha padrão para teste
        throw Exception('Senha incorreta. Tente: 123456');
      }

      _currentUser = user;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Cadastro agora adiciona o usuário à lista
  Future<bool> register(String name, String email, String password, String phone) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    try {
      if (name.isEmpty || email.isEmpty || password.isEmpty || phone.isEmpty) {
        throw Exception('Preencha todos os campos obrigatórios');
      }

      // Verificar se o email já está cadastrado
      final existingUser = _registeredUsers.firstWhere(
        (user) => user.email == email,
        orElse: () => UserModel(
          id: '',
          name: '',
          email: '',
          phone: '',
          userType: '',
        ),
      );

      if (existingUser.id.isNotEmpty) {
        throw Exception('Este email já está cadastrado');
      }

      if (password.length < 6) {
        throw Exception('A senha deve ter pelo menos 6 caracteres');
      }

      // Criar novo usuário
      final newUser = UserModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        email: email,
        phone: phone,
        userType: 'client',
      );

      // Adicionar à lista de usuários cadastrados
      _registeredUsers.add(newUser);
      
      _currentUser = newUser;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Logout
  void logout() {
    _currentUser = null;
    notifyListeners();
  }

  // Método para debug: ver usuários cadastrados
  List<UserModel> get registeredUsers => _registeredUsers;
}