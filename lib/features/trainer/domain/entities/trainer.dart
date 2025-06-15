import 'package:equatable/equatable.dart';

class Trainer extends Equatable {
  final String id;
  final String name;
  final String photoUrl;
  final double rating;
  final List<String> languages;
  final String description;
  final List<TrainingPack> trainingPacks;
  final Location location;

  const Trainer({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.rating,
    required this.languages,
    required this.description,
    required this.trainingPacks,
    required this.location,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        photoUrl,
        rating,
        languages,
        description,
        trainingPacks,
        location,
      ];
}

class TrainingPack extends Equatable {
  final String id;
  final String title;
  final String description;
  final double price;
  final int durationInWeeks;
  final String difficulty;

  const TrainingPack({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.durationInWeeks,
    required this.difficulty,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        price,
        durationInWeeks,
        difficulty,
      ];
}

class Location extends Equatable {
  final double latitude;
  final double longitude;
  final String address;
  final String city;
  final String country;

  const Location({
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.city,
    required this.country,
  });

  @override
  List<Object?> get props => [
        latitude,
        longitude,
        address,
        city,
        country,
      ];
}
