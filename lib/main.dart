import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tfg_2025_mobile/core/database/tables/users_table.dart';
import 'core/theme/theme_provider.dart' as theme_provider;
import 'core/providers/locale_provider.dart';
import 'core/di/injection_container.dart';
import 'core/database/app_database.dart';
import 'core/config/env_config.dart';
import 'core/config/remote_config_service.dart';
import 'core/routes/app_router.dart';
import 'core/utils/debug_utils.dart';
import 'features/splash/presentation/pages/splash_page.dart';
import 'features/onboarding/presentation/pages/onboarding_page.dart';
import 'features/authentication/presentation/pages/login_page.dart';
import 'features/authentication/presentation/pages/register_page.dart';
import 'features/authentication/presentation/pages/forgot_password_page.dart';
import 'features/dashboard/presentation/pages/dashboard_page.dart';
import 'features/authentication/presentation/providers/auth_provider.dart';
import 'features/authentication/domain/entities/user.dart';
import 'features/onboarding/presentation/providers/onboarding_provider.dart';
import 'features/trainers/presentation/pages/trainer_search_page.dart';
import 'features/trainers/presentation/pages/trainer_detail_page.dart';
import 'features/trainers/domain/entities/trainer.dart';
import 'features/subscriptions/presentation/pages/subscription_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize debug utils and log filter FIRST
  DebugUtils.initializeLogFilter();
  DebugUtils.logInfo('🚀 Initializing Gymnestic App');

  // Initialize Easy Localization
  await EasyLocalization.ensureInitialized();
  DebugUtils.logInfo('✅ Easy Localization initialized');

  // Initialize environment variables
  await EnvConfig.initialize();
  DebugUtils.logInfo('✅ Environment config initialized');

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  DebugUtils.logInfo('✅ Firebase initialized');

  // Initialize Remote Config
  await RemoteConfigService.initialize();
  DebugUtils.logInfo('✅ Remote Config initialized');

  // Initialize other dependencies
  await initializeDependencies();
  DebugUtils.logInfo('✅ Dependencies initialized');

  // Ensure seed data is loaded
  final database = sl<AppDatabase>();
  await database.ensureSeedData();
  DebugUtils.logInfo('✅ Seed data loaded');

  DebugUtils.logSeparator('APP READY');

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('es'), Locale('fr')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const ProviderScope(child: MyApp()),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(theme_provider.themeProvider);

    return MaterialApp(
      title: 'Gymnestic',
      theme: theme_provider.AppTheme.lightTheme,
      darkTheme: theme_provider.AppTheme.darkTheme,
      themeMode: themeMode,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: Consumer(
        builder: (context, ref, child) {
          return const AppInitializer();
        },
      ),
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}

class AppInitializer extends ConsumerStatefulWidget {
  const AppInitializer({super.key});

  @override
  ConsumerState<AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends ConsumerState<AppInitializer> {
  @override
  void initState() {
    super.initState();
    _checkInitialRoute();
  }

  Future<void> _checkInitialRoute() async {
    // Verificar si el onboarding fue completado
    final isOnboardingCompleted =
        await ref.read(onboardingProvider.notifier).isOnboardingCompleted();

    if (!mounted) return;

    if (!isOnboardingCompleted) {
      // Si no se completó el onboarding, ir al onboarding
      Navigator.pushReplacementNamed(context, '/onboarding');
      return;
    }

    // Si el onboarding fue completado, verificar autenticación
    final authState = ref.read(authProvider);
    authState.when(
      initial: () => Navigator.pushReplacementNamed(context, '/splash'),
      loading: () => Navigator.pushReplacementNamed(context, '/splash'),
      authenticated: (user) {
        final route =
            user.role == UserRole.trainer ? '/trainer-dashboard' : '/dashboard';
        Navigator.pushReplacementNamed(context, route);
      },
      unauthenticated: (message) =>
          Navigator.pushReplacementNamed(context, '/login'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SplashPage(); // Mostrar splash mientras se determina la ruta
  }
}
