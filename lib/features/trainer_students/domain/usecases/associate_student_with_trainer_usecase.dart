import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/database/tables/students_table.dart' as db_tables;
import '../entities/student.dart';
import '../repositories/students_repository.dart';

class AssociateStudentWithTrainerUseCase
    implements UseCase<Student, AssociateStudentParams> {
  final StudentsRepository repository;

  AssociateStudentWithTrainerUseCase(this.repository);

  @override
  Future<Either<Failure, Student>> call(AssociateStudentParams params) async {
    return await repository.createStudentAssociation(params);
  }
}

class AssociateStudentParams {
  final int userId;
  final int trainerId;
  final SubscriptionType subscriptionType;
  final double monthlyFee;
  final int totalClasses;
  final DateTime subscriptionStartDate;
  final DateTime subscriptionEndDate;
  final String? notes;

  AssociateStudentParams({
    required this.userId,
    required this.trainerId,
    required this.subscriptionType,
    required this.monthlyFee,
    required this.totalClasses,
    required this.subscriptionStartDate,
    required this.subscriptionEndDate,
    this.notes,
  });
}
