// lib/screens/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/user_settings_service.dart';
import '../services/auth_service.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserSettingsService(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Configurações',
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
        body: const _SettingsContent(),
      ),
    );
  }
}

class _SettingsContent extends StatelessWidget {
  const _SettingsContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settingsService = Provider.of<UserSettingsService>(context);
    final authService = Provider.of<AuthService>(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Perfil do usuário
          _buildUserProfileSection(context, authService),
          const SizedBox(height: 24),

          // Notificações
          _buildNotificationsSection(settingsService),
          const SizedBox(height: 24),

          // Aparência
          _buildAppearanceSection(settingsService),
          const SizedBox(height: 24),

          // Preferências
          _buildPreferencesSection(context, settingsService),
          const SizedBox(height: 24),

          // Sobre e suporte
          _buildAboutSupportSection(context),
          const SizedBox(height: 24),

          // Ações
          _buildActionsSection(context, authService, settingsService),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildUserProfileSection(BuildContext context, AuthService authService) {
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
                    authService.currentUser?.name ?? 'Usuário',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    authService.currentUser?.email ?? 'email@exemplo.com',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Funcionalidade em desenvolvimento'),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.blue,
                      side: const BorderSide(color: Colors.blue),
                    ),
                    child: const Text('Editar Perfil'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationsSection(UserSettingsService settingsService) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Notificações',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildSettingSwitch(
          title: 'Notificações',
          subtitle: 'Receber notificações do app',
          value: settingsService.notificationsEnabled,
          onChanged: settingsService.toggleNotifications,
        ),
        if (settingsService.notificationsEnabled) ...[
          const SizedBox(height: 12),
          _buildSettingSwitch(
            title: 'Notificações por Email',
            subtitle: 'Receber notificações por email',
            value: settingsService.emailNotifications,
            onChanged: settingsService.toggleEmailNotifications,
          ),
          const SizedBox(height: 12),
          _buildSettingSwitch(
            title: 'Notificações Push',
            subtitle: 'Receber notificações no celular',
            value: settingsService.pushNotifications,
            onChanged: settingsService.togglePushNotifications,
          ),
        ],
      ],
    );
  }

  Widget _buildAppearanceSection(UserSettingsService settingsService) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Aparência',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildSettingSwitch(
          title: 'Modo Escuro',
          subtitle: 'Ativar tema escuro',
          value: settingsService.darkModeEnabled,
          onChanged: settingsService.toggleDarkMode,
        ),
      ],
    );
  }

  Widget _buildPreferencesSection(BuildContext context, UserSettingsService settingsService) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Preferências',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildSettingOption(
          title: 'Idioma',
          subtitle: settingsService.language,
          onTap: () => _showLanguageDialog(context, settingsService),
        ),
        const SizedBox(height: 12),
        _buildSettingOption(
          title: 'Moeda',
          subtitle: settingsService.currency,
          onTap: () => _showCurrencyDialog(context, settingsService),
        ),
      ],
    );
  }

  Widget _buildAboutSupportSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Sobre e Suporte',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildSettingOption(
          title: 'Ajuda e Suporte',
          subtitle: 'Tire suas dúvidas',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Central de ajuda em desenvolvimento'),
              ),
            );
          },
        ),
        const SizedBox(height: 12),
        _buildSettingOption(
          title: 'Política de Privacidade',
          subtitle: 'Leia nossa política',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Política de privacidade em desenvolvimento'),
              ),
            );
          },
        ),
        const SizedBox(height: 12),
        _buildSettingOption(
          title: 'Termos de Uso',
          subtitle: 'Termos e condições',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Termos de uso em desenvolvimento'),
              ),
            );
          },
        ),
        const SizedBox(height: 12),
        _buildSettingOption(
          title: 'Versão do App',
          subtitle: '1.0.0',
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildActionsSection(BuildContext context, AuthService authService, UserSettingsService settingsService) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ações',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              _showResetDialog(context, settingsService);
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.orange,
              side: const BorderSide(color: Colors.orange),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: const Text('Restaurar Padrões'),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              _showLogoutDialog(context, authService);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: const Text('Sair da Conta'),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingSwitch({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.blue,
        ),
      ],
    );
  }

  Widget _buildSettingOption({
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.grey,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }

  void _showLanguageDialog(BuildContext context, UserSettingsService settingsService) {
    final languages = ['Português', 'English', 'Español'];
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Selecionar Idioma'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: languages.map((language) {
            return RadioListTile(
              title: Text(language),
              value: language,
              groupValue: settingsService.language,
              onChanged: (value) {
                settingsService.setLanguage(value.toString());
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showCurrencyDialog(BuildContext context, UserSettingsService settingsService) {
    final currencies = ['BRL (R\$)', 'USD (\$)', 'EUR (€)'];
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Selecionar Moeda'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: currencies.map((currency) {
            return RadioListTile(
              title: Text(currency),
              value: currency,
              groupValue: settingsService.currency,
              onChanged: (value) {
                settingsService.setCurrency(value.toString());
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showResetDialog(BuildContext context, UserSettingsService settingsService) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Restaurar Padrões'),
        content: const Text('Tem certeza que deseja restaurar todas as configurações para os valores padrão?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              settingsService.resetToDefaults();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Configurações restauradas com sucesso!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Restaurar'),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, AuthService authService) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sair da Conta'),
        content: const Text('Tem certeza que deseja sair da sua conta?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              authService.logout();
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Logout realizado com sucesso!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Sair'),
          ),
        ],
      ),
    );
  }
}