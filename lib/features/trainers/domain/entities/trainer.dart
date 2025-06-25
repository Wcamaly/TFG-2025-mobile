class Trainer {
  final String id;
  final String name;
  final String profileImageUrl;
  final String specialization;
  final int yearsOfExperience;
  final double rating;
  final int reviewCount;
  final List<String> certifications;
  final List<String> languages;
  final String location;
  final double latitude;
  final double longitude;
  final bool isAvailable;
  final List<TrainerPackage> packages;
  final String description;

  const Trainer({
    required this.id,
    required this.name,
    required this.profileImageUrl,
    required this.specialization,
    required this.yearsOfExperience,
    required this.rating,
    required this.reviewCount,
    required this.certifications,
    required this.languages,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.isAvailable,
    required this.packages,
    required this.description,
  });

  factory Trainer.fromJson(Map<String, dynamic> json) {
    return Trainer(
      id: json['id'] as String,
      name: json['name'] as String,
      profileImageUrl: json['profileImageUrl'] as String,
      specialization: json['specialization'] as String,
      yearsOfExperience: json['yearsOfExperience'] as int,
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['reviewCount'] as int,
      certifications: List<String>.from(json['certifications'] as List),
      languages: List<String>.from(json['languages'] as List),
      location: json['location'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      isAvailable: json['isAvailable'] as bool,
      packages: (json['packages'] as List)
          .map((e) => TrainerPackage.fromJson(e as Map<String, dynamic>))
          .toList(),
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'profileImageUrl': profileImageUrl,
      'specialization': specialization,
      'yearsOfExperience': yearsOfExperience,
      'rating': rating,
      'reviewCount': reviewCount,
      'certifications': certifications,
      'languages': languages,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'isAvailable': isAvailable,
      'packages': packages.map((e) => e.toJson()).toList(),
      'description': description,
    };
  }
}

class TrainerPackage {
  final String id;
  final String name;
  final String description;
  final double price;
  final int durationInDays;
  final List<String> features;
  final bool isPopular;

  const TrainerPackage({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.durationInDays,
    required this.features,
    this.isPopular = false,
  });

  factory TrainerPackage.fromJson(Map<String, dynamic> json) {
    return TrainerPackage(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      durationInDays: json['durationInDays'] as int,
      features: List<String>.from(json['features'] as List),
      isPopular: json['isPopular'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'durationInDays': durationInDays,
      'features': features,
      'isPopular': isPopular,
    };
  }
}
