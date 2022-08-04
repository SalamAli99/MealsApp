import 'package:flutter/material.dart';
import 'package:third_app/meal.dart';

import './meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favouriteMeals;
  FavoritesScreen(this.favouriteMeals);
  @override
  Widget build(BuildContext context) {
    if (favouriteMeals.isEmpty) {
      return Center(
        child: Text('you have no favorites yet - start adding some!'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
              id: favouriteMeals[index].id,
              affordability: favouriteMeals[index].affordability,
              complexity: favouriteMeals[index].complexity,
              duration: favouriteMeals[index].duration,
              imageUrl: favouriteMeals[index].imageUrl,
              title: favouriteMeals[index].title);
        },
        itemCount: favouriteMeals.length,
      );
    }
  }
}
