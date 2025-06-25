enum SubscriptionStatus {
  active,
  expired,
  cancelled,
  pending,
}

class Subscription {
  final String id;
  final String userId;
  final String trainerId;
  final String trainerName;
  final String packageId;
  final String packageName;
  final double amount;
  final DateTime startDate;
  final DateTime endDate;
  final SubscriptionStatus status;
  final String? cardLastFour;
  final DateTime createdAt;
  final DateTime? cancelledAt;

  const Subscription({
    required this.id,
    required this.userId,
    required this.trainerId,
    required this.trainerName,
    required this.packageId,
    required this.packageName,
    required this.amount,
    required this.startDate,
    required this.endDate,
    required this.status,
    this.cardLastFour,
    required this.createdAt,
    this.cancelledAt,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      id: json['id'] as String,
      userId: json['userId'] as String,
      trainerId: json['trainerId'] as String,
      trainerName: json['trainerName'] as String,
      packageId: json['packageId'] as String,
      packageName: json['packageName'] as String,
      amount: (json['amount'] as num).toDouble(),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      status: SubscriptionStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => SubscriptionStatus.pending,
      ),
      cardLastFour: json['cardLastFour'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      cancelledAt: json['cancelledAt'] != null
          ? DateTime.parse(json['cancelledAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'trainerId': trainerId,
      'trainerName': trainerName,
      'packageId': packageId,
      'packageName': packageName,
      'amount': amount,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'status': status.name,
      'cardLastFour': cardLastFour,
      'createdAt': createdAt.toIso8601String(),
      'cancelledAt': cancelledAt?.toIso8601String(),
    };
  }

  bool get isActive =>
      status == SubscriptionStatus.active && DateTime.now().isBefore(endDate);

  int get daysRemaining {
    if (!isActive) return 0;
    return endDate.difference(DateTime.now()).inDays;
  }
}
