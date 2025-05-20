import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/category.dart';
import '../../domain/entities/letter.dart';

class ApiService {
  static const String baseUrl = 'https://today.kdala.icu/api';

  Future<List<Category>> fetchCategories() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/categories'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw Exception('Connection timeout. Please check your internet connection.');
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final List<dynamic> data = jsonResponse['data'];
        return data.map((categoryJson) => Category.fromJson(categoryJson)).toList();
      } else if (response.statusCode == 404) {
        throw Exception('API endpoint not found. Please verify the URL.');
      } else if (response.statusCode >= 500) {
        throw Exception('Server error. Please try again later.');
      } else {
        throw Exception('Failed to load categories. Status code: ${response.statusCode}');
      }
    } on FormatException catch (e) {
      throw Exception('Invalid response format: ${e.message}');
    } catch (e) {
      if (e.toString().contains('SocketException')) {
        throw Exception('Network error: Please check your internet connection.');
      } else if (e.toString().contains('HandshakeException')) {
        throw Exception('SSL error: Could not establish secure connection.');
      } else {
        throw Exception('Error fetching categories: $e');
      }
    }
  }

  // Placeholder method to fetch items by category ID
  Future<List<Letter>> fetchItemsByCategory(String categoryId) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Return hardcoded list of items for demonstration
    // Replace this with actual API call when the endpoint is available
    return [
      Letter(title: 'Letter 1 for $categoryId', body: 'Body of letter 1.'),
      Letter(title: 'Letter 2 for $categoryId', body: 'Body of letter 2 with more details.'),
      Letter(title: 'Letter 3 for $categoryId', body: 'Another letter body.'),
    ];
  }
} 