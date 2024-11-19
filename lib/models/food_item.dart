import 'package:equatable/equatable.dart';

class FoodItem extends Equatable {
  final String id;
  final String name;
  final String imageUrl;
  final double price;

  const FoodItem({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
  });

  @override
  List<Object?> get props => [id, name, imageUrl, price];
}
