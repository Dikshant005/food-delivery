import 'package:equatable/equatable.dart';

class Restaurant extends Equatable {
  final String id;
  final String name;
  final String image;
  const Restaurant({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json['id'],
        name: json['name'],
        image: json['image'],
      );

  @override
  List<Object> get props => [id, name, image];
}