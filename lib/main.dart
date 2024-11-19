import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/cart/cart_bloc.dart';
import 'blocs/food/food_bloc.dart';
import 'blocs/food/food_event.dart';
import 'repositories/food_repository.dart';
import 'screens/home_screen.dart';

void main() {
  final foodRepository = FoodRepository();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => FoodBloc(foodRepository)..add(LoadFoodItems())),
        BlocProvider(create: (_) => CartBloc()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    ),
  );
}
