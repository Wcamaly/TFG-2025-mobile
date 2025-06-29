enum RoutineStatus {
  active,
  completed,
  paused,
  cancelled;

  String get displayName {
    switch (this) {
      case RoutineStatus.active:
        return 'Activa';
      case RoutineStatus.completed:
        return 'Completada';
      case RoutineStatus.paused:
        return 'Pausada';
      case RoutineStatus.cancelled:
        return 'Cancelada';
    }
  }
}

enum DifficultyLevel {
  beginner,
  intermediate,
  advanced;

  String get displayName {
    switch (this) {
      case DifficultyLevel.beginner:
        return 'Principiante';
      case DifficultyLevel.intermediate:
        return 'Intermedio';
      case DifficultyLevel.advanced:
        return 'Avanzado';
    }
  }
}

class Routine {
  final String id;
  final String name;
  final String description;
  final String category;
  final int durationMinutes;
  final DifficultyLevel difficulty;
  final int exerciseCount;
  final String createdBy;
  final RoutineStatus status;
  final List<Exercise> exercises;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Routine({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.durationMinutes,
    required this.difficulty,
    required this.exerciseCount,
    required this.createdBy,
    required this.status,
    required this.exercises,
    required this.createdAt,
    required this.updatedAt,
  });

  bool get isActive => status == RoutineStatus.active;
  bool get isDraft => status == RoutineStatus.paused;

  String get difficultyDisplayName => difficulty.displayName;
  String get statusDisplayName => status.displayName;

  String get durationDisplay {
    if (durationMinutes < 60) {
      return '${durationMinutes} min';
    } else {
      final hours = durationMinutes ~/ 60;
      final minutes = durationMinutes % 60;
      if (minutes == 0) {
        return '${hours}h';
      } else {
        return '${hours}h ${minutes}min';
      }
    }
  }

  Routine copyWith({
    String? id,
    String? name,
    String? description,
    String? category,
    int? durationMinutes,
    DifficultyLevel? difficulty,
    int? exerciseCount,
    String? createdBy,
    RoutineStatus? status,
    List<Exercise>? exercises,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Routine(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      difficulty: difficulty ?? this.difficulty,
      exerciseCount: exerciseCount ?? this.exerciseCount,
      createdBy: createdBy ?? this.createdBy,
      status: status ?? this.status,
      exercises: exercises ?? this.exercises,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class Exercise {
  final String name;
  final int? sets;
  final int? reps;
  final int? duration;
  final String? notes;

  const Exercise({
    required this.name,
    this.sets,
    this.reps,
    this.duration,
    this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      if (sets != null) 'sets': sets,
      if (reps != null) 'reps': reps,
      if (duration != null) 'duration': duration,
      if (notes != null) 'notes': notes,
    };
  }

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      name: json['name'] as String,
      sets: json['sets'] as int?,
      reps: json['reps'] as int?,
      duration: json['duration'] as int?,
      notes: json['notes'] as String?,
    );
  }
}
