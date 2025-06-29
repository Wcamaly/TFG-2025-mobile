import 'package:dartz/dartz.dart';
import '../../domain/entities/student.dart';
import '../../domain/repositories/students_repository.dart';
import '../../domain/usecases/associate_student_with_trainer_usecase.dart';
import '../datasources/students_local_data_source.dart';
import '../../../trainer_dashboard/domain/entities/student.dart' as dashboard;
import '../../../../core/database/tables/students_table.dart' as db_tables;
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';

class StudentsRepositoryImpl implements StudentsRepository {
  final StudentsLocalDataSource localDataSource;

  StudentsRepositoryImpl(this.localDataSource);

  @override
  Future<List<Student>> getStudentsByTrainer(int trainerId) async {
    final studentsWithUsers =
        await localDataSource.getStudentsByTrainer(trainerId);
    return studentsWithUsers.map(_mapToEntity).toList();
  }

  @override
  Future<List<Student>> searchStudents(int trainerId, String query) async {
    final studentsWithUsers =
        await localDataSource.searchStudents(trainerId, query);
    return studentsWithUsers.map(_mapToEntity).toList();
  }

  @override
  Future<List<Student>> filterStudents(
      int trainerId, StudentStatus? status) async {
    final dbStatus = status != null ? _mapStatusToDb(status) : null;
    final studentsWithUsers =
        await localDataSource.filterStudents(trainerId, dbStatus);
    return studentsWithUsers.map(_mapToEntity).toList();
  }

  @override
  Future<Student?> getStudentById(int studentId) async {
    final studentWithUser = await localDataSource.getStudentById(studentId);
    return studentWithUser != null ? _mapToEntity(studentWithUser) : null;
  }

  @override
  Future<void> updateStudentStatus(int studentId, StudentStatus status) async {
    final dbStatus = _mapStatusToDb(status);
    await localDataSource.updateStudentStatus(studentId, dbStatus);
  }

  @override
  Future<void> assignStudentToTrainer(int studentId, int trainerId) async {
    await localDataSource.assignStudentToTrainer(studentId, trainerId);
  }

  @override
  Future<void> removeStudentFromTrainer(int studentId) async {
    await localDataSource.removeStudentFromTrainer(studentId);
  }

  @override
  Future<void> updateStudentNotes(int studentId, String notes) async {
    await localDataSource.updateStudentNotes(studentId, notes);
  }

  @override
  Future<Either<Failure, Student>> createStudentAssociation(
      AssociateStudentParams params) async {
    try {
      final studentId = await localDataSource.createStudentAssociation(
        userId: params.userId,
        trainerId: params.trainerId,
        subscriptionType: _mapSubscriptionTypeToDb(params.subscriptionType),
        monthlyFee: params.monthlyFee,
        totalClasses: params.totalClasses,
        subscriptionStartDate: params.subscriptionStartDate,
        subscriptionEndDate: params.subscriptionEndDate,
        notes: params.notes,
      );

      final studentWithUser = await localDataSource.getStudentById(studentId);
      if (studentWithUser == null) {
        return Left(
            ServerFailure(message: 'Error creating student association'));
      }

      return Right(_mapToEntity(studentWithUser));
    } on ServerException catch (e) {
      return Left(ServerFailure(
          message: e.message ?? 'Error creating student association'));
    } catch (e) {
      return Left(ServerFailure(
          message: 'Unexpected error creating student association'));
    }
  }

  dashboard.Student _mapToEntity(StudentWithUser studentWithUser) {
    final dbStudent = studentWithUser.student;
    final dbUser = studentWithUser.user;

    return dashboard.Student(
      id: dbStudent.id.toString(),
      userId: dbUser.id.toString(),
      trainerId: dbStudent.trainerId.toString(),
      name: '${dbUser.firstName} ${dbUser.lastName}',
      email: dbUser.email,
      photoUrl: 'https://i.pravatar.cc/150?img=${dbUser.id}',
      status: _mapStatus(dbStudent.status),
      subscriptionType: _mapSubscriptionType(dbStudent.subscriptionType),
      subscriptionStartDate: dbStudent.subscriptionStartDate,
      subscriptionEndDate: dbStudent.subscriptionEndDate,
      remainingClasses: dbStudent.remainingClasses,
      totalClasses: dbStudent.totalClasses,
      monthlyFee: dbStudent.monthlyFee,
      lastPaymentDate: dbStudent.lastPaymentDate,
      nextPaymentDate: dbStudent.nextPaymentDate,
      progressPercentage: dbStudent.progressPercentage,
      notes: dbStudent.notes,
      assignedRoutines: [], // TODO: Implementar carga de rutinas asignadas
      payments: [], // TODO: Implementar carga de pagos
      createdAt: dbStudent.createdAt,
      updatedAt: dbStudent.updatedAt,
    );
  }

  dashboard.StudentStatus _mapStatus(db_tables.StudentStatus dbStatus) {
    switch (dbStatus) {
      case db_tables.StudentStatus.active:
        return dashboard.StudentStatus.active;
      case db_tables.StudentStatus.inactive:
        return dashboard.StudentStatus.inactive;
      case db_tables.StudentStatus.suspended:
        return dashboard.StudentStatus.suspended;
    }
  }

  dashboard.SubscriptionType _mapSubscriptionType(
      db_tables.SubscriptionType dbType) {
    switch (dbType) {
      case db_tables.SubscriptionType.basic:
        return dashboard.SubscriptionType.basic;
      case db_tables.SubscriptionType.premium:
        return dashboard.SubscriptionType.premium;
      case db_tables.SubscriptionType.vip:
        return dashboard.SubscriptionType.vip;
    }
  }

  db_tables.StudentStatus _mapStatusToDb(StudentStatus domainStatus) {
    switch (domainStatus) {
      case StudentStatus.active:
        return db_tables.StudentStatus.active;
      case StudentStatus.inactive:
        return db_tables.StudentStatus.inactive;
      case StudentStatus.suspended:
        return db_tables.StudentStatus.suspended;
    }
  }

  db_tables.SubscriptionType _mapSubscriptionTypeToDb(
      SubscriptionType domainType) {
    switch (domainType) {
      case SubscriptionType.basic:
        return db_tables.SubscriptionType.basic;
      case SubscriptionType.premium:
        return db_tables.SubscriptionType.premium;
      case SubscriptionType.vip:
        return db_tables.SubscriptionType.vip;
    }
  }
}
