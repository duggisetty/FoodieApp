import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/cart/cart_bloc.dart';
import '../blocs/cart/cart_event.dart';
import '../models/cart_item.dart';
import '../utils/text_styles.dart';

class CartItemTile extends StatelessWidget {
  final CartItem cartItem;

  const CartItemTile({Key? key, required this.cartItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromRGBO(255, 255, 255, 1),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Food Item Image
            Image.network(
              cartItem.foodItem.imageUrl,
              height: 60,
              width: 60,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 10),

            // Food Item Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.foodItem.name,
                    style: TextStyles.foodItemName,
                  ),
                  Text(
                    '\$${(cartItem.foodItem.price * cartItem.quantity).toStringAsFixed(2)}',
                    style: TextStyles.foodItemPrice,
                  ),
                ],
              ),
            ),

            // Quantity Controls
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    if (cartItem.quantity > 1) {
                      context
                          .read<CartBloc>()
                          .add(DecrementQuantity(cartItem.foodItem.id));
                    } else {
                      context
                          .read<CartBloc>()
                          .add(RemoveFromCart(cartItem.foodItem.id));
                    }
                  },
                ),
                Text(
                  cartItem.quantity.toString(),
                  style: TextStyles.quantityText,
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    context.read<CartBloc>().add(AddToCart(cartItem));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
