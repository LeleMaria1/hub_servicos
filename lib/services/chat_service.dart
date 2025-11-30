// lib/services/chat_service.dart
import 'package:flutter/foundation.dart';
import '../models/message_model.dart';
import '../models/professional_model.dart';

class ChatService with ChangeNotifier {
  final List<MessageModel> _messages = [];
  final String _currentUserId = 'current_user'; // Mock do usuário atual
  bool _isLoading = false;
  String _newMessage = '';

  List<MessageModel> get messages => _messages;
  bool get isLoading => _isLoading;
  String get newMessage => _newMessage;

  void setNewMessage(String message) {
    _newMessage = message;
    notifyListeners();
  }

  void loadChatHistory(ProfessionalModel professional) {
    _isLoading = true;
    notifyListeners();

    // Simular carregamento do histórico
    Future.delayed(const Duration(seconds: 1), () {
      _messages.clear();
      _messages.addAll(_getMockMessages(professional));
      _isLoading = false;
      notifyListeners();
    });
  }

  List<MessageModel> _getMockMessages(ProfessionalModel professional) {
    return [
      MessageModel(
        id: '1',
        senderId: professional.id,
        senderName: professional.name,
        content: 'Olá! Como posso ajudá-lo hoje?',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        isMe: false,
      ),
      MessageModel(
        id: '2',
        senderId: _currentUserId,
        senderName: 'Você',
        content: 'Preciso de um orçamento para desentupimento.',
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
        isMe: true,
      ),
      MessageModel(
        id: '3',
        senderId: professional.id,
        senderName: professional.name,
        content: 'Claro! Posso ir amanhã às 14h. O endereço é o mesmo do último serviço?',
        timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
        isMe: false,
      ),
    ];
  }

  Future<void> sendMessage(ProfessionalModel professional) async {
    if (_newMessage.isEmpty) return;

    _isLoading = true;
    notifyListeners();

    // Adicionar mensagem do usuário
    final userMessage = MessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderId: _currentUserId,
      senderName: 'Você',
      content: _newMessage,
      timestamp: DateTime.now(),
      isMe: true,
    );

    _messages.add(userMessage);
    _newMessage = '';
    notifyListeners();

    // Simular resposta do profissional após 2 segundos
    await Future.delayed(const Duration(seconds: 2));

    final professionalMessage = MessageModel(
      id: '${DateTime.now().millisecondsSinceEpoch.toString()}_response',
      senderId: professional.id,
      senderName: professional.name,
      content: _getAutoResponse(_newMessage),
      timestamp: DateTime.now(),
      isMe: false,
    );

    _messages.add(professionalMessage);
    _isLoading = false;
    notifyListeners();
  }

  String _getAutoResponse(String userMessage) {
    final message = userMessage.toLowerCase();
    
    if (message.contains('preço') || message.contains('valor') || message.contains('quanto')) {
      return 'O valor do serviço depende da complexidade. Posso fazer uma avaliação presencial sem custo!';
    } else if (message.contains('horário') || message.contains('disponível')) {
      return 'Estou disponível de segunda a sábado, das 8h às 18h. Qual horário prefere?';
    } else if (message.contains('urgente') || message.contains('emergência')) {
      return 'Para urgências, posso atendê-lo hoje ainda. Me informe o endereço!';
    } else {
      return 'Obrigado pela mensagem! Em breve retornarei com mais informações.';
    }
  }

  void clearChat() {
    _messages.clear();
    _newMessage = '';
    notifyListeners();
  }
}