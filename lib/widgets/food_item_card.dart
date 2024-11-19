import 'package:flutter/material.dart';
import '../models/food_item.dart';
import '../utils/constants.dart';
import '../utils/text_styles.dart';

class FoodCard extends StatelessWidget {
  final FoodItem foodItem;

  const FoodCard({Key? key, required this.foodItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Container for image with shadow
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(75),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(4, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(75),
              child: Image.network(
                foodItem.imageUrl,
                height: 150,
                width: 150,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 80,
                  width: 80,
                  color: Colors.grey[200],
                  child: const Icon(Icons.image, color: Colors.grey),
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),

          // Food Details
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                foodItem.name,
                style: TextStyles
                    .foodName, 
                maxLines: 2, 
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(246, 246, 246, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '\$${foodItem.price.toStringAsFixed(2)}',
                      style: TextStyles.priceText, 
                    ),
                  ),
                  const SizedBox(width: 20),
                  const Text(
                    '325 ${Constants.kcal}',
                    style: TextStyles.lightGrey, 
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
