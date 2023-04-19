import 'package:flutter/cupertino.dart';

class Food {
  final String name;
  final int calories;
  final String image;

  Food({required this.name, required this.calories, required this.image});
}

class FoodData extends ChangeNotifier {
  List<Food> _foods = [
    Food(name: 'Apple', calories: 52, image: 'assets/images/apple.png'),
    Food(name: 'Banana', calories: 89, image: 'assets/images/banana.png'),
    Food(name: 'Burger', calories: 354, image: 'assets/images/burger.png'),
    Food(name: 'Cheese', calories: 113, image: 'assets/images/cheese.png'),
    Food(
        name: 'Chocolate', calories: 546, image: 'assets/images/chocolate.png'),
    Food(name: 'Coffee', calories: 2, image: 'assets/images/coffee.png'),
    Food(name: 'Egg', calories: 78, image: 'assets/images/egg.png'),
    Food(name: 'Fries', calories: 365, image: 'assets/images/fries.png'),
    Food(name: 'Pizza', calories: 285, image: 'assets/images/pizza.png'),
    Food(name: 'Soda', calories: 140, image: 'assets/images/soda.png'),
    Food(name: 'Steak', calories: 250, image: 'assets/images/steak.png'),
    Food(name: 'Water', calories: 0, image: 'assets/images/water.png'),
  ];

  List<Food> _selectedFoods = [];

  List<Food> get foods => _foods;

  List<Food> get selectedFoods => _selectedFoods;

  void addSelectedFood(Food food) {
    _selectedFoods.add(food);
    notifyListeners();
  }

  void removeSelectedFood(Food food) {
    _selectedFoods.remove(food);
    notifyListeners();
  }

  int get totalCalories =>
      _selectedFoods.fold(0, (sum, food) => sum + food.calories);

  void clearSelectedFoods() {
    _selectedFoods.clear();
    notifyListeners();
  }
}
