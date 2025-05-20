import 'package:flutter/material.dart';
import '../data/services/api_service.dart'; // Assuming ApiService handles fetching items
import '../domain/entities/letter.dart'; // Import the correct Letter entity
import '../widgets/letter_card.dart'; // Import the new LetterCard widget

class CategoryShowScreen extends StatefulWidget {
  final String categoryId;
  final String categoryName;
  final VoidCallback onGoBack;
  final Color? backgroundColor; // Add backgroundColor property

  const CategoryShowScreen({
    Key? key,
    required this.categoryId,
    required this.categoryName,
    required this.onGoBack,
    this.backgroundColor, // Add backgroundColor to the constructor
  }) : super(key: key);

  @override
  _CategoryShowScreenState createState() => _CategoryShowScreenState();
}

class _CategoryShowScreenState extends State<CategoryShowScreen> {
  List<Letter> _items = [];
  bool _isLoading = true;
  String? _error;
  final ApiService _apiService = ApiService(); // Use the existing ApiService

  @override
  void initState() {
    super.initState();
    _fetchItems();
  }

  Future<void> _fetchItems() async {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      // Assuming ApiService has a method to fetch items by category ID
      final items = await _apiService.fetchItemsByCategory(widget.categoryId);
      if (!mounted) return;
      setState(() {
        _items = items;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_error != null) {
      return Center(
        child: Text('Error fetching items: $_error'),
      );
    }

    if (_items.isEmpty) {
      return Center(
        child: Text('No items found for ${widget.categoryName}'),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.onGoBack,
        ),
      ),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          final item = _items[index];
          // Assuming your Letter entity has 'title' and 'body' properties
          return LetterCard(
            title: item.title,
            body: item.body,
            backgroundColor: widget.backgroundColor, // Pass the background color to LetterCard
          );
        },
      ),
    );
  }
} 