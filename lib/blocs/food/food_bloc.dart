import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/food_repository.dart';
import 'food_state.dart';
import 'food_event.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  final FoodRepository foodRepository;

  FoodBloc(this.foodRepository) : super(FoodLoading()) {
    on<LoadFoodItems>((event, emit) async {
      try {
        // Attempt to fetch the food items
        final foodItems = await foodRepository.fetchFoodItems();
        emit(FoodLoaded(foodItems));
      } catch (e) {
        // If an error occurs, emit the FoodError state
        emit(FoodError('Failed to load food items: $e'));
      }
    });
  }
}
