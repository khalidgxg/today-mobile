import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/onboarding/bottom_section.dart';
import 'onboarding/first_page.dart';
import 'onboarding/second_page.dart';
import 'onboarding/third_page.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final PageController _pageController = PageController();
  final List<Widget> _pages = const [
    FirstOnboardingPage(),
    SecondOnboardingPage(),
    ThirdOnboardingPage(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _completeOnboarding(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenOnboarding', true);
    if (context.mounted) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  void _onSkipPressed() => _completeOnboarding(context);

  void _onNextPressed() {
    final currentPage = _pageController.page?.round() ?? 0;
    if (currentPage >= _pages.length - 1) {
      _completeOnboarding(context);
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(
          fontFamily: 'Cairo',
        ),
      ),
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    children: _pages,
                  ),
                ),
                BottomSection(
                  pageController: _pageController,
                  pageCount: _pages.length,
                  onNextPressed: _onNextPressed,
                  onSkipPressed: _onSkipPressed,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 