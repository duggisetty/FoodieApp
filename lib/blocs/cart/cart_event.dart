import '../../models/cart_item.dart';

abstract class CartEvent {}

class AddToCart extends CartEvent {
  final CartItem cartItem;

  AddToCart(this.cartItem);
}

class RemoveFromCart extends CartEvent {
  final String foodItemId;

  RemoveFromCart(this.foodItemId);
}

class DecrementQuantity extends CartEvent {
  final String foodItemId;

  DecrementQuantity(this.foodItemId);
}
