enum StudentStatus {
  active,
  inactive,
  suspended;

  String get displayName {
    switch (this) {
      case StudentStatus.active:
        return 'Activo';
      case StudentStatus.inactive:
        return 'Inactivo';
      case StudentStatus.suspended:
        return 'Suspendido';
    }
  }
}

enum SubscriptionType {
  basic,
  premium,
  vip;

  String get displayName {
    switch (this) {
      case SubscriptionType.basic:
        return 'Básico';
      case SubscriptionType.premium:
        return 'Premium';
      case SubscriptionType.vip:
        return 'VIP';
    }
  }
}

class Student {
  final String id;
  final String userId;
  final String trainerId;
  final String name;
  final String email;
  final String? photoUrl;
  final StudentStatus status;
  final SubscriptionType subscriptionType;
  final DateTime subscriptionStartDate;
  final DateTime subscriptionEndDate;
  final int remainingClasses;
  final int totalClasses;
  final double monthlyFee;
  final DateTime? lastPaymentDate;
  final DateTime nextPaymentDate;
  final double progressPercentage;
  final String? notes;
  final List<StudentRoutine> assignedRoutines;
  final List<Payment> payments;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Student({
    required this.id,
    required this.userId,
    required this.trainerId,
    required this.name,
    required this.email,
    this.photoUrl,
    required this.status,
    required this.subscriptionType,
    required this.subscriptionStartDate,
    required this.subscriptionEndDate,
    required this.remainingClasses,
    required this.totalClasses,
    required this.monthlyFee,
    this.lastPaymentDate,
    required this.nextPaymentDate,
    required this.progressPercentage,
    this.notes,
    this.assignedRoutines = const [],
    this.payments = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  bool get isActive => status == StudentStatus.active;

  String get statusDisplayName => status.displayName;

  String get subscriptionDisplayName => subscriptionType.displayName;

  int get completedClasses => totalClasses - remainingClasses;

  double get classCompletionPercentage =>
      totalClasses > 0 ? (completedClasses / totalClasses) * 100 : 0.0;

  Student copyWith({
    String? id,
    String? userId,
    String? trainerId,
    String? name,
    String? email,
    String? photoUrl,
    StudentStatus? status,
    SubscriptionType? subscriptionType,
    DateTime? subscriptionStartDate,
    DateTime? subscriptionEndDate,
    int? remainingClasses,
    int? totalClasses,
    double? monthlyFee,
    DateTime? lastPaymentDate,
    DateTime? nextPaymentDate,
    double? progressPercentage,
    String? notes,
    List<StudentRoutine>? assignedRoutines,
    List<Payment>? payments,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Student(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      trainerId: trainerId ?? this.trainerId,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      status: status ?? this.status,
      subscriptionType: subscriptionType ?? this.subscriptionType,
      subscriptionStartDate:
          subscriptionStartDate ?? this.subscriptionStartDate,
      subscriptionEndDate: subscriptionEndDate ?? this.subscriptionEndDate,
      remainingClasses: remainingClasses ?? this.remainingClasses,
      totalClasses: totalClasses ?? this.totalClasses,
      monthlyFee: monthlyFee ?? this.monthlyFee,
      lastPaymentDate: lastPaymentDate ?? this.lastPaymentDate,
      nextPaymentDate: nextPaymentDate ?? this.nextPaymentDate,
      progressPercentage: progressPercentage ?? this.progressPercentage,
      notes: notes ?? this.notes,
      assignedRoutines: assignedRoutines ?? this.assignedRoutines,
      payments: payments ?? this.payments,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class StudentRoutine {
  final String id;
  final String studentId;
  final String routineId;
  final String routineName;
  final String trainerId;
  final DateTime assignedDate;
  final DateTime? startDate;
  final DateTime? completedDate;
  final String status;
  final double progressPercentage;
  final int completedSessions;
  final int totalSessions;
  final String? notes;
  final DateTime createdAt;

  const StudentRoutine({
    required this.id,
    required this.studentId,
    required this.routineId,
    required this.routineName,
    required this.trainerId,
    required this.assignedDate,
    this.startDate,
    this.completedDate,
    required this.status,
    required this.progressPercentage,
    required this.completedSessions,
    required this.totalSessions,
    this.notes,
    required this.createdAt,
  });

  bool get isCompleted => status == 'completed';
  bool get isActive => status == 'active';
}

class Payment {
  final String id;
  final String studentId;
  final String trainerId;
  final double amount;
  final String status;
  final String paymentMethod;
  final String description;
  final DateTime paymentDate;
  final DateTime dueDate;
  final String? transactionId;
  final String? notes;
  final DateTime createdAt;

  const Payment({
    required this.id,
    required this.studentId,
    required this.trainerId,
    required this.amount,
    required this.status,
    required this.paymentMethod,
    required this.description,
    required this.paymentDate,
    required this.dueDate,
    this.transactionId,
    this.notes,
    required this.createdAt,
  });

  bool get isPending => status == 'pending';
  bool get isCompleted => status == 'completed';
  bool get isFailed => status == 'failed';
}
