import 'package:equatable/equatable.dart';

class MenuItem extends Equatable {
  final String id;
  final String name;
  final double price;
  final bool available;
  final String image;

  const MenuItem({
    required this.id,
    required this.name,
    required this.price,
    required this.available,
    required this.image,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) => MenuItem(
        id: json['id'],
        name: json['name'],
        price: json['price'].toDouble(),
        available: json['available'],
        image: json['image'],
      );

  MenuItem copyWith({
    String? id,
    String? name,
    double? price,
    bool? available,
    String? image,
  }) =>
      MenuItem(
        id: id ?? this.id,
        name: name ?? this.name,
        price: price ?? this.price,
        available: available ?? this.available,
        image: image ?? this.image,
      );

  @override
  List<Object> get props => [id, name, price, available, image];
}