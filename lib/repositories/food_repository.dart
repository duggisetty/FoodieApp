import '../models/food_item.dart';

class FoodRepository {
  
  Future<List<FoodItem>> fetchFoodItems() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      const FoodItem(
          id: '1',
          name: 'Pizza',
          imageUrl:
              'https://images.pexels.com/photos/1566837/pexels-photo-1566837.jpeg?auto=compress&cs=tinysrgb&w=800',
          price: 9.99),
      const FoodItem(
          id: '2',
          name: 'Burger',
          imageUrl:
              'https://images.pexels.com/photos/808941/pexels-photo-808941.jpeg?auto=compress&cs=tinysrgb&w=800',
          price: 5.99),
      const FoodItem(
          id: '3',
          name: 'Berry',
          imageUrl:
              'https://images.pexels.com/photos/566888/pexels-photo-566888.jpeg?auto=compress&cs=tinysrgb&w=800',
          price: 7.99),
      const FoodItem(
          id: '4',
          name: 'Onion',
          imageUrl:
              'https://images.pexels.com/photos/533342/pexels-photo-533342.jpeg?auto=compress&cs=tinysrgb&w=800',
          price: 9.99),
      const FoodItem(
          id: '5',
          name: 'Meet',
          imageUrl:
              'https://images.pexels.com/photos/361184/asparagus-steak-veal-steak-veal-361184.jpeg?auto=compress&cs=tinysrgb&w=800',
          price: 5.99),
      const FoodItem(
          id: '6',
          name: 'Nimbu',
          imageUrl:
              'https://media.istockphoto.com/id/2154842087/photo/a-wooden-basket-filled-with-fresh-green-organic-lemons-with-leaves.jpg?b=1&s=612x612&w=0&k=20&c=-a2sWv8j6a6YxoyaXB_1gUeprrM2grnNB-LtRxXNeok=',
          price: 7.99),
      const FoodItem(
          id: '7',
          name: 'Ginger',
          imageUrl:
              'https://images.pexels.com/photos/161556/ginger-plant-asia-rhizome-161556.jpeg?auto=compress&cs=tinysrgb&w=800',
          price: 9.99),
      const FoodItem(
          id: '8',
          name: 'Egg',
          imageUrl:
              'https://images.pexels.com/photos/566566/pexels-photo-566566.jpeg?auto=compress&cs=tinysrgb&w=800',
          price: 5.99),
      const FoodItem(
          id: '9',
          name: 'Banana',
          imageUrl:
              'https://images.pexels.com/photos/1093038/pexels-photo-1093038.jpeg?auto=compress&cs=tinysrgb&w=800',
          price: 7.99),
      const FoodItem(
          id: '10',
          name: 'Papaya',
          imageUrl:
              'https://images.pexels.com/photos/2872755/pexels-photo-2872755.jpeg?auto=compress&cs=tinysrgb&w=800',
          price: 7.99),
      const FoodItem(
          id: '11',
          name: 'Muskmelon',
          imageUrl:
              'https://images.pexels.com/photos/262959/pexels-photo-262959.jpeg?auto=compress&cs=tinysrgb&w=800',
          price: 7.99),
      const FoodItem(
          id: '12',
          name: 'grapes',
          imageUrl:
              'https://images.pexels.com/photos/1099680/pexels-photo-1099680.jpeg?auto=compress&cs=tinysrgb&w=800',
          price: 7.99),
      const FoodItem(
          id: '14',
          name: 'Carrot',
          imageUrl:
              'https://images.pexels.com/photos/1566837/pexels-photo-1566837.jpeg?auto=compress&cs=tinysrgb&w=800',
          price: 7.99),
    ];
  }

  // final List<Widget> categories = [
  //   const Icon(Icons.local_pizza),
  //   const Text('Pizza'),
  //   const Text('Burgers'),
  //   const Text('Pasta'),
  //   const Text('Sushi'),
  //   const Text('Salads'),
  //   const Icon(Icons.cake),
  //   const Text('Desserts'),
  //   const Icon(Icons.local_drink),
  //   const Text('Drinks'),
  //   const Icon(Icons.fastfood),
  //   const Text('Fast Food'),
  // ];

  // final List<String> imageUrls = [
  //   'https://images.sirved.com/ChIJp057m_aTrIkRVYTEbazJt6I/kMpGPcKwr0_wideh.jpg',
  //   'https://images.pexels.com/photos/1099680/pexels-photo-1099680.jpeg?auto=compress&cs=tinysrgb&w=800',
  //   'https://images.pexels.com/photos/262959/pexels-photo-262959.jpeg?auto=compress&cs=tinysrgb&w=800',
  //   'https://images.pexels.com/photos/2872755/pexels-photo-2872755.jpeg?auto=compress&cs=tinysrgb&w=800'
  // ];
}
