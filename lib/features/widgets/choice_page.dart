import 'package:flutter/material.dart';
import 'package:today/features/domain/entities/choice.dart';
import 'package:today/features/screens/category_screen.dart';

/// Displays appropriate screen based on choice selection
class ChoicePage extends StatelessWidget {
  final Choice choice;
  
  const ChoicePage({super.key, required this.choice});

  @override
  Widget build(BuildContext context) {
    // تبديل المحتوى باستخدام switch
    switch (choice.title) {
      case 'القائمة':
        return const CategoryScreen();
      case 'المفضلات':
        return const Center(child: Text('صفحة المفضلات قريباً...'));
      default:
        return const Center(child: Text('قريباً...'));
    }
  }
} 