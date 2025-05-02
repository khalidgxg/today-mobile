import 'package:flutter/foundation.dart';

/// Represents a category entity fetched from the backend.
@immutable
class Category {
  final String id;
  final String name;
  // Add imageUrl field
  final String? imageUrl;

  const Category({
    required this.id,
    required this.name,
    this.imageUrl, // Make it optional in constructor
  });

  // Optional: Add factory constructor for JSON parsing later
  // factory Category.fromJson(Map<String, dynamic> json) {
  //   return Category(
  //     id: json['id'] as String,
  //     name: json['name'] as String,
  //     imageUrl: json['imageUrl'] as String?,
  //   );
  // }

  // Optional: Add toJson method if needed later
  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'name': name,
  //     'imageUrl': imageUrl,
  //   };
  // }

  // Override equality and hashCode for value comparison
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Category &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          imageUrl == other.imageUrl; // Include imageUrl in comparison

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ imageUrl.hashCode; // Include imageUrl in hash

  @override
  String toString() {
    return 'Category{id: $id, name: $name, imageUrl: $imageUrl}'; // Include imageUrl in string representation
  }
} 