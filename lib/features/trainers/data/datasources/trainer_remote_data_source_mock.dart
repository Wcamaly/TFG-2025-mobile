import '../../domain/entities/trainer.dart';
import 'trainer_remote_data_source.dart';

class TrainerRemoteDataSourceMock implements TrainerRemoteDataSource {
  final List<Trainer> _mockTrainers = [
    // ========== ENTRENADORES EN SAN FRANCISCO (CERCA DE LA UBICACIÓN ACTUAL) ==========
    const Trainer(
      id: '1',
      name: 'Michael Chen',
      profileImageUrl: 'https://example.com/michael.jpg',
      specialization: 'CrossFit & HIIT Specialist',
      yearsOfExperience: 8,
      rating: 4.8,
      reviewCount: 234,
      certifications: ['CrossFit Level 2', 'NASM CPT'],
      languages: ['EN', 'ZH'],
      location: 'Mission District, San Francisco',
      latitude: 37.7749, // San Francisco centro
      longitude: -122.4194,
      isAvailable: true,
      description:
          'Experienced CrossFit coach specializing in high-intensity workouts and functional fitness. Helping athletes reach their peak performance.',
      packages: [
        TrainerPackage(
          id: 'pack1_1',
          name: 'CrossFit Fundamentals',
          description:
              'Learn the basics of CrossFit with proper form and technique',
          price: 120.0,
          durationInDays: 30,
          features: [
            'Basic movements',
            'Form correction',
            '3x/week sessions',
            'Nutrition guide'
          ],
        ),
        TrainerPackage(
          id: 'pack1_2',
          name: 'Elite Training',
          description: 'Advanced CrossFit programming for competitive athletes',
          price: 250.0,
          durationInDays: 30,
          features: [
            'Competition prep',
            'Advanced techniques',
            'Daily programming',
            '24/7 support'
          ],
          isPopular: true,
        ),
      ],
    ),

    const Trainer(
      id: '2',
      name: 'Sarah Martinez',
      profileImageUrl: 'https://example.com/sarah.jpg',
      specialization: 'Yoga & Mindfulness Coach',
      yearsOfExperience: 12,
      rating: 4.9,
      reviewCount: 189,
      certifications: ['RYT-500', 'Meditation Teacher'],
      languages: ['EN', 'ES'],
      location: 'Castro District, San Francisco',
      latitude: 37.7609,
      longitude: -122.4350,
      isAvailable: true,
      description:
          'Certified yoga instructor with over 12 years of experience. Specializing in Vinyasa flow and mindfulness meditation.',
      packages: [
        TrainerPackage(
          id: 'pack2_1',
          name: 'Beginner Yoga',
          description: 'Perfect introduction to yoga practice',
          price: 80.0,
          durationInDays: 30,
          features: [
            'Basic poses',
            'Breathing techniques',
            'Flexibility focus',
            'Relaxation'
          ],
        ),
        TrainerPackage(
          id: 'pack2_2',
          name: 'Advanced Flow',
          description: 'Challenge yourself with advanced poses and sequences',
          price: 150.0,
          durationInDays: 30,
          features: [
            'Advanced poses',
            'Arm balances',
            'Inversions',
            'Personal adjustments'
          ],
          isPopular: true,
        ),
      ],
    ),

    Trainer(
      id: '3',
      name: 'David Thompson',
      profileImageUrl: 'https://example.com/david.jpg',
      specialization: 'Strength & Powerlifting Coach',
      yearsOfExperience: 15,
      rating: 4.7,
      reviewCount: 312,
      certifications: ['USAPL Coach', 'NSCA CSCS'],
      languages: ['EN'],
      location: 'SOMA, San Francisco',
      latitude: 37.7749,
      longitude: -122.4090,
      isAvailable: true,
      description:
          'Elite powerlifting coach with 15 years of experience. Competed nationally and coached athletes to state records.',
      packages: [
        TrainerPackage(
          id: 'pack3_1',
          name: 'Strength Foundation',
          description: 'Build your base strength with proper technique',
          price: 180.0,
          durationInDays: 30,
          features: [
            'Squat, bench, deadlift',
            'Form analysis',
            'Progressive overload',
            'Mobility work'
          ],
        ),
        TrainerPackage(
          id: 'pack3_2',
          name: 'Powerlifting Mastery',
          description: 'Advanced programming for serious lifters',
          price: 300.0,
          durationInDays: 30,
          features: [
            'Competition prep',
            '1RM testing',
            'Peak programs',
            'Meet day coaching'
          ],
          isPopular: true,
        ),
      ],
    ),

    Trainer(
      id: '4',
      name: 'Lisa Wang',
      profileImageUrl: 'https://example.com/lisa.jpg',
      specialization: 'Functional Training & Rehabilitation',
      yearsOfExperience: 10,
      rating: 4.8,
      reviewCount: 156,
      certifications: ['DPT', 'FMS Level 2'],
      languages: ['EN', 'ZH', 'KO'],
      location: 'Richmond District, San Francisco',
      latitude: 37.7806,
      longitude: -122.4644,
      isAvailable: true,
      description:
          'Physical therapist turned trainer, specializing in injury prevention and functional movement patterns.',
      packages: [
        TrainerPackage(
          id: 'pack4_1',
          name: 'Movement Restoration',
          description: 'Recover from injury and prevent future problems',
          price: 200.0,
          durationInDays: 30,
          features: [
            'Injury assessment',
            'Corrective exercises',
            'Movement screening',
            'Pain reduction'
          ],
        ),
        TrainerPackage(
          id: 'pack4_2',
          name: 'Performance Enhancement',
          description: 'Optimize your movement for peak performance',
          price: 220.0,
          durationInDays: 30,
          features: [
            'Movement optimization',
            'Performance testing',
            'Sport-specific training',
            'Injury prevention'
          ],
        ),
      ],
    ),

    Trainer(
      id: '5',
      name: 'James Rodriguez',
      profileImageUrl: 'https://example.com/james.jpg',
      specialization: 'Boxing & Combat Sports',
      yearsOfExperience: 9,
      rating: 4.6,
      reviewCount: 198,
      certifications: ['USA Boxing Coach', 'Muay Thai Certified'],
      languages: ['EN', 'ES'],
      location: 'Mission Bay, San Francisco',
      latitude: 37.7706,
      longitude: -122.3918,
      isAvailable: true,
      description:
          'Former amateur boxer turned coach. Teaching the sweet science while getting you in the best shape of your life.',
      packages: [
        TrainerPackage(
          id: 'pack5_1',
          name: 'Boxing Basics',
          description: 'Learn fundamental boxing techniques and get fit',
          price: 140.0,
          durationInDays: 30,
          features: [
            'Basic combinations',
            'Footwork',
            'Heavy bag work',
            'Conditioning'
          ],
        ),
        TrainerPackage(
          id: 'pack5_2',
          name: 'Fighter Training',
          description: 'Train like a professional boxer',
          price: 280.0,
          durationInDays: 30,
          features: [
            'Advanced techniques',
            'Sparring prep',
            'Competition training',
            'Mental coaching'
          ],
          isPopular: true,
        ),
      ],
    ),

    // ========== MADRID, ESPAÑA ==========
    Trainer(
      id: '6',
      name: 'Juan M.',
      profileImageUrl: 'https://example.com/juan.jpg',
      specialization: 'Functional Training & Weight Loss Expert',
      yearsOfExperience: 12,
      rating: 4.5,
      reviewCount: 127,
      certifications: ['Certified by NASM', 'Functional'],
      languages: ['EN', 'ES'],
      location: 'Malasaña, Madrid',
      latitude: 40.4255,
      longitude: -3.7025,
      isAvailable: true,
      description:
          'Personal trainer con más de 12 años de experiencia, especializado en entrenamiento funcional y pérdida de peso.',
      packages: [
        TrainerPackage(
          id: 'pack6_1',
          name: 'Transformación 30 días',
          description: 'Plan completo de entrenamiento y nutrición',
          price: 150.0,
          durationInDays: 30,
          features: [
            'Plan de comidas personalizado',
            'Entrenamientos funcionales',
            'Seguimiento semanal',
            'Soporte por email'
          ],
        ),
      ],
    ),

    Trainer(
      id: '7',
      name: 'Camila R.',
      profileImageUrl: 'https://example.com/camila.jpg',
      specialization: 'Pilates & Core Strength',
      yearsOfExperience: 8,
      rating: 4.8,
      reviewCount: 203,
      certifications: ['Pilates Certified', 'Core Performance'],
      languages: ['ES', 'EN'],
      location: 'Retiro, Madrid',
      latitude: 40.4152,
      longitude: -3.6844,
      isAvailable: true,
      description:
          'Instructora certificada de Pilates con enfoque en fortalecimiento del core y flexibilidad.',
      packages: [
        TrainerPackage(
          id: 'pack7_1',
          name: 'Pilates Esencial',
          description: 'Fundamentos del Pilates para principiantes',
          price: 100.0,
          durationInDays: 30,
          features: [
            'Técnica básica',
            'Fortalecimiento core',
            'Flexibilidad',
            'Postura corporal'
          ],
          isPopular: true,
        ),
      ],
    ),

    // ========== NUEVA YORK, USA ==========
    Trainer(
      id: '8',
      name: 'Alex Johnson',
      profileImageUrl: 'https://example.com/alex.jpg',
      specialization: 'HIIT & Metabolic Training',
      yearsOfExperience: 7,
      rating: 4.7,
      reviewCount: 165,
      certifications: ['ACSM', 'Metabolic Conditioning'],
      languages: ['EN'],
      location: 'Manhattan, New York',
      latitude: 40.7589,
      longitude: -73.9851,
      isAvailable: true,
      description:
          'High-intensity interval training specialist focused on fat loss and metabolic conditioning.',
      packages: [
        TrainerPackage(
          id: 'pack8_1',
          name: 'HIIT Bootcamp',
          description: 'Intense workouts for maximum results',
          price: 160.0,
          durationInDays: 30,
          features: [
            'HIIT workouts',
            'Fat burning focus',
            'Cardio conditioning',
            'Strength circuits'
          ],
        ),
      ],
    ),

    Trainer(
      id: '9',
      name: 'Emily Davis',
      profileImageUrl: 'https://example.com/emily.jpg',
      specialization: 'Barre & Dance Fitness',
      yearsOfExperience: 6,
      rating: 4.9,
      reviewCount: 145,
      certifications: ['Barre Certified', 'Dance Fitness'],
      languages: ['EN'],
      location: 'Brooklyn, New York',
      latitude: 40.6892,
      longitude: -73.9442,
      isAvailable: true,
      description:
          'Former professional dancer bringing grace and strength training together through barre workouts.',
      packages: [
        TrainerPackage(
          id: 'pack9_1',
          name: 'Barre Basics',
          description: 'Ballet-inspired fitness for beginners',
          price: 120.0,
          durationInDays: 30,
          features: [
            'Ballet techniques',
            'Core strength',
            'Flexibility',
            'Graceful movements'
          ],
        ),
      ],
    ),

    // ========== LONDRES, UK ==========
    Trainer(
      id: '10',
      name: 'Oliver Smith',
      profileImageUrl: 'https://example.com/oliver.jpg',
      specialization: 'Calisthenics & Bodyweight Training',
      yearsOfExperience: 5,
      rating: 4.6,
      reviewCount: 112,
      certifications: ['Calisthenics Coach', 'Movement Specialist'],
      languages: ['EN'],
      location: 'Camden, London',
      latitude: 51.5397,
      longitude: -0.1427,
      isAvailable: true,
      description:
          'Bodyweight training expert teaching you to master your own body weight through calisthenics.',
      packages: [
        TrainerPackage(
          id: 'pack10_1',
          name: 'Calisthenics Journey',
          description: 'Master bodyweight movements from basics to advanced',
          price: 130.0,
          durationInDays: 30,
          features: [
            'Push-ups variations',
            'Pull-ups progression',
            'Core mastery',
            'Handstand training'
          ],
        ),
      ],
    ),

    // ========== TOKIO, JAPÓN ==========
    Trainer(
      id: '11',
      name: 'Hiroshi Tanaka',
      profileImageUrl: 'https://example.com/hiroshi.jpg',
      specialization: 'Martial Arts & Flexibility',
      yearsOfExperience: 20,
      rating: 4.8,
      reviewCount: 287,
      certifications: ['Karate Black Belt', 'Flexibility Coach'],
      languages: ['JA', 'EN'],
      location: 'Shibuya, Tokyo',
      latitude: 35.6598,
      longitude: 139.7006,
      isAvailable: true,
      description:
          'Master martial artist with 20 years of experience in karate and flexibility training.',
      packages: [
        TrainerPackage(
          id: 'pack11_1',
          name: 'Martial Arts Basics',
          description: 'Learn fundamental martial arts techniques',
          price: 140.0,
          durationInDays: 30,
          features: [
            'Basic techniques',
            'Flexibility training',
            'Discipline',
            'Self-defense'
          ],
        ),
      ],
    ),

    // ========== SIDNEY, AUSTRALIA ==========
    Trainer(
      id: '12',
      name: 'Sophie Anderson',
      profileImageUrl: 'https://example.com/sophie.jpg',
      specialization: 'Surf Fitness & Outdoor Training',
      yearsOfExperience: 8,
      rating: 4.7,
      reviewCount: 156,
      certifications: ['Surf Coach', 'Outdoor Fitness'],
      languages: ['EN'],
      location: 'Bondi Beach, Sydney',
      latitude: -33.8908,
      longitude: 151.2743,
      isAvailable: true,
      description:
          'Professional surfer turned fitness coach, specializing in surf conditioning and beach workouts.',
      packages: [
        TrainerPackage(
          id: 'pack12_1',
          name: 'Surf Fitness',
          description: 'Get surf-ready with specialized conditioning',
          price: 180.0,
          durationInDays: 30,
          features: [
            'Surf conditioning',
            'Balance training',
            'Beach workouts',
            'Water confidence'
          ],
        ),
      ],
    ),

    // ========== BERLÍN, ALEMANIA ==========
    Trainer(
      id: '13',
      name: 'Klaus Mueller',
      profileImageUrl: 'https://example.com/klaus.jpg',
      specialization: 'Strength Training & Powerlifting',
      yearsOfExperience: 18,
      rating: 4.9,
      reviewCount: 201,
      certifications: ['BVDK Certified', 'Powerlifting Coach'],
      languages: ['DE', 'EN'],
      location: 'Mitte, Berlin',
      latitude: 52.5170,
      longitude: 13.3888,
      isAvailable: true,
      description:
          'German precision meets strength training. Former powerlifting competitor with 18 years of coaching experience.',
      packages: [
        TrainerPackage(
          id: 'pack13_1',
          name: 'German Volume Training',
          description: 'High-volume training for serious muscle growth',
          price: 200.0,
          durationInDays: 30,
          features: [
            'High volume protocols',
            'Progressive overload',
            'Muscle hypertrophy',
            'German methodology'
          ],
        ),
      ],
    ),

    // ========== SÃO PAULO, BRASIL ==========
    Trainer(
      id: '14',
      name: 'Carlos Silva',
      profileImageUrl: 'https://example.com/carlos.jpg',
      specialization: 'Capoeira & Brazilian Jiu-Jitsu',
      yearsOfExperience: 12,
      rating: 4.8,
      reviewCount: 189,
      certifications: ['Capoeira Mestre', 'BJJ Brown Belt'],
      languages: ['PT', 'EN', 'ES'],
      location: 'Vila Madalena, São Paulo',
      latitude: -23.5489,
      longitude: -46.6388,
      isAvailable: true,
      description:
          'Brazilian martial arts expert teaching the art of Capoeira and Brazilian Jiu-Jitsu.',
      packages: [
        TrainerPackage(
          id: 'pack14_1',
          name: 'Capoeira Flow',
          description: 'Learn the beautiful art of Capoeira',
          price: 110.0,
          durationInDays: 30,
          features: [
            'Basic movements',
            'Music and rhythm',
            'Flexibility',
            'Cultural immersion'
          ],
        ),
      ],
    ),

    // ========== MÁS EN SAN FRANCISCO AREA (CERCANOS) ==========
    Trainer(
      id: '15',
      name: 'Amanda Foster',
      profileImageUrl: 'https://example.com/amanda.jpg',
      specialization: 'Prenatal & Postnatal Fitness',
      yearsOfExperience: 9,
      rating: 4.9,
      reviewCount: 167,
      certifications: [
        'Prenatal Exercise Specialist',
        'Postnatal Corrective Exercise'
      ],
      languages: ['EN'],
      location: 'Noe Valley, San Francisco',
      latitude: 37.7506,
      longitude: -122.4301,
      isAvailable: true,
      description:
          'Specialized in safe and effective fitness for expecting and new mothers.',
      packages: [
        TrainerPackage(
          id: 'pack15_1',
          name: 'Expecting Mothers',
          description: 'Safe fitness during pregnancy',
          price: 160.0,
          durationInDays: 30,
          features: [
            'Safe exercises',
            'Core stability',
            'Prenatal yoga',
            'Birth preparation'
          ],
        ),
      ],
    ),

    Trainer(
      id: '16',
      name: 'Ryan O\'Connor',
      profileImageUrl: 'https://example.com/ryan.jpg',
      specialization: 'Rock Climbing & Adventure Fitness',
      yearsOfExperience: 11,
      rating: 4.7,
      reviewCount: 143,
      certifications: ['Rock Climbing Instructor', 'Wilderness First Aid'],
      languages: ['EN'],
      location: 'Presidio, San Francisco',
      latitude: 37.7989,
      longitude: -122.4662,
      isAvailable: true,
      description:
          'Adventure fitness coach combining rock climbing techniques with functional fitness training.',
      packages: [
        TrainerPackage(
          id: 'pack16_1',
          name: 'Climbing Fitness',
          description: 'Build strength for climbing and adventure sports',
          price: 190.0,
          durationInDays: 30,
          features: [
            'Climbing techniques',
            'Grip strength',
            'Core power',
            'Adventure conditioning'
          ],
        ),
      ],
    ),

    Trainer(
      id: '17',
      name: 'Maya Patel',
      profileImageUrl: 'https://example.com/maya.jpg',
      specialization: 'Meditation & Wellness Coaching',
      yearsOfExperience: 7,
      rating: 4.8,
      reviewCount: 134,
      certifications: ['Meditation Teacher', 'Wellness Coach'],
      languages: ['EN', 'HI'],
      location: 'Haight-Ashbury, San Francisco',
      latitude: 37.7692,
      longitude: -122.4481,
      isAvailable: true,
      description:
          'Holistic wellness coach combining ancient meditation practices with modern fitness approaches.',
      packages: [
        TrainerPackage(
          id: 'pack17_1',
          name: 'Mindful Fitness',
          description: 'Unite mind and body through conscious movement',
          price: 130.0,
          durationInDays: 30,
          features: [
            'Meditation practices',
            'Mindful movement',
            'Stress reduction',
            'Holistic wellness'
          ],
        ),
      ],
    ),

    Trainer(
      id: '18',
      name: 'Tony Ricci',
      profileImageUrl: 'https://example.com/tony.jpg',
      specialization: 'Senior Fitness & Mobility',
      yearsOfExperience: 16,
      rating: 4.6,
      reviewCount: 298,
      certifications: ['Senior Fitness Specialist', 'Mobility Coach'],
      languages: ['EN', 'IT'],
      location: 'North Beach, San Francisco',
      latitude: 37.8067,
      longitude: -122.4102,
      isAvailable: true,
      description:
          'Specialized in fitness for seniors and adults over 50, focusing on mobility and functional independence.',
      packages: [
        TrainerPackage(
          id: 'pack18_1',
          name: 'Active Aging',
          description: 'Stay strong and mobile as you age',
          price: 120.0,
          durationInDays: 30,
          features: [
            'Balance training',
            'Joint mobility',
            'Fall prevention',
            'Functional movements'
          ],
        ),
      ],
    ),

    // ========== OAKLAND (ÁREA DE SAN FRANCISCO) ==========
    Trainer(
      id: '19',
      name: 'Marcus Williams',
      profileImageUrl: 'https://example.com/marcus.jpg',
      specialization: 'Basketball Training & Athletic Performance',
      yearsOfExperience: 13,
      rating: 4.7,
      reviewCount: 176,
      certifications: ['Basketball Skills Coach', 'Athletic Performance'],
      languages: ['EN'],
      location: 'Downtown Oakland',
      latitude: 37.8044,
      longitude: -122.2711,
      isAvailable: true,
      description:
          'Former college basketball player turned performance coach, specializing in athletic development.',
      packages: [
        TrainerPackage(
          id: 'pack19_1',
          name: 'Athletic Performance',
          description: 'Train like a professional athlete',
          price: 170.0,
          durationInDays: 30,
          features: [
            'Sport-specific training',
            'Agility drills',
            'Power development',
            'Performance testing'
          ],
        ),
      ],
    ),

    Trainer(
      id: '20',
      name: 'Jennifer Kim',
      profileImageUrl: 'https://example.com/jennifer.jpg',
      specialization: 'Kickboxing & Self-Defense',
      yearsOfExperience: 8,
      rating: 4.8,
      reviewCount: 154,
      certifications: ['Kickboxing Instructor', 'Self-Defense Certified'],
      languages: ['EN', 'KO'],
      location: 'Berkeley, CA',
      latitude: 37.8715,
      longitude: -122.2730,
      isAvailable: true,
      description:
          'Empowering women through kickboxing and self-defense training while building confidence and strength.',
      packages: [
        TrainerPackage(
          id: 'pack20_1',
          name: 'Kickboxing Power',
          description: 'Learn kickboxing while getting in amazing shape',
          price: 140.0,
          durationInDays: 30,
          features: [
            'Kickboxing techniques',
            'Self-defense',
            'Cardio conditioning',
            'Confidence building'
          ],
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
    return _mockTrainers.take(6).toList();
  }
}
