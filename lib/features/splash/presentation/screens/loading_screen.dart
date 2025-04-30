import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'; // Import the package

// Data structure for onboarding page content
class OnboardingInfo {
  final String imageAsset;
  final String title;
  final String description;

  OnboardingInfo({
    required this.imageAsset,
    required this.title,
    required this.description,
  });
}

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  int _currentPage = 0; // Represents VISUAL page index (0=right, 1=middle, 2=left)
  final PageController _pageController = PageController(initialPage: 0); // Explicitly start at logical index 0

  // Define green colors for the theme
  static const Color _primaryGreen = Color(0xFF4CAF50); // Standard Green 500
  static const Color _lightGreen = Color(0xFF81C784); // Standard Green 300

  // Arabic text remains the same
  final List<OnboardingInfo> _onboardingPages = [
    OnboardingInfo(
      imageAsset: 'assets/images/L1.png', // Use correct image path
      title: 'مرحباً بك في سحر اليوم!', // Use correct text
      description: 'احصل على جرعتك اليومية من الإيجابية.',
    ),
    OnboardingInfo(
      imageAsset: 'assets/images/L2.png', // Use correct image path
      title: 'اكتشف الإلهام اليومي معنا.',
      description: 'رسائل متنوعة لكل يوم.',
    ),
    OnboardingInfo(
      imageAsset: 'assets/images/L3.png', // Use correct image path
      title: 'ابدأ رحلتك نحو التفاؤل.',
      description: 'سجل دخولك للاستكشاف.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    // No timer needed
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Updated function to handle navigation
  Future<void> _completeOnboarding(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenOnboarding', true);
    if (context.mounted) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final double bottomSectionHeight = screenHeight * 0.35; // Define height for bottom section

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea( // Use SafeArea to avoid intrusions
        child: Column(
          children: [
            // Top Section: PageView for Content
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                reverse: true, // Keep RTL swipe
                itemCount: _onboardingPages.length,
                onPageChanged: (int page) {
                  // page from onPageChanged with reverse=true represents VISUAL index from LEFT (0, 1, 2)
                  // Let _currentPage directly reflect this visual index from the left
                  setState(() {
                     _currentPage = page; // Use the direct visual index
                  });
                },
                itemBuilder: (context, index) {
                  // 'index' is the visual index (0=right, 1=middle, 2=left with reverse:true)
                  // Map the visual index directly to the logical data index
                  final info = _onboardingPages[index]; // Direct mapping
                  return _buildPageContent(info);
                },
              ),
            ),

            // Bottom Section: Curve, Indicator, Buttons
            SizedBox(
              height: bottomSectionHeight,
              child: ClipPath(
                clipper: BottomDynamicWaveClipper(), // Keep the clipper
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [_lightGreen, _primaryGreen], // Green gradient
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end, // Align content to bottom
                    children: [
                      // Smooth Page Indicator
                      Padding(
                        padding: const EdgeInsets.only(bottom: 25.0), // Spacing above indicator
                        child: SmoothPageIndicator(
                          controller: _pageController,
                          count: _onboardingPages.length,
                          // Use `reversed` property for RTL support
                          // Need to reverse the order for the indicator as well
                          // The library handles RTL direction automatically if textDirection is RTL
                          textDirection: TextDirection.rtl,
                          effect: const WormEffect(
                            dotHeight: 8.0,
                            dotWidth: 8.0,
                            activeDotColor: Color(0xFFF5D1AB), // Your desired color
                            dotColor: Color(0xFFF5D1AB), // Can use the same color with opacity
                          ),                        
                        ),
                      ),
                      // Navigation Buttons
                      _buildNavigationButtons(),
                      // Bottom Padding within the green area
                      SizedBox(height: screenHeight * 0.05),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget to build the content of each page (Image + Text)
  Widget _buildPageContent(OnboardingInfo info) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Center vertically
        children: [
          Flexible(
            flex: 4, // Increased flex for the image
            child: Image.asset(
              info.imageAsset,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 30),
          Flexible(
            flex: 2, // Kept flex for text
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                info.title, // Use title from OnboardingInfo
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
              ),
            ),
          ),
           const SizedBox(height: 15),
           Flexible(
            flex: 2, // Kept flex for text
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                info.description, // Use description from OnboardingInfo
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.black54,
                      height: 1.4,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  // Navigation buttons build method (Keep adjusted contrast styles)
  Widget _buildNavigationButtons() {
     final buttonShape = RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      );
    final nextButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: _primaryGreen, // Green text
      backgroundColor: Colors.white,   // White background
      padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 14),
      shape: buttonShape,
      textStyle: const TextStyle(fontWeight: FontWeight.bold)
    );
    final skipButtonStyle = OutlinedButton.styleFrom(
      foregroundColor: Colors.white, // White text
      side: const BorderSide(color: Colors.white, width: 1.5), // White outline
      padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 14),
      shape: buttonShape,
      textStyle: const TextStyle(fontWeight: FontWeight.bold)
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // NEXT / FINISH Button (Now on the Left for RTL)
          ElevatedButton(
            onPressed: () {
              // Check visual page index (_currentPage)
              if (_currentPage == 2) { // Last visual page (leftmost)
                 _completeOnboarding(context);
              } else {
                // Move to the next visual page (towards the left)
                _pageController.nextPage( // <--- Corrected back to nextPage
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                );
              }
            },
            style: nextButtonStyle,
            child: Text(
              _currentPage == 2 ? 'إنهاء' : 'التالي', // Check visual index
            ),
          ),
          // SKIP Button (Now on the Right for RTL)
          AnimatedOpacity(
            // Show Skip button unless on the last visual page (leftmost)
            opacity: _currentPage != 2 ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: _currentPage != 2
              ? OutlinedButton(
                  onPressed: () => _completeOnboarding(context), // Use updated navigation function
                  style: skipButtonStyle,
                  child: const Text('تخطي'),
                )
              // Keep placeholder for consistent spacing
              : SizedBox(width: (skipButtonStyle.fixedSize?.resolve({})?.width) ?? (skipButtonStyle.minimumSize?.resolve({})?.width) ?? 120),
          ),
        ],
      ),
    );
  }
}

// Keep the clipper class
class BottomDynamicWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height * 0.20);
    path.quadraticBezierTo(
        size.width / 2,
        size.height * 0.0,
        size.width,
        size.height * 0.20
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// Remove previous clippers if they exist
// class AsymmetricGentleWaveClipper extends CustomClipper<Path> { ... }
// class ExactMatchWaveClipper extends CustomClipper<Path> { ... }
// class BottomNotchCurveClipper extends CustomClipper<Path> { ... }
// class BottomDiagonalWaveClipper extends CustomClipper<Path> { ... }
// class BottomWaveCurveClipper extends CustomClipper<Path> { ... }
// class BottomSoftCurveClipper extends CustomClipper<Path> { ... }
// class BottomCurveClipper extends CustomClipper<Path> { ... } 