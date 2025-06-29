import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/inputs/search_bar.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/database/app_database.dart';
import '../widgets/trainer_map_view.dart';
import '../widgets/trainer_list_item.dart';
import '../providers/trainer_search_provider.dart';

class TrainerSearchPage extends ConsumerStatefulWidget {
  const TrainerSearchPage({super.key});

  @override
  ConsumerState<TrainerSearchPage> createState() => _TrainerSearchPageState();
}

class _TrainerSearchPageState extends ConsumerState<TrainerSearchPage> {
  final TextEditingController _searchController = TextEditingController();
  bool _isMapView = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(trainerSearchProvider.notifier).searchTrainers('');
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(trainerSearchProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header with search
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: AppColors.surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Search bar
                  CustomSearchBar(
                    controller: _searchController,
                    hint: 'What do you look for?',
                    onChanged: (query) {
                      ref
                          .read(trainerSearchProvider.notifier)
                          .searchTrainers(query);
                    },
                  ),
                  const SizedBox(height: 12),

                  // View toggle
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Botón temporal para insertar entrenadores de ejemplo
                      if (kDebugMode)
                        ElevatedButton.icon(
                          onPressed: () async {
                            try {
                              final database = sl<AppDatabase>();
                              await database.insertSampleUsers();
                              // Recargar la búsqueda
                              ref
                                  .read(trainerSearchProvider.notifier)
                                  .searchTrainers('');
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      '✅ Usuarios de ejemplo insertados (entrenadores y estudiantes)'),
                                ),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('❌ Error: $e'),
                                ),
                              );
                            }
                          },
                          icon: const Icon(Icons.add, size: 16),
                          label: const Text('Insertar Usuarios'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.success,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _ViewToggleButton(
                              icon: Icons.map_outlined,
                              isSelected: _isMapView,
                              onTap: () => setState(() => _isMapView = true),
                            ),
                            _ViewToggleButton(
                              icon: Icons.list_outlined,
                              isSelected: !_isMapView,
                              onTap: () => setState(() => _isMapView = false),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: searchState.when(
                initial: () =>
                    const Center(child: Text('Start searching for trainers')),
                loading: () => const Center(child: CircularProgressIndicator()),
                loaded: (trainers) => _isMapView
                    ? TrainerMapView(trainers: trainers)
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: trainers.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: TrainerListItem(
                              trainer: trainers[index],
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/trainer-detail',
                                  arguments: trainers[index],
                                );
                              },
                            ),
                          );
                        },
                      ),
                error: (message) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 48,
                        color: AppColors.error,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Error: $message',
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: AppColors.error,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ViewToggleButton extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _ViewToggleButton({
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.white : AppColors.textSecondary,
          size: 20,
        ),
      ),
    );
  }
}
