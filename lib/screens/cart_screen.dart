import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/cart/cart_bloc.dart';
import '../blocs/cart/cart_state.dart';
import '../utils/constants.dart';
import '../utils/text_styles.dart';
import '../widgets/cart_item_tile.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(title: const Text(Constants.cartTitle,style: TextStyles.priceText,),backgroundColor: const Color.fromRGBO(255, 255, 255, 1),),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartUpdated) {
            // Calculate total quantity and price
            final totalQuantity = state.cartItems.fold<int>(
              0,
              (sum, item) => sum + item.quantity,
            );
            final totalPrice = state.cartItems.fold<double>(
              0.0,
              (sum, item) => sum + (item.quantity * item.foodItem.price),
            );

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.cartItems.length,
                    itemBuilder: (context, index) {
                      final cartItem = state.cartItems[index];
                      return CartItemTile(cartItem: cartItem);
                    },
                  ),
                ),
                // Pay Button
                totalQuantity > 0
                    ? Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: InkWell(
                          onTap: () {
                            //Navigator.pop(context);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  Constants.payButtonText,
                                  style: TextStyles.payButtonTextStyle,
                                ),
                                Text(
                                  '$totalQuantity ${Constants.itemsText}${totalPrice.toStringAsFixed(2)}',
                                  style: TextStyles.payButtonTextStyle,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            );
          }
          return const Center(child: Text(Constants.emptyCartMessage));
        },
      ),
    );
  }
}
