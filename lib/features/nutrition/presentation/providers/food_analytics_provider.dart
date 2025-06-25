import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/di/injection_container.dart';
import '../../domain/entities/meal.dart';
import '../../domain/usecases/search_foods_usecase.dart';
import '../../domain/usecases/analyze_food_usecase.dart';

part 'food_analytics_provider.freezed.dart';

@freezed
class FoodAnalyticsState with _$FoodAnalyticsState {
  const factory FoodAnalyticsState.initial() = _Initial;
  const factory FoodAnalyticsState.loading() = _Loading;
  const factory FoodAnalyticsState.loaded(List<FoodAnalytics> analytics) =
      _Loaded;
  const factory FoodAnalyticsState.error(String message) = _Error;
}

@freezed
class FoodSearchState with _$FoodSearchState {
  const factory FoodSearchState.initial() = _SearchInitial;
  const factory FoodSearchState.loading() = _SearchLoading;
  const factory FoodSearchState.loaded(List<Food> foods) = _SearchLoaded;
  const factory FoodSearchState.error(String message) = _SearchError;
}

class FoodAnalyticsNotifier extends StateNotifier<FoodAnalyticsState> {
  final SearchFoodsUseCase _searchFoodsUseCase;
  final AnalyzeFoodUseCase _analyzeFoodUseCase;

  FoodAnalyticsNotifier(
    this._searchFoodsUseCase,
    this._analyzeFoodUseCase,
  ) : super(const FoodAnalyticsState.initial());

  Future<void> analyzeFoodQuantity({
    required String foodId,
    required double quantity,
  }) async {
    state = const FoodAnalyticsState.loading();

    final result = await _analyzeFoodUseCase(
      foodId: foodId,
      quantity: quantity,
    );

    result.fold(
      (failure) => state = FoodAnalyticsState.error(failure.message),
      (analytics) => state = FoodAnalyticsState.loaded([analytics]),
    );
  }

  Future<void> compareFoods({
    required List<String> foodIds,
    required double quantity,
  }) async {
    state = const FoodAnalyticsState.loading();

    try {
      final List<FoodAnalytics> analytics = [];

      for (final foodId in foodIds) {
        final result = await _analyzeFoodUseCase(
          foodId: foodId,
          quantity: quantity,
        );

        result.fold(
          (failure) => throw Exception(failure.message),
          (analysis) => analytics.add(analysis),
        );
      }

      state = FoodAnalyticsState.loaded(analytics);
    } catch (e) {
      state = FoodAnalyticsState.error(e.toString());
    }
  }

  void reset() {
    state = const FoodAnalyticsState.initial();
  }
}

class FoodSearchNotifier extends StateNotifier<FoodSearchState> {
  final SearchFoodsUseCase _searchFoodsUseCase;

  FoodSearchNotifier(this._searchFoodsUseCase)
      : super(const FoodSearchState.initial());

  Future<void> searchFoods(String query) async {
    if (query.isEmpty) {
      state = const FoodSearchState.initial();
      return;
    }

    state = const FoodSearchState.loading();

    final result = await _searchFoodsUseCase(query);

    result.fold(
      (failure) => state = FoodSearchState.error(failure.message),
      (foods) => state = FoodSearchState.loaded(foods),
    );
  }

  void clearSearch() {
    state = const FoodSearchState.initial();
  }
}

final foodAnalyticsProvider =
    StateNotifierProvider<FoodAnalyticsNotifier, FoodAnalyticsState>((ref) {
  return FoodAnalyticsNotifier(
    getIt<SearchFoodsUseCase>(),
    getIt<AnalyzeFoodUseCase>(),
  );
});

final foodSearchProvider =
    StateNotifierProvider<FoodSearchNotifier, FoodSearchState>((ref) {
  return FoodSearchNotifier(getIt<SearchFoodsUseCase>());
});
