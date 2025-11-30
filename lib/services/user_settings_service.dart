// lib/services/user_settings_service.dart
import 'package:flutter/foundation.dart';

class UserSettingsService with ChangeNotifier {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  bool _emailNotifications = true;
  bool _pushNotifications = true;
  String _language = 'Português';
  String _currency = 'BRL (R\$)';

  bool get notificationsEnabled => _notificationsEnabled;
  bool get darkModeEnabled => _darkModeEnabled;
  bool get emailNotifications => _emailNotifications;
  bool get pushNotifications => _pushNotifications;
  String get language => _language;
  String get currency => _currency;

  void toggleNotifications(bool value) {
    _notificationsEnabled = value;
    notifyListeners();
  }

  void toggleDarkMode(bool value) {
    _darkModeEnabled = value;
    notifyListeners();
  }

  void toggleEmailNotifications(bool value) {
    _emailNotifications = value;
    notifyListeners();
  }

  void togglePushNotifications(bool value) {
    _pushNotifications = value;
    notifyListeners();
  }

  void setLanguage(String language) {
    _language = language;
    notifyListeners();
  }

  void setCurrency(String currency) {
    _currency = currency;
    notifyListeners();
  }

  void resetToDefaults() {
    _notificationsEnabled = true;
    _darkModeEnabled = false;
    _emailNotifications = true;
    _pushNotifications = true;
    _language = 'Português';
    _currency = 'BRL (R\$)';
    notifyListeners();
  }
}