import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Represents a category entity fetched from the backend.
@immutable
class Category {
  final String id;
  final String name;
  final String description;
  final Color color;
  final Color backgroundColor;
  final CategoryIcon categoryIcon;
  final String createdAt;
  final String updatedAt;

  const Category({
    required this.id,
    required this.name,
    required this.description,
    required this.color,
    required this.backgroundColor,
    required this.categoryIcon,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'].toString(),
      name: json['name'] as String,
      description: json['description'] as String,
      color: _parseColor(json['color'] as String?) ?? Colors.black,
      backgroundColor: _parseColor(json['backgroundColor'] as String?) ?? Colors.white,
      categoryIcon: CategoryIcon.fromJson(json['category_icon'] as Map<String, dynamic>),
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );
  }

  static Color? _parseColor(String? colorString) {
    if (colorString == null) return null;

    // Remove any leading '#' if present
    colorString = colorString.replaceAll('#', '');
    
    // Handle RGB format
    if (colorString.contains('rgb')) {
      final rgbValues = RegExp(r'(\d+)').allMatches(colorString);
      if (rgbValues.length >= 3) {
        return Color.fromRGBO(
          int.parse(rgbValues.elementAt(0).group(1)!),
          int.parse(rgbValues.elementAt(1).group(1)!),
          int.parse(rgbValues.elementAt(2).group(1)!),
          1.0,
        );
      }
      return null;
    }

    // Handle hex format
    try {
      if (colorString.length == 6) {
        return Color(int.parse('FF$colorString', radix: 16));
      } else if (colorString.length == 8) {
        return Color(int.parse(colorString, radix: 16));
      }
    } catch (e) {
      debugPrint('Error parsing color: $e');
    }
    
    return null;
  }

  // Override equality and hashCode for value comparison
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Category &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          description == other.description &&
          color == other.color &&
          backgroundColor == other.backgroundColor &&
          categoryIcon == other.categoryIcon &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ description.hashCode ^ color.hashCode ^ backgroundColor.hashCode ^ categoryIcon.hashCode ^ createdAt.hashCode ^ updatedAt.hashCode;

  @override
  String toString() {
    return 'Category{id: $id, name: $name, description: $description, color: $color, backgroundColor: $backgroundColor, categoryIcon: $categoryIcon, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}

class CategoryIcon {
  final String original;
  final String name;

  const CategoryIcon({
    required this.original,
    required this.name,
  });

  factory CategoryIcon.fromJson(Map<String, dynamic> json) {
    return CategoryIcon(
      original: json['original'] as String,
      name: json['name'] as String,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryIcon &&
          runtimeType == other.runtimeType &&
          original == other.original &&
          name == other.name;

  @override
  int get hashCode => original.hashCode ^ name.hashCode;

  @override
  String toString() {
    return 'CategoryIcon{original: $original, name: $name}';
  }
} 