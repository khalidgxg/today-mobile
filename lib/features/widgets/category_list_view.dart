import 'package:flutter/material.dart';
import '../domain/entities/category.dart';

/// A widget that displays a list of categories.
class CategoryListView extends StatelessWidget {
  final List<Category> categories;

  const CategoryListView({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    // Use the ListView.builder logic previously in HomeScreen
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return ListTile(
          leading: category.imageUrl != null
              ? Image.network(
                  category.imageUrl!,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.image_not_supported, size: 50),
                )
              : const SizedBox(width: 50, height: 50, child: Icon(Icons.category, size: 50)),
          title: Text(
            category.name,
            style: const TextStyle(fontFamily: 'Cairo', fontSize: 18),
          ),
          onTap: () {
            // Placeholder action - Consider passing a callback for navigation
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('تم اختيار: ${category.name}')),
            );
          },
        );
      },
    );
  }
} 