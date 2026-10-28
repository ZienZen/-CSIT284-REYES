import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_2/providers/filters_provider.dart';

abstract class FiltersScreen extends ConsumerStatefulWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    Widget tile(Filter filter, String title, String subtitle) {
      return SwitchListTile(
        value: activeFilters[filter]!,
        onChanged: (isChecked) {
          ref.read(filtersProvider.notifier).setFilter(filter, isChecked);
        },
        title: Text(
          title,
          style: textTheme.titleLarge!.copyWith(color: scheme.onSurface),
        ),
        subtitle: Text(
          subtitle,
          style: textTheme.labelMedium!.copyWith(color: scheme.onSurface),
        ),
        activeThumbColor: scheme.tertiary,
        contentPadding: const EdgeInsets.only(left: 34, right: 22),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: Column(
        children: [
          tile(Filter.glutenFree, 'Gluten-free',
              'Only include gluten-free meals.'),
          tile(Filter.lactoseFree, 'Lactose-free',
              'Only include lactose-free meals.'),
          tile(Filter.vegetarian, 'Vegetarian',
              'Only include vegetarian meals.'),
          tile(Filter.vegan, 'Vegan', 'Only include vegan meals.'),
        ],
      ),
    );
  }
}
