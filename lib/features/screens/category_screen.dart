import 'dart:async';
import 'package:flutter/material.dart';
import '../domain/entities/category.dart';
import '../widgets/category_list_view.dart';
import './category_show_screen.dart'; // Import CategoryShowScreen

/// Screen responsible for fetching and displaying the list of categories.
class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Category> _categories = [];
  bool _isLoading = true;
  String? _selectedCategoryId; // Add state for selected category ID
  String? _selectedCategoryName; // Add state for selected category name

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
      const Category(id: '1', name: 'تفاؤل وسعادة', imageUrl: 'https://via.placeholder.com/150/92c952',description:'جرعتك اليومية من الامل والسعادة' ,color:Color.fromARGB(253, 252, 253, 255),backgroundColor:  Color.fromARGB(255, 172, 137, 253) ),
      const Category(id: '2', name: 'تحفيز ذاتي', imageUrl: 'https://via.placeholder.com/150/771796',description:'sfdsf' ,color:Color.fromARGB(255, 255, 255, 255),backgroundColor:  Color.fromARGB(255, 129, 253, 237) ),
      const Category(id: '3', name: 'امتنان وشكر', imageUrl: 'https://via.placeholder.com/150/24f355',description:'sdfsdf' ,color:Color.fromARGB(255, 255, 255, 255) ,backgroundColor:   Color.fromARGB(255, 162, 255, 139)),
      const Category(id: '4', name: 'هدوء وسكينة', imageUrl: 'https://via.placeholder.com/150/d32776',description:'sdfsdf' ,color:Color.fromARGB(255, 255, 255, 255) ,backgroundColor:   Color.fromARGB(255, 129, 82, 240)),
      const Category(id: '5', name: 'نجاح وإنجاز', imageUrl: 'https://via.placeholder.com/150/f66b97',description:'dfsd' ,color:Color.fromARGB(255, 255, 255, 255) ,backgroundColor:   Color.fromARGB(255, 129, 82, 240)),
      const Category(id: '6', name: 'صحة وعافية', imageUrl: 'https://via.placeholder.com/150/56a8c2',description:'sd' ,color:Color.fromARGB(255, 255, 255, 255) ,backgroundColor:   Color.fromARGB(255, 129, 82, 240)),
    ];

    if (mounted) {
      setState(() {
        _categories = sampleCategories;
        _isLoading = false;
      });
    }
  }

  // Handler for when a category is tapped
  void _handleCategoryTap(String categoryId, String categoryName) {
    setState(() {
      _selectedCategoryId = categoryId;
      _selectedCategoryName = categoryName;
    });
  }

  // Handler for going back from detail view
  void _handleGoBack() {
    setState(() {
      _selectedCategoryId = null;
      _selectedCategoryName = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF77A69D);

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator(color: primaryGreen));
    }

    if (_selectedCategoryId != null && _selectedCategoryName != null) {
      // Show category detail view
      return CategoryShowScreen(
        categoryId: _selectedCategoryId!,
        categoryName: _selectedCategoryName!,
        onGoBack: _handleGoBack,
      );
    } else {
      // Show category list view
      return CategoryListView(
        categories: _categories,
        onCategoryTap: _handleCategoryTap,
      );
    }
  }
} 