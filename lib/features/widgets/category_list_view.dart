import 'package:flutter/material.dart';
import 'package:today/features/widgets/CategoryCard.dart';
import '../domain/entities/category.dart';

/// A widget that displays a list of categories.
class CategoryListView extends StatelessWidget {
  final List<Category> categories;
  final Function(String, String) onCategoryTap;

  const CategoryListView({
    super.key,
    required this.categories,
    required this.onCategoryTap,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: .6,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return CategoryCard(
          name: category.name,
          backgroundColor: category.backgroundColor,
          color: category.color,
          description: category.description,
          onCardTap: (categoryId, categoryName) {
            onCategoryTap(category.id, category.name);
          },
          imageUrl: category.categoryIcon.original,
        );
      },
    );
  }
}

 