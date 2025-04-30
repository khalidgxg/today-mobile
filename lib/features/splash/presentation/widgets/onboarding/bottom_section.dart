import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'bottom_dynamic_wave_clipper.dart';
import 'navigation_controls.dart';

const Color _lightGreen = Color(0xFF81C784);
const Color _primaryGreen = Color(0xFF4CAF50);
const Color _indicatorColor = Color(0xFFF5D1AB);

class BottomSection extends StatelessWidget {
  final PageController pageController;
  final int pageCount;
  final VoidCallback onNextPressed;
  final VoidCallback onSkipPressed;

  const BottomSection({
    super.key,
    required this.pageController,
    required this.pageCount,
    required this.onNextPressed,
    required this.onSkipPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BottomDynamicWaveClipper(),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.35,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [_lightGreen, _primaryGreen],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 25.0),
              child: SmoothPageIndicator(
                controller: pageController,
                count: pageCount,
                effect: const WormEffect(
                  dotHeight: 8.0,
                  dotWidth: 8.0,
                  activeDotColor: _indicatorColor,
                  dotColor: _indicatorColor,
                ),
              ),
            ),
            NavigationControls(
              pageController: pageController,
              pageCount: pageCount,
              onNextPressed: onNextPressed,
              onSkipPressed: onSkipPressed,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          ],
        ),
      ),
    );
  }
} 