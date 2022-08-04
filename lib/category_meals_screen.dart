import 'package:flutter/material.dart';
import 'package:third_app/meal.dart';

import './meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';
  final List<Meal> avalibleMeals;
  CategoryMealsScreen(this.avalibleMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle = '';
  List<Meal> displyMeals = [];
  bool _loadedInitData = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routeargs =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      categoryTitle = routeargs['title']!;
      final categoryId = routeargs['id'];
      displyMeals = widget.avalibleMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      displyMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(categoryTitle),
        ),
        body: ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
                id: displyMeals[index].id,
                affordability: displyMeals[index].affordability,
                complexity: displyMeals[index].complexity,
                duration: displyMeals[index].duration,
                imageUrl: displyMeals[index].imageUrl,
                title: displyMeals[index].title);
          },
          itemCount: displyMeals.length,
        ));
  }
}
