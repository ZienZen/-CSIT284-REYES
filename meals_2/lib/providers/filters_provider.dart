import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import 'package:meals_2/models/meal.dart';
import 'package:meals_2/providers/meals_provider.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier() : super({
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.vegan: false,
    Filter.vegetarian: false,
  });
  void setFilter(Filter filter, bool isActive){
    state = {...state, filter: isActive};
  }

  void setFilters(Map<Filter, bool> chosen) {
    state = chosen; 
  }
}

final filtersProvider = StateNotifierProvider((ref) {
  return FiltersNotifier();
});