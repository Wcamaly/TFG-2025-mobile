enum RoutineStatus {
  active,
  paused,
  completed,
}

enum RoutineDifficulty {
  beginner,
  intermediate,
  advanced,
}

class Routine {
  final int id;
  final String name;
  final String description;
  final String category;
  final int duration; // en minutos
  final RoutineDifficulty difficulty;
  final RoutineStatus status;
  final int createdBy; // ID del entrenador
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Exercise> exercises;
  final int assignedStudents;
  final double avgRating;

  const Routine({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.duration,
    required this.difficulty,
    required this.status,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.exercises = const [],
    this.assignedStudents = 0,
    this.avgRating = 0.0,
  });

  String get difficultyDisplayName {
    switch (difficulty) {
      case RoutineDifficulty.beginner:
        return 'Principiante';
      case RoutineDifficulty.intermediate:
        return 'Intermedio';
      case RoutineDifficulty.advanced:
        return 'Avanzado';
    }
  }

  String get statusDisplayName {
    switch (status) {
      case RoutineStatus.active:
        return 'Activa';
      case RoutineStatus.paused:
        return 'Pausada';
      case RoutineStatus.completed:
        return 'Completada';
    }
  }

  Routine copyWith({
    int? id,
    String? name,
    String? description,
    String? category,
    int? duration,
    RoutineDifficulty? difficulty,
    RoutineStatus? status,
    int? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<Exercise>? exercises,
    int? assignedStudents,
    double? avgRating,
  }) {
    return Routine(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      duration: duration ?? this.duration,
      difficulty: difficulty ?? this.difficulty,
      status: status ?? this.status,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      exercises: exercises ?? this.exercises,
      assignedStudents: assignedStudents ?? this.assignedStudents,
      avgRating: avgRating ?? this.avgRating,
    );
  }
}

class Exercise {
  final int id;
  final String name;
  final String description;
  final int sets;
  final int reps;
  final int restTime; // en segundos
  final double? weight; // peso en kg
  final int? percentage; // porcentaje de 1RM
  final int? duration; // duración en segundos (para ejercicios por tiempo)
  final String? notes; // notas adicionales
  final String? imageUrl;
  final String? videoUrl;

  const Exercise({
    required this.id,
    required this.name,
    required this.description,
    required this.sets,
    required this.reps,
    required this.restTime,
    this.weight,
    this.percentage,
    this.duration,
    this.notes,
    this.imageUrl,
    this.videoUrl,
  });

  Exercise copyWith({
    int? id,
    String? name,
    String? description,
    int? sets,
    int? reps,
    int? restTime,
    double? weight,
    int? percentage,
    int? duration,
    String? notes,
    String? imageUrl,
    String? videoUrl,
  }) {
    return Exercise(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      sets: sets ?? this.sets,
      reps: reps ?? this.reps,
      restTime: restTime ?? this.restTime,
      weight: weight ?? this.weight,
      percentage: percentage ?? this.percentage,
      duration: duration ?? this.duration,
      notes: notes ?? this.notes,
      imageUrl: imageUrl ?? this.imageUrl,
      videoUrl: videoUrl ?? this.videoUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'sets': sets,
      'reps': reps,
      'restTime': restTime,
      if (weight != null) 'weight': weight,
      if (percentage != null) 'percentage': percentage,
      if (duration != null) 'duration': duration,
      if (notes != null) 'notes': notes,
      if (imageUrl != null) 'imageUrl': imageUrl,
      if (videoUrl != null) 'videoUrl': videoUrl,
    };
  }

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      sets: json['sets'] ?? 0,
      reps: json['reps'] ?? 0,
      restTime: json['restTime'] ?? 60,
      weight: json['weight']?.toDouble(),
      percentage: json['percentage'],
      duration: json['duration'],
      notes: json['notes'],
      imageUrl: json['imageUrl'],
      videoUrl: json['videoUrl'],
    );
  }
}
