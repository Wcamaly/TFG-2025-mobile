import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/nutrition_remote_data_source.dart';
import '../../data/datasources/nutrition_remote_data_source_mock.dart';
import '../../data/repositories/nutrition_repository_impl.dart';
import '../../domain/repositories/nutrition_repository.dart';
import '../../domain/usecases/get_nutrition_goals_usecase.dart';
import '../../domain/usecases/get_daily_meal_plan_usecase.dart';

final nutritionRemoteDataSourceProvider =
    Provider<NutritionRemoteDataSource>((ref) {
  return NutritionRemoteDataSourceMock();
});

final nutritionRepositoryProvider = Provider<NutritionRepository>((ref) {
  return NutritionRepositoryImpl(ref.watch(nutritionRemoteDataSourceProvider));
});

final getNutritionGoalsUseCaseProvider =
    Provider<GetNutritionGoalsUseCase>((ref) {
  return GetNutritionGoalsUseCase(ref.watch(nutritionRepositoryProvider));
});

final getDailyMealPlanUseCaseProvider =
    Provider<GetDailyMealPlanUseCase>((ref) {
  return GetDailyMealPlanUseCase(ref.watch(nutritionRepositoryProvider));
});
