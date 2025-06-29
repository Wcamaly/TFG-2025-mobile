import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/theme_provider.dart' as theme_provider;
import '../../../../core/providers/locale_provider.dart';
import '../../../authentication/presentation/providers/auth_provider.dart';

// Provider para el tema en string
final themeStringProvider = StateProvider<String>((ref) => 'Oscuro');

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localeProvider);
    final selectedTheme = ref.watch(themeStringProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'settings'.tr(),
          style: AppTextStyles.headlineMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // Sección de Cuenta
              _buildSectionTitle('Cuenta'),
              const SizedBox(height: 12),
              _SettingsMenuItem(
                icon: Icons.notifications_outlined,
                title: 'Notificaciones',
                subtitle: 'Gestiona tus notificaciones',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotificationsSettingsPage(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 32),

              // Sección de Aplicación
              _buildSectionTitle('Aplicación'),
              const SizedBox(height: 12),

              // Selector de idioma
              _LanguageSelector(
                currentLocale: currentLocale,
                onLanguageChanged: (languageCode) async {
                  await ref
                      .read(localeProvider.notifier)
                      .setLocale(languageCode, context);
                },
              ),

              const SizedBox(height: 8),

              // Selector de tema
              _ThemeSelector(
                selectedTheme: selectedTheme,
                onThemeChanged: (theme) {
                  ref.read(themeStringProvider.notifier).state = theme;
                  // Cambiar el tema usando el provider de tema
                  final themeMode =
                      theme == 'Oscuro' ? ThemeMode.dark : ThemeMode.light;
                  ref.read(theme_provider.themeProvider.notifier).state =
                      themeMode;
                },
              ),

              const SizedBox(height: 32),

              // Sección de Soporte
              _buildSectionTitle('Soporte'),
              const SizedBox(height: 12),
              _SettingsMenuItem(
                icon: Icons.help_outline,
                title: 'Ayuda y Soporte',
                subtitle: 'Preguntas frecuentes y contacto',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HelpSupportPage(),
                    ),
                  );
                },
              ),
              _SettingsMenuItem(
                icon: Icons.info_outline,
                title: 'Acerca de',
                subtitle: 'Versión de la aplicación e información',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AboutPage(),
                    ),
                  );
                },
              ),
              _SettingsMenuItem(
                icon: Icons.star_outline,
                title: 'Valorar la App',
                subtitle: 'Ayúdanos con tu calificación',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Función en desarrollo'),
                      backgroundColor: AppColors.primary,
                    ),
                  );
                },
              ),

              const SizedBox(height: 32),

              // Botón de cerrar sesión
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.error.withOpacity(0.3)),
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.logout,
                    color: AppColors.error,
                  ),
                  title: Text(
                    'Cerrar Sesión',
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.error,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () {
                    _showLogoutDialog(context, ref);
                  },
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: AppTextStyles.headlineMedium.copyWith(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text(
          '¿Cerrar Sesión?',
          style: AppTextStyles.headlineMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          '¿Estás seguro de que quieres cerrar sesión?',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancelar',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(authProvider.notifier).signOut(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
            ),
            child: const Text('Cerrar Sesión'),
          ),
        ],
      ),
    );
  }
}

// Widget para selector de idioma
class _LanguageSelector extends StatelessWidget {
  final Locale currentLocale;
  final Function(String) onLanguageChanged;

  const _LanguageSelector({
    required this.currentLocale,
    required this.onLanguageChanged,
  });

  String _getLanguageName(String languageCode) {
    switch (languageCode) {
      case 'es':
        return 'Español';
      case 'en':
        return 'English';
      case 'fr':
        return 'Français';
      default:
        return 'Español';
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentLanguageName = _getLanguageName(currentLocale.languageCode);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        leading: const Icon(
          Icons.language_outlined,
          color: AppColors.primary,
        ),
        title: Text(
          'Idioma',
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          currentLanguageName,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        children: [
          _LanguageOption(
            language: 'Español',
            isSelected: currentLocale.languageCode == 'es',
            onTap: () => onLanguageChanged('es'),
          ),
          _LanguageOption(
            language: 'English',
            isSelected: currentLocale.languageCode == 'en',
            onTap: () => onLanguageChanged('en'),
          ),
          _LanguageOption(
            language: 'Français',
            isSelected: currentLocale.languageCode == 'fr',
            onTap: () => onLanguageChanged('fr'),
          ),
        ],
      ),
    );
  }
}

// Widget para opción de idioma
class _LanguageOption extends StatelessWidget {
  final String language;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageOption({
    required this.language,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        language,
        style: AppTextStyles.bodyMedium.copyWith(
          color: isSelected ? AppColors.primary : AppColors.textPrimary,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      trailing: isSelected
          ? const Icon(
              Icons.check,
              color: AppColors.primary,
            )
          : null,
      onTap: onTap,
    );
  }
}

// Widget para selector de tema
class _ThemeSelector extends StatelessWidget {
  final String selectedTheme;
  final Function(String) onThemeChanged;

  const _ThemeSelector({
    required this.selectedTheme,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        leading: Icon(
          selectedTheme == 'Claro'
              ? Icons.light_mode_outlined
              : Icons.dark_mode_outlined,
          color: AppColors.primary,
        ),
        title: Text(
          'Tema',
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          selectedTheme,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        children: [
          _ThemeOption(
            theme: 'Claro',
            icon: Icons.light_mode_outlined,
            isSelected: selectedTheme == 'Claro',
            onTap: () => onThemeChanged('Claro'),
          ),
          _ThemeOption(
            theme: 'Oscuro',
            icon: Icons.dark_mode_outlined,
            isSelected: selectedTheme == 'Oscuro',
            onTap: () => onThemeChanged('Oscuro'),
          ),
        ],
      ),
    );
  }
}

// Widget para opción de tema
class _ThemeOption extends StatelessWidget {
  final String theme;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThemeOption({
    required this.theme,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? AppColors.primary : AppColors.textSecondary,
      ),
      title: Text(
        theme,
        style: AppTextStyles.bodyMedium.copyWith(
          color: isSelected ? AppColors.primary : AppColors.textPrimary,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      trailing: isSelected
          ? const Icon(
              Icons.check,
              color: AppColors.primary,
            )
          : null,
      onTap: onTap,
    );
  }
}

class _SettingsMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SettingsMenuItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: AppColors.primary,
        ),
        title: Text(
          title,
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: AppColors.textSecondary,
        ),
        onTap: onTap,
      ),
    );
  }
}

// Páginas de configuración específicas (placeholder)
class NotificationsSettingsPage extends StatelessWidget {
  const NotificationsSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Notificaciones',
          style: AppTextStyles.headlineMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: const Center(
        child: Text('Configuración de notificaciones - En desarrollo'),
      ),
    );
  }
}

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Ayuda y Soporte',
          style: AppTextStyles.headlineMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: const Center(
        child: Text('Ayuda y soporte - En desarrollo'),
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Acerca de',
          style: AppTextStyles.headlineMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: const Center(
        child: Text('Información de la aplicación - En desarrollo'),
      ),
    );
  }
}
