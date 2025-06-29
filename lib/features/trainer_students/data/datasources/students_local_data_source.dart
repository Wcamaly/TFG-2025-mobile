import '../../../../core/database/app_database.dart';
import '../../../../core/database/tables/students_table.dart';
import '../../../../core/database/tables/users_table.dart';
import 'package:drift/drift.dart';

abstract class StudentsLocalDataSource {
  Future<List<StudentWithUser>> getStudentsByTrainer(int trainerId);
  Future<List<StudentWithUser>> searchStudents(int trainerId, String query);
  Future<List<StudentWithUser>> filterStudents(
      int trainerId, StudentStatus? status);
  Future<StudentWithUser?> getStudentById(int studentId);
  Future<void> updateStudentStatus(int studentId, StudentStatus status);
  Future<void> assignStudentToTrainer(int studentId, int trainerId);
  Future<void> removeStudentFromTrainer(int studentId);
  Future<void> updateStudentNotes(int studentId, String notes);
  Future<int> createStudentAssociation({
    required int userId,
    required int trainerId,
    required SubscriptionType subscriptionType,
    required double monthlyFee,
    required int totalClasses,
    required DateTime subscriptionStartDate,
    required DateTime subscriptionEndDate,
    String? notes,
  });
}

class StudentWithUser {
  final DbStudent student;
  final DbUser user;

  StudentWithUser({required this.student, required this.user});
}

class StudentsLocalDataSourceImpl implements StudentsLocalDataSource {
  final AppDatabase database;

  StudentsLocalDataSourceImpl(this.database);

  @override
  Future<List<StudentWithUser>> getStudentsByTrainer(int trainerId) async {
    final query = database.select(database.students).join([
      innerJoin(
          database.users, database.users.id.equalsExp(database.students.userId))
    ])
      ..where(database.students.trainerId.equals(trainerId));

    final results = await query.get();

    return results.map((row) {
      final student = row.readTable(database.students);
      final user = row.readTable(database.users);
      return StudentWithUser(student: student, user: user);
    }).toList();
  }

  @override
  Future<List<StudentWithUser>> searchStudents(
      int trainerId, String query) async {
    final searchQuery = database.select(database.students).join([
      innerJoin(
          database.users, database.users.id.equalsExp(database.students.userId))
    ])
      ..where(database.students.trainerId.equals(trainerId) &
          (database.users.firstName.like('%$query%') |
              database.users.lastName.like('%$query%') |
              database.users.email.like('%$query%')));

    final results = await searchQuery.get();

    return results.map((row) {
      final student = row.readTable(database.students);
      final user = row.readTable(database.users);
      return StudentWithUser(student: student, user: user);
    }).toList();
  }

  @override
  Future<List<StudentWithUser>> filterStudents(
      int trainerId, StudentStatus? status) async {
    final filterQuery = database.select(database.students).join([
      innerJoin(
          database.users, database.users.id.equalsExp(database.students.userId))
    ]);

    if (status != null) {
      filterQuery.where(database.students.trainerId.equals(trainerId) &
          database.students.status.equalsValue(status));
    } else {
      filterQuery.where(database.students.trainerId.equals(trainerId));
    }

    final results = await filterQuery.get();

    return results.map((row) {
      final student = row.readTable(database.students);
      final user = row.readTable(database.users);
      return StudentWithUser(student: student, user: user);
    }).toList();
  }

  @override
  Future<StudentWithUser?> getStudentById(int studentId) async {
    final query = database.select(database.students).join([
      innerJoin(
          database.users, database.users.id.equalsExp(database.students.userId))
    ])
      ..where(database.students.id.equals(studentId));

    final result = await query.getSingleOrNull();

    if (result == null) return null;

    final student = result.readTable(database.students);
    final user = result.readTable(database.users);
    return StudentWithUser(student: student, user: user);
  }

  @override
  Future<void> updateStudentStatus(int studentId, StudentStatus status) async {
    await (database.update(database.students)
          ..where((s) => s.id.equals(studentId)))
        .write(StudentsCompanion(
      status: Value(status),
      updatedAt: Value(DateTime.now()),
    ));
  }

  @override
  Future<void> assignStudentToTrainer(int studentId, int trainerId) async {
    await (database.update(database.students)
          ..where((s) => s.id.equals(studentId)))
        .write(StudentsCompanion(
      trainerId: Value(trainerId),
      updatedAt: Value(DateTime.now()),
    ));
  }

  @override
  Future<void> removeStudentFromTrainer(int studentId) async {
    await (database.delete(database.students)
          ..where((s) => s.id.equals(studentId)))
        .go();
  }

  @override
  Future<void> updateStudentNotes(int studentId, String notes) async {
    await (database.update(database.students)
          ..where((s) => s.id.equals(studentId)))
        .write(StudentsCompanion(
      notes: Value(notes.isEmpty ? null : notes),
      updatedAt: Value(DateTime.now()),
    ));
  }

  @override
  Future<int> createStudentAssociation({
    required int userId,
    required int trainerId,
    required SubscriptionType subscriptionType,
    required double monthlyFee,
    required int totalClasses,
    required DateTime subscriptionStartDate,
    required DateTime subscriptionEndDate,
    String? notes,
  }) async {
    final companion = StudentsCompanion.insert(
      userId: userId,
      trainerId: trainerId,
      status: StudentStatus.active,
      subscriptionType: subscriptionType,
      subscriptionStartDate: subscriptionStartDate,
      subscriptionEndDate: subscriptionEndDate,
      remainingClasses: Value(totalClasses),
      totalClasses: Value(totalClasses),
      monthlyFee: monthlyFee,
      nextPaymentDate: subscriptionStartDate.add(const Duration(days: 30)),
      notes: Value(notes),
    );

    return await database.students.insertOne(companion);
  }
}
