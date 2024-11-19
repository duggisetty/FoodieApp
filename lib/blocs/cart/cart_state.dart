import '../../models/cart_item.dart';

abstract class CartState {
  const CartState();
  
  List<CartItem> get cartItems => [];
}

class CartInitial extends CartState {}

class CartUpdated extends CartState {
  final List<CartItem> cartItems;

  CartUpdated(this.cartItems);  // Directly use this list
}
