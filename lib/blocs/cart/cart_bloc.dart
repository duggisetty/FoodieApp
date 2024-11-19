import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/cart_item.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final List<CartItem> _cart = [];

  CartBloc() : super(CartInitial()) {
    on<AddToCart>((event, emit) {
      final index = _cart.indexWhere((item) => item.foodItem.id == event.cartItem.foodItem.id);
      if (index >= 0) {
        _cart[index].quantity++;
      } else {
        _cart.add(event.cartItem);
      }
      emit(CartUpdated(List.from(_cart)));  // Emit the updated cart
    });

    on<RemoveFromCart>((event, emit) {
      _cart.removeWhere((item) => item.foodItem.id == event.foodItemId);
      emit(CartUpdated(List.from(_cart)));  // Emit the updated cart
    });

    on<DecrementQuantity>((event, emit) {
      final index = _cart.indexWhere((item) => item.foodItem.id == event.foodItemId);
      if (index >= 0 && _cart[index].quantity > 1) {
        _cart[index].quantity--;
        emit(CartUpdated(List.from(_cart)));  // Emit the updated cart after decrement
      }
    });
  }
}
