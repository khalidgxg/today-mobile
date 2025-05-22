import 'dart:async';
import 'package:flutter/material.dart';
import '../domain/entities/category.dart';
import '../widgets/category_list_view.dart';
import './category_show_screen.dart'; // Import CategoryShowScreen
import '../data/services/api_service.dart';

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
  Color? _selectedCategoryBackgroundColor; // Add state for selected category background color
  Color? _selectedCategoryTextColor; // Add state for selected category text color
  final ApiService _apiService = ApiService();
  String? _error;
  Timer? _retryTimer;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  @override
  void dispose() {
    _retryTimer?.cancel();
    super.dispose();
  }

  Future<void> _fetchCategories() async {
    if (!mounted) return;
    
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final categories = await _apiService.fetchCategories();
      if (!mounted) return;
      
      setState(() {
        _categories = categories;
        _isLoading = false;
        _error = null;
        _retryTimer?.cancel();
        _retryTimer = null;
      });
    } catch (e) {
      if (!mounted) return;
      
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });

      // Auto-retry after 5 seconds if it's a network error
      if (e.toString().contains('Network error') && _retryTimer == null) {
        _retryTimer = Timer(const Duration(seconds: 5), _fetchCategories);
      }
    }
  }

  // Handler for when a category is tapped
  void _handleCategoryTap(String categoryId, String categoryName) {
    final tappedCategory = _categories.firstWhere(
      (category) => category.id == categoryId,
    );

    // Add a check to ensure tappedCategory is not null before accessing its properties
    if (tappedCategory != null) { // This check is technically redundant with firstWhere without orElse, but good practice
      setState(() {
        _selectedCategoryId = categoryId;
        _selectedCategoryName = categoryName;
        _selectedCategoryBackgroundColor = tappedCategory.backgroundColor; // Store the background color
        _selectedCategoryTextColor = tappedCategory.color; // Store the text color
      });
    }
  }

  // Handler for going back from detail view
  void _handleGoBack() {
    setState(() {
      _selectedCategoryId = null;
      _selectedCategoryName = null;
      _selectedCategoryBackgroundColor = null; // Clear the background color on back
      _selectedCategoryTextColor = null; // Clear the text color on back
    });
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              _error!.replaceAll('Exception: ', ''),
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _fetchCategories,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF77A69D);

    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: primaryGreen),
            SizedBox(height: 16),
            Text('Loading categories...'),
          ],
        ),
      );
    }

    if (_error != null) {
      return _buildErrorWidget();
    }

    if (_selectedCategoryId != null && _selectedCategoryName != null) {
      // Show category detail view
      return CategoryShowScreen(
        categoryId: _selectedCategoryId!,
        categoryName: _selectedCategoryName!,
        onGoBack: _handleGoBack,
        backgroundColor: _selectedCategoryBackgroundColor, // Pass the background color
        textColor: _selectedCategoryTextColor, // Pass the text color
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