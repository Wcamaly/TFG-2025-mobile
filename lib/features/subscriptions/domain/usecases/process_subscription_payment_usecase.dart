import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/database/tables/students_table.dart' as db_tables;
import '../../../../core/database/tables/payments_table.dart';
import '../../../../core/utils/debug_utils.dart';
import '../../../trainer_students/domain/usecases/associate_student_with_trainer_usecase.dart';
import '../../../trainer_students/domain/repositories/students_repository.dart';
import '../../../trainer_students/domain/entities/student.dart';
import '../../../trainers/domain/entities/trainer.dart';

class ProcessSubscriptionPaymentUseCase
    implements UseCase<SubscriptionResult, ProcessSubscriptionParams> {
  final StudentsRepository studentsRepository;

  ProcessSubscriptionPaymentUseCase(this.studentsRepository);

  @override
  Future<Either<Failure, SubscriptionResult>> call(
      ProcessSubscriptionParams params) async {
    try {
      DebugUtils.logPayment('🔄 Starting subscription payment process');
      DebugUtils.logPayment('   User ID: ${params.userId}');
      DebugUtils.logPayment('   Trainer ID: ${params.trainerId}');
      DebugUtils.logPayment(
          '   Package: ${params.package.name} - \$${params.package.price}');

      // 1. Calcular fechas de suscripción
      final startDate = DateTime.now();
      final endDate =
          _calculateEndDate(startDate, params.package.durationInDays);

      DebugUtils.logPayment(
          '   Subscription period: ${startDate.toString().split(' ')[0]} to ${endDate.toString().split(' ')[0]}');

      // 2. Determinar tipo de suscripción basado en el paquete
      final subscriptionType = _mapPackageToSubscriptionType(params.package);
      DebugUtils.logPayment('   Subscription type: $subscriptionType');

      // 3. Crear asociación estudiante-entrenador
      final associationParams = AssociateStudentParams(
        userId: params.userId,
        trainerId: params.trainerId,
        subscriptionType: subscriptionType,
        monthlyFee: params.package.price,
        totalClasses: _calculateTotalClasses(params.package),
        subscriptionStartDate: startDate,
        subscriptionEndDate: endDate,
        notes: 'Subscription created via payment for ${params.package.name}',
      );

      DebugUtils.logStudentAssociation(
          '🔗 Creating student-trainer association');
      final result =
          await studentsRepository.createStudentAssociation(associationParams);

      return result.fold(
        (failure) {
          DebugUtils.logError(
              '❌ Failed to create student association: ${failure.message}');
          return Left(failure);
        },
        (student) {
          final transactionId = _generateTransactionId();
          DebugUtils.logPayment('✅ Payment processed successfully');
          DebugUtils.logPayment('   Transaction ID: $transactionId');
          DebugUtils.logStudentAssociation(
              '✅ Student-trainer association created');

          return Right(SubscriptionResult(
            student: student,
            transactionId: transactionId,
            subscriptionStartDate: startDate,
            subscriptionEndDate: endDate,
          ));
        },
      );
    } catch (e) {
      DebugUtils.logError('❌ Error processing subscription payment: $e');
      return Left(
          ServerFailure(message: 'Error processing subscription payment: $e'));
    }
  }

  DateTime _calculateEndDate(DateTime startDate, int durationInDays) {
    return startDate.add(Duration(days: durationInDays));
  }

  int _calculateTotalClasses(TrainerPackage package) {
    // Calcular clases basado en la duración y tipo de paquete
    // Asumimos 2-3 clases por semana dependiendo del precio
    final weeks = (package.durationInDays / 7).round();
    final classesPerWeek =
        package.price >= 100 ? 3 : (package.price >= 50 ? 2 : 1);
    final totalClasses = weeks * classesPerWeek;

    DebugUtils.logPayment(
        '   Calculated classes: $totalClasses ($classesPerWeek per week for $weeks weeks)');
    return totalClasses;
  }

  SubscriptionType _mapPackageToSubscriptionType(TrainerPackage package) {
    // Mapear basado en el precio o nombre del paquete
    if (package.price >= 100) {
      return SubscriptionType.vip;
    } else if (package.price >= 50) {
      return SubscriptionType.premium;
    } else {
      return SubscriptionType.basic;
    }
  }

  String _generateTransactionId() {
    return 'TXN_${DateTime.now().millisecondsSinceEpoch}';
  }
}

class ProcessSubscriptionParams {
  final int userId;
  final int trainerId;
  final TrainerPackage package;
  final String paymentMethod;
  final Map<String, String> paymentDetails;

  ProcessSubscriptionParams({
    required this.userId,
    required this.trainerId,
    required this.package,
    required this.paymentMethod,
    required this.paymentDetails,
  });
}

class SubscriptionResult {
  final dynamic student; // Using dynamic to avoid import issues
  final String transactionId;
  final DateTime subscriptionStartDate;
  final DateTime subscriptionEndDate;

  SubscriptionResult({
    required this.student,
    required this.transactionId,
    required this.subscriptionStartDate,
    required this.subscriptionEndDate,
  });
}
