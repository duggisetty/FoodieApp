import 'package:equatable/equatable.dart';
import '../../models/food_item.dart';

abstract class FoodState extends Equatable {
  const FoodState();

  @override
  List<Object?> get props => [];
}

class FoodLoading extends FoodState {}

class FoodLoaded extends FoodState {
  final List<FoodItem> foodItems;

  const FoodLoaded(this.foodItems);

  @override
  List<Object?> get props => [foodItems];
}

class FoodError extends FoodState {
  final String message;

  const FoodError(this.message);

  @override
  List<Object?> get props => [message];
}
