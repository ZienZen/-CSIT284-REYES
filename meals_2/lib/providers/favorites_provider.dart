
import 'package:flutter_riverpod/legacy.dart';
import 'package:meals_2/models/meal.dart';


class FavoriteMealsNotifier extends StateNotifier {
  new(super.state);

  Object? toggleMealFavoriteStatus(Meal meal) {}
}<List<Meal>>{
  FavoriteMealsNotifier() : super ([]);

  bool toggleMealFavoriteStatus(Meal meal){
    final mealIsFavorite = state.contains(meal);
    if (mealIsFavorite){
      state = state.where((m) => m.id != meal.id).tolist();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteMealsProvider = StateNotifierProvider<FavoriteMealsNotifier,List<Meal>>((ref){
  return FavoriteMealsNotifier();
});