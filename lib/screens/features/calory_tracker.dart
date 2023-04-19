import 'package:boostme/responsive/mobile_screen_layout.dart';
import 'package:boostme/screens/social/feed_screen.dart';
import 'package:boostme/utils/colors.dart';
import 'package:boostme/utils/food_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(CalorieTracker());
}

class CalorieTracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FoodData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Calorie Tracker',
        initialRoute: '/',
        routes: {
          '/': (context) => FoodListScreen(),
          '/calorie': (context) => CalorieScreen(),
        },
      ),
    );
  }
}

class FoodListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text('Calorie Tracker'),
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const MobileScreenLayout(),
              ),
            );
          },
          color: Colors.white, // <-- SEE HERE
        ),
        centerTitle: true,
      ),
      body: Consumer<FoodData>(
        builder: (context, foodData, child) {
          return Container(
            color: mobileBackgroundColor,
            child: ListView.builder(
              itemCount: foodData.foods.length,
              itemBuilder: (context, index) {
                final food = foodData.foods[index];
                return ListTile(
                  title: Text(
                    food.name,
                    style: const TextStyle(color: primaryColor),
                  ),
                  trailing: Text(
                    '${food.calories} cal',
                    style: const TextStyle(color: primaryColor),
                  ),
                  leading: Image.asset(
                    'assets/images/${food.name.toLowerCase()}.png',
                    width: 50,
                    height: 50,
                    fit: BoxFit.contain,
                  ),
                  onTap: () {
                    foodData.addSelectedFood(food);
                  },
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
          Navigator.pushNamed(context, '/calorie');
        },
      ),
    );
  }
}

class CalorieScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text('Selected Foods'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Consumer<FoodData>(
                builder: (context, foodData, child) {
                  return ListView.builder(
                    itemCount: foodData.selectedFoods.length,
                    itemBuilder: (context, index) {
                      final food = foodData.selectedFoods[index];
                      return ListTile(
                        hoverColor: Colors.blueAccent,
                        title: Text(
                          food.name,
                          style: const TextStyle(color: primaryColor),
                        ),
                        trailing: Text(
                          '${food.calories} cal',
                          style: const TextStyle(color: primaryColor),
                        ),
                        leading: Image.asset(
                          'assets/images/${food.name.toLowerCase()}.png',
                          width: 50,
                          height: 50,
                          fit: BoxFit.contain,
                        ),
                        onTap: () {
                          foodData.removeSelectedFood(food);
                        },
                      );
                    },
                  );
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: blueColor,
              ),
              child: TextButton(
                onPressed: () {
                  Provider.of<FoodData>(context, listen: false)
                      .clearSelectedFoods();
                },
                child: Text(
                  'Clear Selected Foods',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Consumer<FoodData>(
                builder: (context, foodData, child) {
                  return Text(
                    'Total Calories: ${foodData.totalCalories}',
                    style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
