import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodie_app/widgets/food_item_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../blocs/cart/cart_bloc.dart';
import '../blocs/cart/cart_event.dart';
import '../blocs/cart/cart_state.dart';
import '../blocs/food/food_bloc.dart';
import '../blocs/food/food_event.dart';
import '../blocs/food/food_state.dart';
import '../models/cart_item.dart';
import '../models/food_item.dart';
import '../utils/constants.dart';
import '../utils/text_styles.dart';
import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  // List<CartItem> _cartItems = [];
  int price = 1;
  int initialPrice = 0;
  int quantity = 1;
  int cutleryQuantity = 1;
  List<FoodItem> foodItems = [];
  List<String> imageUrls = [];
  List<String> categories = [];

  @override
  void initState() {
    super.initState();
    context.read<FoodBloc>().add(LoadFoodItems());
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
          titleSpacing:2,
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        title: Container(
          padding: const EdgeInsets.all(10),
          // height: 50,
          // width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.black,
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FittedBox(
                child: Text(
                  Constants.locationText,
                  style: TextStyles.locationTextStyle,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [

          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.search_outlined),
                onPressed: () => {},
              ),
              Padding(
                  padding: const EdgeInsets.all(4),
                  child: BlocBuilder<CartBloc, CartState>(
                    builder: (context, state) {
                      int cartItemCount = 0;
                      if (state is CartUpdated) {
                        cartItemCount = state.cartItems.length;
                      }
                      return IconButton(
                        icon: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            const Icon(Icons.shopping_cart),
                            if (cartItemCount > 0)
                              Positioned(
                                right: 0,
                                top: 0,
                                child: CircleAvatar(
                                  radius: 6,
                                  backgroundColor: Colors.red,
                                  child: Text(
                                    '$cartItemCount',
                                    style: const TextStyle(
                                        fontSize: 9, color: Colors.white),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CartScreen()),
                          );
                        },
                      );
                    },
                  )),


            ],
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const Text(
              '',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text(Constants.home),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text(Constants.cartTitle),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: BlocBuilder<FoodBloc, FoodState>(
        builder: (context, state) {
          if (state is FoodLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FoodLoaded) {
            final foodItems = state.foodItems;
            List<String> imageUrls =
                foodItems.map((foodItem) => foodItem.imageUrl).take(4).toList();
            List<String> categories =
                foodItems.map((foodItem) => foodItem.name).toList();

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(Constants.hitsOfTheWeekText,
                        style: TextStyles.hitsOfTheWeekTitleStyle),
                  ),
                  // Horizontal image slider
                  SizedBox(
                    height: 200,
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: 200,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.9,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                      ),
                      items: imageUrls.map((imageUrl) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(imageUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  // Indicator Dots
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 8.0, // Horizontal space between children
                      runSpacing: 4.0, // Vertical space between rows
                      children: List.generate(imageUrls.length, (index) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: 4,
                          width: 60,
                          decoration: BoxDecoration(
                            color: _currentIndex == index
                                ? Colors.black
                                : const Color.fromARGB(255, 246, 246, 246),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        );
                      }),
                    ),
                  ),

                  // Horizontal list of categories
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Chip(
                            label: Text(categories[index]),
                            backgroundColor:
                                const Color.fromARGB(255, 246, 246, 246),
                            side: BorderSide.none,
                          ),
                        );
                      },
                    ),
                  ),
                  // Food items list
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: foodItems.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          showFoodDetailsBottomSheet(context, foodItems[index]);
                        },
                        child: FoodCard(foodItem: foodItems[index]),
                      );
                    },
                  ),
                ],
              ),
            );
          } else if (state is FoodError) {
            return Center(
                child: Text('${Constants.errorText}: ${state.message}'));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget cartFieldsWidget(
      FoodItem foodItem, BuildContext context, StateSetter setState) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(),
        Container(
          alignment: Alignment.center,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(
              foodItem.imageUrl,
              height: 200,
              width: 200,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 80,
                width: 80,
                color: Colors.grey[200],
                child: const Icon(
                  Icons.image,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ),
        Text(
          foodItem.name,
          style: TextStyles.foodItemTitleStyle,
        ),
        const Text(
          Constants.foodDescription,
          style: TextStyles.foodDescriptionStyle,
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            border: Border.all(
              color: const Color.fromARGB(255, 246, 246, 246),
              width: 1,
            ),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    '325',
                    style: TextStyles.nutrientValueStyle,
                  ),
                  Text(Constants.kcal, style: TextStyles.nutrientLabelStyle),
                ],
              ),
              Column(
                children: [
                  Text(
                    '420',
                    style: TextStyles.nutrientValueStyle,
                  ),
                  Text(Constants.grams, style: TextStyles.nutrientLabelStyle),
                ],
              ),
              Column(
                children: [
                  Text(
                    '21',
                    style: TextStyles.nutrientValueStyle,
                  ),
                  Text(Constants.proteins,
                      style: TextStyles.nutrientLabelStyle),
                ],
              ),
              Column(
                children: [
                  Text(
                    '19',
                    style: TextStyles.nutrientValueStyle,
                  ),
                  Text(Constants.fats, style: TextStyles.nutrientLabelStyle),
                ],
              ),
              Column(
                children: [
                  Text(
                    '65',
                    style: TextStyles.nutrientValueStyle,
                  ),
                  Text(Constants.carbs, style: TextStyles.nutrientLabelStyle),
                ],
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              Constants.addToPoke,
              style: TextStyles.actionButtonStyle,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.chevron_right),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 246, 246, 246),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (quantity > 0) {
                          quantity -= 1;
                          removeFromCart(foodItem.id);
                        }
                      });
                    },
                    icon: const Icon(Icons.remove),
                  ),
                  Text(
                    "$quantity",
                    style: TextStyles.nutrientValueStyle,
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        quantity += 1;
                        addToCart(foodItem);
                      });
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: InkWell(
                onTap: () {
                  addToCart(foodItem);
                  Navigator.pop(context);
                  showCustomToast(context, foodItem);
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black,
                  ),
                  child: FittedBox(
                    child: Text(
                      '${Constants.addToCartPrefix}${(foodItem.price * quantity).toStringAsFixed(2)}',
                      style: TextStyles.payButtonTextStyle,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget payFieldsWidget(
      FoodItem foodItem, BuildContext context, StateSetter setState) {
    final cartItem = CartItem(foodItem: foodItem);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(),
        const Text(
          Constants.deliveryTimeText,
          style: TextStyles.foodItemTitleStyle,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        const Row(
          children: [
            Text(
              Constants.deliveryAddress,
              style: TextStyles.cartItemTitleStyle,
            ),
            SizedBox(width: 10),
            Text(
              Constants.changeAddress,
              style: TextStyles.nutrientLabelStyle,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                borderRadius: BorderRadius.circular(35),
                child: Image.network(
                  foodItem.imageUrl,
                  height: 70,
                  width: 70,
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
            Column(
              children: [
                Text(
                  foodItem.name,
                  style: TextStyles.cartItemTitleStyle,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 246, 246, 246),
                      ),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            if (quantity > 0) {
                              quantity -= 1;
                              removeFromCart(foodItem.id);
                            }
                          });
                        },
                        icon: const Icon(Icons.remove),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "$quantity",
                      style: TextStyles.nutrientValueStyle,
                    ),
                    const SizedBox(width: 5),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 246, 246, 246),
                      ),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            quantity += 1;
                            addToCart(foodItem);
                          });
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              '\$ ${(quantity * cartItem.foodItem.price).toStringAsFixed(2)}',
              style: TextStyles.cartItemPriceStyle,
            ),
          ],
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            border: Border.all(
              color: const Color.fromARGB(255, 246, 246, 246),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const FaIcon(
                FontAwesomeIcons.utensils,
                size: 24.0,
                color: Colors.black,
              ),
              const Text(
                Constants.cutleryText,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 246, 246, 246),
                    ),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          if (cutleryQuantity > 0) {
                            cutleryQuantity -= 1;
                          }
                        });
                      },
                      icon: const Icon(Icons.remove),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '$cutleryQuantity',
                    style: TextStyles.nutrientValueStyle,
                  ),
                  const SizedBox(width: 5),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 246, 246, 246),
                    ),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          cutleryQuantity += 1;
                        });
                      },
                      icon: const Icon(Icons.add),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Constants.deliveryTitle,
                  style: TextStyles.deliveryTitleStyle,
                ),
                Text(Constants.deliveryFreeText,
                    style: TextStyles.deliveryFreeTextStyle)
              ],
            ),
            Text(
              '\$ ${(quantity * foodItem.price).toStringAsFixed(2)}',
              style: TextStyles.cartItemPriceStyle,
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              Constants.paymentMethodText,
              style: TextStyles.paymentMethodTextStyle,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.ccApplePay,
                      size: 24.0,
                      color: Colors.black,
                    ),
                    SizedBox(width: 10),
                    Text(
                      Constants.applePayText,
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.chevron_right),
                ),
              ],
            ),
          ],
        ),
        InkWell(
          onTap: () {
            Navigator.pop(context);
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
                  '${Constants.twentyFourMin}${(quantity * cartItem.foodItem.price).toStringAsFixed(2)}',
                  style: TextStyles.payButtonTextStyle,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void showFoodDetailsBottomSheet(
    BuildContext context,
    FoodItem foodItem,
  ) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                bool isLandscape =
                    MediaQuery.of(context).orientation == Orientation.landscape;

                return SizedBox(
                  height: constraints.maxHeight - 70,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: isLandscape
                        ? SingleChildScrollView(
                            child:
                                cartFieldsWidget(foodItem, context, setState),
                          )
                        : cartFieldsWidget(foodItem, context, setState),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  void addToCart(FoodItem foodItem) {
    final cartItem = CartItem(foodItem: foodItem);
    context.read<CartBloc>().add(AddToCart(cartItem));
  }

  void removeFromCart(String foodItemId) {
    context.read<CartBloc>().add(RemoveFromCart(foodItemId));
  }

  void showCustomToast(
    BuildContext context,
    FoodItem foodItem,
  ) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final overlay = Overlay.of(context);
    OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 30,
        left: MediaQuery.of(context).size.width * 0.05,
        child: GestureDetector(
          onTap: () {
            showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              builder: (BuildContext context) {
                return StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        return SizedBox(
                          height: constraints.maxHeight - 70,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: isLandscape
                                ? SingleChildScrollView(
                                    child: payFieldsWidget(
                                        foodItem, context, setState),
                                  )
                                : payFieldsWidget(foodItem, context, setState),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            );
          },
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    Constants.cartTitle,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${Constants.twentyFourMin}${foodItem.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }
}
