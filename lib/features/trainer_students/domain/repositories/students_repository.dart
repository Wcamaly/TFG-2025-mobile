import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/student.dart';
import '../usecases/associate_student_with_trainer_usecase.dart';

abstract class StudentsRepository {
  Future<List<Student>> getStudentsByTrainer(int trainerId);
  Future<List<Student>> searchStudents(int trainerId, String query);
  Future<List<Student>> filterStudents(int trainerId, StudentStatus? status);
  Future<Student?> getStudentById(int studentId);
  Future<void> updateStudentStatus(int studentId, StudentStatus status);
  Future<void> assignStudentToTrainer(int studentId, int trainerId);
  Future<void> removeStudentFromTrainer(int studentId);
  Future<void> updateStudentNotes(int studentId, String notes);
  Future<Either<Failure, Student>> createStudentAssociation(
      AssociateStudentParams params);
}
