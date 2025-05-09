import 'package:flutter/material.dart';

class CategoryShowScreen extends StatelessWidget {
  final String categoryId;
  final String categoryName;
  final VoidCallback onGoBack;

  const CategoryShowScreen({
    Key? key,
    required this.categoryId,
    required this.categoryName,
    required this.onGoBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Category ID: $categoryId'),
          const SizedBox(height: 10),
          Text('Category Name: $categoryName'),
          const SizedBox(height: 20),
          Text('Items for "$categoryName" will be displayed here.'),
          // TODO: Add logic to fetch and display items for this category ID
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: onGoBack,
            child: const Text('Back to Categories'),
          ),
        ],
      ),
    );
  }
} 