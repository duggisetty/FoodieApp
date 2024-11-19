import 'package:flutter/material.dart';

class TextStyles {
  static const TextStyle categoryTextStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w300,
    fontSize: 24,
  );

  static const TextStyle lightgrey = TextStyle(
      color: Color.fromARGB(255, 204, 203, 203),
      fontSize: 18,
      // fontWeight: FontWeight.bold
      );

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

    static const TextStyle foodName = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18,
  );

  // Style for the price text
  static const TextStyle priceText = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 24,
  );

  // Light grey text style for calories
  static const TextStyle lightGrey = TextStyle(
    color: Color.fromARGB(255, 204, 203, 203),
    fontSize: 14,
  );


  static const TextStyle foodItemName = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  // Style for the food item price (grey text)
  static const TextStyle foodItemPrice = TextStyle(
    color: Colors.grey,
    fontSize: 14,
  );

  // Style for the quantity number (default size)
  static const TextStyle quantityText = TextStyle(
    fontSize: 16,
  );

    static const TextStyle locationTextStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w400,
    fontSize: 16,
  );

  // Title for the "Hits of the Week" section
  static const TextStyle hitsOfTheWeekTitleStyle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 24,
  );
   static const TextStyle foodItemTitleStyle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle foodDescriptionStyle = TextStyle(
    fontSize: 14,
    color: Colors.grey,
  );

  static const TextStyle nutrientValueStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle nutrientLabelStyle = TextStyle(
    fontSize: 14,
    color: Colors.grey,
  );

  static const TextStyle actionButtonStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle cartItemTitleStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle cartItemPriceStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle deliveryTitleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle deliveryFreeTextStyle = TextStyle(
    fontSize: 14,
    color: Colors.grey,
  );

  static const TextStyle paymentMethodTextStyle = TextStyle(
    fontSize: 16,
    color: Colors.grey,
  );

  static const TextStyle payButtonTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 18,
  );
}
