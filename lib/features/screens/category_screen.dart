import 'dart:async';
import 'package:flutter/material.dart';
import '../domain/entities/category.dart';
import '../widgets/category_list_view.dart';
import '../widgets/custom_app_bar.dart';

/// Screen responsible for fetching and displaying the list of categories.
class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Category> _categories = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Placeholder data (same as before)
    final sampleCategories = [
      const Category(id: '1', name: 'تفاؤل وسعادة', imageUrl: 'https://via.placeholder.com/150/92c952'),
      const Category(id: '2', name: 'تحفيز ذاتي', imageUrl: 'https://via.placeholder.com/150/771796'),
      const Category(id: '3', name: 'امتنان وشكر', imageUrl: 'https://via.placeholder.com/150/24f355'),
      const Category(id: '4', name: 'هدوء وسكينة', imageUrl: 'https://via.placeholder.com/150/d32776'),
      const Category(id: '5', name: 'نجاح وإنجاز', imageUrl: 'https://via.placeholder.com/150/f66b97'),
      const Category(id: '6', name: 'صحة وعافية', imageUrl: 'https://via.placeholder.com/150/56a8c2'),
    ];

    if (mounted) {
      setState(() {
        _categories = sampleCategories;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF77A69D);

    // Content only; AppBar and Scaffold moved to HomeScreen
    return _isLoading
        ? const Center(child: CircularProgressIndicator(color: primaryGreen))
        : CategoryListView(categories: _categories);
  }
} 