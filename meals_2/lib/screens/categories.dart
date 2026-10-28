import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_2/data/dummy_data.dart';
import 'package:meals_2/models/category.dart';
import 'package:meals_2/providers/filters_provider.dart';
import 'package:meals_2/screens/meals.dart';
import 'package:meals_2/widgets/category_grid_item.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

class _CategoriesScreenState extend State<CategoriesScreen>
with SingleTickerProviderStateMixin
  late AnimationController _animationController;

  @override
  void initState(){
    super.initState();
    _animationController = AnimationController(vsync: this,
    duration: Duration(milliseconds: 300),);
  }



  void _selectCategory(BuildContext context, WidgetRef ref, Category category) {
    final availableMeals = ref.read(FilteredMealsProvider);
    final filteredMeals = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
        ),
      ),
    );
  }

  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
        builder: (context, child) => SlideTransition(position: Tween(
          begin: const Offset(0, 0.3),
          end: const Offset(0, 0),
        ).animate(CurvedAnimation(parent: _animationController, curve: Curve.decelerate)),
        child: child)
      )

  }
}
