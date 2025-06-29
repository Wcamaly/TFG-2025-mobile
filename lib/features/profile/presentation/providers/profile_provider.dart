import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/di/injection_container.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/usecases/get_current_profile_usecase.dart';
import '../../domain/usecases/update_profile_usecase.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../data/repositories/profile_repository_impl.dart';
import '../../data/datasources/profile_local_data_source.dart';
import '../../../../core/database/app_database.dart';
import '../../../authentication/presentation/providers/auth_provider.dart';

// Provider para el repositorio
final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  final database = sl<AppDatabase>();
  final localDataSource = ProfileLocalDataSourceImpl(database);
  return ProfileRepositoryImpl(localDataSource: localDataSource);
});

// Provider para los use cases
final getCurrentProfileUseCaseProvider =
    Provider<GetCurrentProfileUseCase>((ref) {
  return GetCurrentProfileUseCase(ref.watch(profileRepositoryProvider));
});

final updateProfileUseCaseProvider = Provider<UpdateProfileUseCase>((ref) {
  return UpdateProfileUseCase(ref.watch(profileRepositoryProvider));
});

// Provider para el estado del perfil
final profileProvider =
    StateNotifierProvider<ProfileNotifier, ProfileState>((ref) {
  return ProfileNotifier(
    ref.watch(getCurrentProfileUseCaseProvider),
    ref.watch(updateProfileUseCaseProvider),
    ref,
  );
});

class ProfileNotifier extends StateNotifier<ProfileState> {
  final GetCurrentProfileUseCase _getCurrentProfileUseCase;
  final UpdateProfileUseCase _updateProfileUseCase;
  final Ref _ref;

  ProfileNotifier(
    this._getCurrentProfileUseCase,
    this._updateProfileUseCase,
    this._ref,
  ) : super(const ProfileState.initial()) {
    loadProfile();
  }

  Future<void> loadProfile() async {
    state = const ProfileState.loading();

    // Obtener el usuario autenticado actual
    final authState = _ref.read(authProvider);

    String? currentUserId;
    authState.when(
      initial: () => currentUserId = null,
      loading: () => currentUserId = null,
      authenticated: (user) => currentUserId = user.id,
      unauthenticated: (_) => currentUserId = null,
    );

    if (currentUserId == null) {
      state = const ProfileState.error('Usuario no autenticado');
      return;
    }

    // Obtener el perfil usando el repositorio directamente con el ID del usuario
    final repository = _ref.read(profileRepositoryProvider);
    final result = await (repository as ProfileRepositoryImpl)
        .getCurrentUserProfileById(currentUserId!);

    result.fold(
      (failure) => state = ProfileState.error(failure.message),
      (profile) => state = ProfileState.loaded(profile),
    );
  }

  Future<void> refreshProfile() async {
    await loadProfile();
  }

  Future<bool> updateProfile(UserProfile updatedProfile) async {
    state = const ProfileState.loading();

    final result = await _updateProfileUseCase.call(updatedProfile);

    return result.fold(
      (failure) {
        state = ProfileState.error(failure.message);
        return false;
      },
      (profile) {
        state = ProfileState.loaded(profile);
        return true;
      },
    );
  }
}

class ProfileState {
  const ProfileState();

  const factory ProfileState.initial() = _Initial;
  const factory ProfileState.loading() = _Loading;
  const factory ProfileState.loaded(UserProfile profile) = _Loaded;
  const factory ProfileState.error(String message) = _Error;

  T when<T>({
    required T Function() initial,
    required T Function() loading,
    required T Function(UserProfile profile) loaded,
    required T Function(String message) error,
  }) {
    if (this is _Initial) return initial();
    if (this is _Loading) return loading();
    if (this is _Loaded) return loaded((this as _Loaded).profile);
    if (this is _Error) return error((this as _Error).message);
    throw Exception('Unknown state');
  }
}

class _Initial extends ProfileState {
  const _Initial();
}

class _Loading extends ProfileState {
  const _Loading();
}

class _Loaded extends ProfileState {
  final UserProfile profile;
  const _Loaded(this.profile);
}

class _Error extends ProfileState {
  final String message;
  const _Error(this.message);
}
