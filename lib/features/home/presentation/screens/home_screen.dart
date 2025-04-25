import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الرئيسية'), // Home in Arabic
        automaticallyImplyLeading: false, // Remove back button if navigated from onboarding
      ),
      body: const Center(
        child: Text('أهلاً بك في الشاشة الرئيسية!'), // Welcome to the Home Screen!
      ),
    );
  }
} 