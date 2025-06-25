import '../../domain/entities/trainer.dart';
import 'trainer_remote_data_source.dart';

class TrainerRemoteDataSourceMock implements TrainerRemoteDataSource {
  final List<Trainer> _mockTrainers = [
    Trainer(
      id: '1',
      name: 'Juan M.',
      profileImageUrl: 'https://example.com/juan.jpg',
      specialization: 'Functional Training & Weight Loss Expert',
      yearsOfExperience: 12,
      rating: 4.5,
      reviewCount: 127,
      certifications: ['Certified by NASM', 'Functional'],
      languages: ['EN', 'ES'],
      location: 'Malasaña, Madrid',
      latitude: 40.4255, // Malasaña, Madrid
      longitude: -3.7025,
      isAvailable: true,
      description:
          'I am a personal trainer with over 12 years of experience, specializing in functional training and weight loss. I help my clients achieve their health goals through personalized programs that improve strength, endurance, and performance in daily activities.',
      packages: [
        TrainerPackage(
          id: 'pack1_1',
          name: 'Pack 1',
          description:
              'Introducing our comprehensive wellness package designed to help you achieve your health goals! This exclusive pack includes a personalized one-month meal plan tailored to your preferences and nutritional needs.',
          price: 10.0,
          durationInDays: 30,
          features: [
            'Personalized meal plan',
            'Nutritional guidance',
            'Weekly check-ins',
            'Email support'
          ],
        ),
        TrainerPackage(
          id: 'pack1_2',
          name: 'Pack 2',
          description:
              'Advanced training package with personal sessions and nutrition plan.',
          price: 25.0,
          durationInDays: 30,
          features: [
            'Personal training sessions',
            'Custom meal plan',
            'Progress tracking',
            '24/7 support'
          ],
          isPopular: true,
        ),
        TrainerPackage(
          id: 'pack1_3',
          name: 'Pack 3',
          description:
              'Premium package with unlimited access and personal coaching.',
          price: 50.0,
          durationInDays: 30,
          features: [
            'Unlimited sessions',
            'Personal coach',
            'Nutrition specialist',
            'Custom supplements',
            'Progress analysis'
          ],
        ),
      ],
    ),
    Trainer(
      id: '2',
      name: 'Camila R.',
      profileImageUrl: 'https://example.com/camila.jpg',
      specialization: 'Functional Training & Weight Loss Expert',
      yearsOfExperience: 12,
      rating: 4.8,
      reviewCount: 203,
      certifications: ['Certified by NASM', 'Functional'],
      languages: ['EN'],
      location: 'Retiro, Madrid',
      latitude: 40.4152, // Retiro, Madrid
      longitude: -3.6844,
      isAvailable: true,
      description:
          'I am a personal trainer with over 12 years of experience, specializing in functional training and weight loss. I help my clients achieve their health goals through personalized programs that improve strength, endurance, and performance in daily activities.',
      packages: [
        TrainerPackage(
          id: 'pack2_1',
          name: 'Basic Plan',
          description: 'Start your fitness journey with our basic plan.',
          price: 15.0,
          durationInDays: 30,
          features: [
            'Basic workout plan',
            'Nutrition tips',
            'Monthly check-in'
          ],
        ),
        TrainerPackage(
          id: 'pack2_2',
          name: 'Premium Plan',
          description:
              'Get the most out of your training with our premium plan.',
          price: 35.0,
          durationInDays: 30,
          features: [
            'Personal training',
            'Custom nutrition plan',
            'Weekly sessions',
            'Progress tracking'
          ],
          isPopular: true,
        ),
      ],
    ),
    Trainer(
      id: '3',
      name: 'Carlos D.',
      profileImageUrl: 'https://example.com/carlos.jpg',
      specialization: 'Strength Training & Bodybuilding',
      yearsOfExperience: 8,
      rating: 4.7,
      reviewCount: 89,
      certifications: ['ACSM Certified', 'Strength & Conditioning'],
      languages: ['ES', 'EN'],
      location: 'Chamberí, Madrid',
      latitude: 40.4378, // Chamberí, Madrid
      longitude: -3.7036,
      isAvailable: true,
      description:
          'Specialized in strength training and bodybuilding with 8 years of experience. I focus on helping clients build muscle mass and increase their overall strength through scientifically-backed training methods.',
      packages: [
        TrainerPackage(
          id: 'pack3_1',
          name: 'Strength Builder',
          description:
              'Build muscle and increase strength with this focused program.',
          price: 20.0,
          durationInDays: 30,
          features: [
            'Strength training program',
            'Muscle building nutrition',
            'Progress measurements',
            'Form correction'
          ],
        ),
        TrainerPackage(
          id: 'pack3_2',
          name: 'Bodybuilding Pro',
          description: 'Advanced bodybuilding program for serious athletes.',
          price: 40.0,
          durationInDays: 30,
          features: [
            'Competition prep',
            'Advanced techniques',
            'Supplement guidance',
            'Posing practice',
            'Diet periodization'
          ],
          isPopular: true,
        ),
      ],
    ),
    Trainer(
      id: '4',
      name: 'Ana L.',
      profileImageUrl: 'https://example.com/ana.jpg',
      specialization: 'Yoga & Pilates Instructor',
      yearsOfExperience: 6,
      rating: 4.9,
      reviewCount: 156,
      certifications: ['RYT-500', 'Pilates Certified'],
      languages: ['ES', 'EN', 'FR'],
      location: 'Salamanca, Madrid',
      latitude: 40.4312, // Salamanca, Madrid
      longitude: -3.6838,
      isAvailable: true,
      description:
          'Certified yoga and pilates instructor with 6 years of experience. I specialize in mindful movement, flexibility, and core strength to help you achieve balance in body and mind.',
      packages: [
        TrainerPackage(
          id: 'pack4_1',
          name: 'Mindful Movement',
          description: 'Introduction to yoga and pilates for beginners.',
          price: 12.0,
          durationInDays: 30,
          features: [
            'Basic yoga poses',
            'Breathing exercises',
            'Flexibility training',
            'Relaxation techniques'
          ],
        ),
        TrainerPackage(
          id: 'pack4_2',
          name: 'Advanced Flow',
          description:
              'Advanced yoga and pilates for experienced practitioners.',
          price: 30.0,
          durationInDays: 30,
          features: [
            'Advanced poses',
            'Core strengthening',
            'Meditation sessions',
            'Injury prevention',
            'Personal adjustments'
          ],
          isPopular: true,
        ),
      ],
    ),
  ];

  @override
  Future<List<Trainer>> getNearbyTrainers({
    required double latitude,
    required double longitude,
    double radiusKm = 10.0,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockTrainers;
  }

  @override
  Future<List<Trainer>> searchTrainers(String query) async {
    await Future.delayed(const Duration(milliseconds: 300));

    if (query.isEmpty) {
      return _mockTrainers;
    }

    return _mockTrainers
        .where((trainer) =>
            trainer.name.toLowerCase().contains(query.toLowerCase()) ||
            trainer.specialization
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            trainer.location.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  Future<List<Trainer>> getTrainersByLocation(
    double latitude,
    double longitude,
    double radiusKm,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockTrainers;
  }

  @override
  Future<Trainer> getTrainerById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockTrainers.firstWhere(
      (trainer) => trainer.id == id,
      orElse: () => _mockTrainers.first,
    );
  }

  @override
  Future<List<Trainer>> getRecommendedTrainers() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _mockTrainers.take(3).toList();
  }
}
