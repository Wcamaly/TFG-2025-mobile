import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/database/app_database.dart';
import '../providers/routines_provider.dart';
import '../../domain/entities/routine.dart';
import '../widgets/routine_card.dart';
import '../pages/routine_detail_page.dart';
import '../pages/assign_routine_page.dart';
import '../../../authentication/presentation/providers/auth_provider.dart';

// Provider para la base de datos
final databaseProvider = Provider<AppDatabase>((ref) => sl<AppDatabase>());

class RoutinesListPage extends ConsumerStatefulWidget {
  const RoutinesListPage({super.key});

  @override
  ConsumerState<RoutinesListPage> createState() => _RoutinesListPageState();
}

class _RoutinesListPageState extends ConsumerState<RoutinesListPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'all';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _searchController.addListener(_onSearchChanged);

    // Cargar rutinas iniciales
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(routinesProvider.notifier).loadRoutines();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(routinesProvider.notifier).loadRoutines();
    }
  }

  void _onSearchChanged() {
    ref.read(routinesProvider.notifier).searchRoutines(_searchController.text);
  }

  void _onFilterChanged(String filter) {
    setState(() {
      _selectedFilter = filter;
    });
    ref.read(routinesProvider.notifier).filterRoutines(filter);
  }

  @override
  Widget build(BuildContext context) {
    final routinesState = ref.watch(routinesProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'routines'.tr(),
          style: AppTextStyles.headlineMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
        actions: [
          // Botón para limpiar base de datos
          IconButton(
            icon: const Icon(Icons.clear_all),
            tooltip: 'Limpiar base de datos',
            onPressed: () async {
              try {
                print('🔄 DEBUG BUTTON: Clearing database...');

                // Solo limpiar la base de datos, sin insertar datos seed
                final database = ref.read(databaseProvider);
                await database.customStatement('DELETE FROM student_routines');
                await database.customStatement('DELETE FROM routines');
                await database.customStatement('DELETE FROM payments');
                await database.customStatement('DELETE FROM students');
                // No eliminar usuarios para mantener la sesión

                print('🗑️ Database cleared');

                // Recargar rutinas (debería mostrar lista vacía)
                await ref.read(routinesProvider.notifier).refreshRoutines();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Base de datos limpiada - Lista vacía'),
                    backgroundColor: Colors.green,
                  ),
                );
              } catch (e) {
                print('❌ DEBUG BUTTON: Error - $e');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error: $e'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),
          // Botón para cargar datos de ejemplo
          IconButton(
            icon: const Icon(Icons.download),
            tooltip: 'Cargar datos de ejemplo',
            onPressed: () async {
              try {
                print('📥 Loading sample data...');

                final authState = ref.read(authProvider);
                final trainerId = authState.when(
                  initial: () => 1,
                  loading: () => 1,
                  authenticated: (user) => int.tryParse(user.id) ?? 1,
                  unauthenticated: (_) => 1,
                );

                final database = ref.read(databaseProvider);
                await database.insertSeedRoutinesForTrainer(trainerId);
                await database.insertSeedStudentsForTrainer(trainerId);

                // Recargar rutinas
                await ref.read(routinesProvider.notifier).refreshRoutines();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Datos de ejemplo cargados'),
                    backgroundColor: Colors.blue,
                  ),
                );
              } catch (e) {
                print('❌ ERROR: $e');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error: $e'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showCreateRoutineDialog,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(routinesProvider.notifier).refreshRoutines(),
        child: Column(
          children: [
            // Barra de búsqueda y filtros
            _buildSearchAndFilters(),

            // Lista de rutinas
            Expanded(
              child: routinesState.isLoading && routinesState.routines.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : routinesState.routines.isEmpty
                      ? _buildEmptyState()
                      : _buildRoutinesList(routinesState),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: AppColors.surface,
      child: Column(
        children: [
          // Barra de búsqueda
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'searchRoutines'.tr(),
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: AppColors.background,
            ),
          ),
          const SizedBox(height: 12),

          // Filtros
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip('all', 'all'.tr()),
                const SizedBox(width: 8),
                _buildFilterChip('active', 'active'.tr()),
                const SizedBox(width: 8),
                _buildFilterChip('paused', 'paused'.tr()),
                const SizedBox(width: 8),
                _buildFilterChip('completed', 'completed'.tr()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String filter, String label) {
    final isSelected = _selectedFilter == filter;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => _onFilterChanged(filter),
      backgroundColor: AppColors.background,
      selectedColor: AppColors.primary.withOpacity(0.2),
      labelStyle: TextStyle(
        color: isSelected ? AppColors.primary : AppColors.textSecondary,
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.fitness_center,
            size: 64,
            color: AppColors.textSecondary,
          ),
          const SizedBox(height: 16),
          Text(
            'No tienes rutinas creadas',
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Crea tu primera rutina o carga datos de ejemplo',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: _showCreateRoutineDialog,
                icon: const Icon(Icons.add),
                label: Text('createRoutine'.tr()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                onPressed: () async {
                  try {
                    final authState = ref.read(authProvider);
                    final trainerId = authState.when(
                      initial: () => 1,
                      loading: () => 1,
                      authenticated: (user) => int.tryParse(user.id) ?? 1,
                      unauthenticated: (_) => 1,
                    );

                    final database = ref.read(databaseProvider);
                    await database.insertSeedRoutinesForTrainer(trainerId);

                    await ref.read(routinesProvider.notifier).refreshRoutines();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Rutinas de ejemplo cargadas'),
                        backgroundColor: Colors.blue,
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error: $e'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.download),
                label: const Text('Cargar ejemplos'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRoutinesList(RoutinesState state) {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: state.routines.length + (state.hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == state.routines.length) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final routine = state.routines[index];
        return RoutineCard(
          routine: routine,
          onTap: () => _onRoutineTap(routine),
          onEdit: () => _onEditRoutine(routine),
          onDelete: () => _onDeleteRoutine(routine),
          onAssign: () => _onAssignRoutine(routine),
        );
      },
    );
  }

  void _onRoutineTap(Routine routine) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RoutineDetailPage(routine: routine),
      ),
    ).then((result) {
      // Si se editó la rutina, recargar la lista
      if (result == 'edit') {
        ref.read(routinesProvider.notifier).refreshRoutines();
      }
    });
  }

  void _onEditRoutine(Routine routine) {
    _showCreateRoutineDialog(routine: routine);
  }

  void _onDeleteRoutine(Routine routine) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('deleteRoutine'.tr()),
        content: Text('deleteRoutineConfirmation'.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('cancel'.tr()),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(routinesProvider.notifier).deleteRoutine(routine.id);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('routineDeleted'.tr())),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            child: Text('delete'.tr()),
          ),
        ],
      ),
    );
  }

  void _onAssignRoutine(Routine routine) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AssignRoutinePage(routine: routine),
      ),
    ).then((assigned) {
      if (assigned == true) {
        // Recargar rutinas para actualizar el contador de estudiantes asignados
        ref.read(routinesProvider.notifier).refreshRoutines();
      }
    });
  }

  void _showCreateRoutineDialog({Routine? routine}) {
    final isEditing = routine != null;
    final nameController = TextEditingController(text: routine?.name ?? '');
    final descriptionController =
        TextEditingController(text: routine?.description ?? '');
    final durationController =
        TextEditingController(text: routine?.duration.toString() ?? '');
    String selectedCategory = routine?.category ?? 'strength';
    String selectedDifficulty = routine?.difficulty.name ?? 'beginner';

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(isEditing ? 'editRoutine'.tr() : 'createRoutine'.tr()),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'routineName'.tr(),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: descriptionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'description'.tr(),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: durationController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'duration'.tr(),
                          suffixText: 'min',
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: selectedCategory,
                  decoration: InputDecoration(
                    labelText: 'category'.tr(),
                    border: const OutlineInputBorder(),
                  ),
                  items: ['strength', 'cardio', 'flexibility', 'mixed']
                      .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(category.tr()),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setDialogState(() {
                        selectedCategory = value;
                      });
                    }
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: selectedDifficulty,
                  decoration: InputDecoration(
                    labelText: 'difficulty'.tr(),
                    border: const OutlineInputBorder(),
                  ),
                  items: ['beginner', 'intermediate', 'advanced']
                      .map((difficulty) => DropdownMenuItem(
                            value: difficulty,
                            child: Text(difficulty.tr()),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setDialogState(() {
                        selectedDifficulty = value;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('cancel'.tr()),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    descriptionController.text.isNotEmpty &&
                    durationController.text.isNotEmpty) {
                  final authState = ref.read(authProvider);
                  final trainerId = authState.when(
                    initial: () => 1,
                    loading: () => 1,
                    authenticated: (user) => int.tryParse(user.id) ?? 1,
                    unauthenticated: (_) => 1,
                  );

                  if (isEditing) {
                    final updatedRoutine = routine!.copyWith(
                      name: nameController.text,
                      description: descriptionController.text,
                      duration: int.tryParse(durationController.text) ?? 30,
                      category: selectedCategory,
                      difficulty: _parseDifficulty(selectedDifficulty),
                      updatedAt: DateTime.now(),
                    );

                    ref
                        .read(routinesProvider.notifier)
                        .updateRoutine(updatedRoutine);
                  } else {
                    final newRoutine = Routine(
                      id: 0, // Will be assigned by database
                      name: nameController.text,
                      description: descriptionController.text,
                      category: selectedCategory,
                      duration: int.tryParse(durationController.text) ?? 30,
                      difficulty: _parseDifficulty(selectedDifficulty),
                      exercises: const [],
                      createdBy: trainerId,
                      status: RoutineStatus.active,
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    );

                    ref
                        .read(routinesProvider.notifier)
                        .createRoutine(newRoutine);
                  }

                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(isEditing
                          ? 'routineUpdated'.tr()
                          : 'routineCreated'.tr()),
                    ),
                  );
                }
              },
              child: Text(isEditing ? 'update'.tr() : 'create'.tr()),
            ),
          ],
        ),
      ),
    );
  }

  RoutineDifficulty _parseDifficulty(String difficultyName) {
    switch (difficultyName) {
      case 'beginner':
        return RoutineDifficulty.beginner;
      case 'intermediate':
        return RoutineDifficulty.intermediate;
      case 'advanced':
        return RoutineDifficulty.advanced;
      default:
        return RoutineDifficulty.beginner;
    }
  }
}
