import 'package:flutter/material.dart';
import 'package:tfg_2025_mobile/features/workouts/domain/entities/workout_progress.dart';
import '../../features/authentication/presentation/pages/forgot_password_page.dart';
import '../../features/authentication/presentation/pages/login_page.dart';
import '../../features/authentication/presentation/pages/register_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/nutrition/presentation/pages/meal_detail_page.dart';
import '../../features/nutrition/presentation/pages/meal_schedule_page.dart';
import '../../features/nutrition/presentation/pages/meal_search_page.dart';
import '../../features/nutrition/presentation/pages/nutrition_goals_page.dart';
import '../../features/nutrition/presentation/pages/nutrition_page.dart';
import '../../features/nutrition/presentation/pages/food_analytics_page.dart';
import '../../features/nutrition/presentation/pages/nutrition_stats_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../features/workouts/presentation/pages/workout_detail_page.dart';
import '../../features/workouts/presentation/pages/workouts_page.dart';
import '../../features/trainers/presentation/pages/trainer_detail_page.dart';
import '../../features/trainers/presentation/pages/trainer_search_page.dart';
import '../../features/trainers/domain/entities/trainer.dart';
import '../../features/subscriptions/presentation/pages/subscription_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const OnboardingPage());
      case '/splash':
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case '/onboarding':
        return MaterialPageRoute(builder: (_) => const OnboardingPage());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case '/register':
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case '/forgot-password':
        return MaterialPageRoute(builder: (_) => const ForgotPasswordPage());
      case '/dashboard':
        return MaterialPageRoute(builder: (_) => const DashboardPage());
      case '/trainer-search':
        return MaterialPageRoute(builder: (_) => const TrainerSearchPage());
      case '/workouts':
        return MaterialPageRoute(builder: (_) => const WorkoutsPage());
      case '/workout-detail':
        final goal = settings.arguments as DailyGoal;
        return MaterialPageRoute(
          builder: (_) => WorkoutDetailPage(goal: goal),
        );
      case '/trainer-detail':
        final trainer = settings.arguments as Trainer;
        return MaterialPageRoute(
          builder: (_) => TrainerDetailPage(trainer: trainer),
        );
      case '/subscription':
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => SubscriptionPage(
            trainer: args['trainer'] as Trainer,
            package: args['package'] as TrainerPackage,
          ),
        );
      case '/nutrition':
        return MaterialPageRoute(builder: (_) => const NutritionPage());
      case '/food-analytics':
        return MaterialPageRoute(builder: (_) => const FoodAnalyticsPage());
      case '/nutrition-stats':
        return MaterialPageRoute(builder: (_) => const NutritionStatsPage());
      case '/meal-detail':
        final mealId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => MealDetailPage(mealId: mealId),
        );
      case '/meal-search':
        return MaterialPageRoute(builder: (_) => const MealSearchPage());
      case '/nutrition-goals':
        return MaterialPageRoute(builder: (_) => const NutritionGoalsPage());
      case '/meal-schedule':
        return MaterialPageRoute(builder: (_) => const MealSchedulePage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
