import 'package:flutter/material.dart';
import './dummy_data.dart';
import './meal.dart';
import './tabs_screen.dart';
import './meal_detail_screen.dart';
import './category_meals_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegaterian': false,
  };
  List<Meal> _avalibleMeals = DUMMY_MEALS;
  List<Meal> _favoritesMeals = [];
  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _avalibleMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten']! && !meal.isGlutenFree) return false;

        if (_filters['lactose']! && !meal.isLactoseFree) return false;
        if (_filters['vegan']! && !meal.isVegan) return false;
        if (_filters['vegaterian']! && !meal.isVegetarian) return false;
        return true;
      }).toList();
    });
  }

  void _toggleFavorites(String mealId) {
    final existingIndex =
        _favoritesMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favoritesMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoritesMeals
            .add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isMealFavourite(String id) {
    return _favoritesMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        primaryColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText2: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            bodyText1: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            headline6: TextStyle(
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            )),
      ),
      // home: CategoriesScreen(),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabsScreen(_favoritesMeals),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(_avalibleMeals),
        MealDetailScreen.routeName: (ctx) =>
            MealDetailScreen(_toggleFavorites, _isMealFavourite),
      },
      // onGenerateRoute: (settings){
      //   print(settings.arguments);
      //   return MaterialPageRoute(builder: (ctx)=>CategoriesScreen());
      // },
      // onUnknownRoute:(settings){
      //   return MaterialPageRoute(builder: (ctx)=>CategoriesScreen());

      // } ,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DeliMeals'),
      ),
      body: Center(child: Text('Navigation Time')),
    );
  }
}
