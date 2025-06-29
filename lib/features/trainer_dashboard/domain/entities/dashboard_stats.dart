class DashboardStats {
  final int totalStudents;
  final int activeStudents;
  final int inactiveStudents;
  final int suspendedStudents;
  final int totalRoutines;
  final int activeRoutines;
  final double monthlyIncome;
  final double totalRevenue;
  final List<RecentStudent> recentStudents;
  final List<TopRoutine> topRoutines;
  final List<MonthlyIncomeItem> incomeBreakdown;
  final List<StudentStatusCount> studentsByStatus;

  const DashboardStats({
    required this.totalStudents,
    required this.activeStudents,
    required this.inactiveStudents,
    required this.suspendedStudents,
    required this.totalRoutines,
    required this.activeRoutines,
    required this.monthlyIncome,
    required this.totalRevenue,
    required this.recentStudents,
    required this.topRoutines,
    required this.incomeBreakdown,
    required this.studentsByStatus,
  });
}

class RecentStudent {
  final String id;
  final String name;
  final String email;
  final String status;
  final DateTime lastActivity;
  final String? photoUrl;
  final double progressPercentage;
  final int remainingClasses;

  const RecentStudent({
    required this.id,
    required this.name,
    required this.email,
    required this.status,
    required this.lastActivity,
    this.photoUrl,
    required this.progressPercentage,
    required this.remainingClasses,
  });
}

class TopRoutine {
  final String id;
  final String name;
  final int assignedStudents;
  final String category;
  final String difficulty;
  final int durationMinutes;
  final double avgRating;

  const TopRoutine({
    required this.id,
    required this.name,
    required this.assignedStudents,
    required this.category,
    required this.difficulty,
    required this.durationMinutes,
    required this.avgRating,
  });
}

class MonthlyIncomeItem {
  final String title;
  final double amount;
  final String category;

  const MonthlyIncomeItem({
    required this.title,
    required this.amount,
    required this.category,
  });
}

class StudentStatusCount {
  final String status;
  final int count;
  final double percentage;

  const StudentStatusCount({
    required this.status,
    required this.count,
    required this.percentage,
  });
}
