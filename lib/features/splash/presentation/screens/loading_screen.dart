import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences

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
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Define green colors for the theme
  static const Color _primaryGreen = Color(0xFF4CAF50); // Standard Green 500
  static const Color _lightGreen = Color(0xFF81C784); // Standard Green 300

  // Arabic text remains the same
  final List<OnboardingInfo> _onboardingPages = [
    OnboardingInfo(
      imageAsset: 'assets/images/onboarding_1.png', // Placeholder
      title: 'مرحباً بك في تطبيق التوكيدات',
      description: 'احصل على جرعتك اليومية من الإيجابية والإلهام.',
    ),
    OnboardingInfo(
      imageAsset: 'assets/images/onboarding_2.png', // Placeholder
      title: 'رسائل متنوعة لكل يوم',
      description: 'اكتشف رسائل الجمعة، الحب، التحفيز، والمزيد.',
    ),
    OnboardingInfo(
      imageAsset: 'assets/images/onboarding_3.png', // Placeholder
      title: 'ابدأ رحلتك الآن',
      description: 'سجل دخولك لاستكشاف عالم من التوكيدات والرسائل الملهمة.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _initializeApp() async {
    // Simulate loading time or perform actual async initialization
    await Future.delayed(const Duration(seconds: 3)); 

    // TODO: Add logic here to check authentication status
    // TODO: Fetch initial data if needed from an API
    
    // After initialization, navigate to the appropriate screen
    // For example, navigate to HomeScreen or LoginScreen
    // Navigator.of(context).pushReplacementNamed('/home'); // Example navigation
    // Or:
    // Navigator.of(context).pushReplacementNamed('/login'); // Example navigation
  }

  // Helper method to mark onboarding as seen and navigate
  Future<void> _finishOnboarding(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenOnboarding', true);

    // Use pushReplacementNamed to prevent going back to onboarding
    if (context.mounted) { // Check if the widget is still in the tree
       Navigator.of(context).pushReplacementNamed('/home'); // Navigate to home
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    // final screenWidth = MediaQuery.of(context).size.width;
    // final theme = Theme.of(context); // Use specific color now

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // PageView for Image and Text content
          Positioned.fill(
            bottom: screenHeight * 0.28, // Adjust space for the bottom curve
            child: PageView.builder(
              controller: _pageController,
              itemCount: _onboardingPages.length,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemBuilder: (context, index) {
                return _buildOnboardingPageContent(_onboardingPages[index]);
              },
            ),
          ),

          // Curved Bottom Area with Green Gradient
          Positioned(
            bottom: 0,
            left: 0,
            right: -4,
            child: ClipPath(
              clipper: BottomDynamicWaveClipper(), // Use renamed clipper
              child: Container(
                height: screenHeight * 0.45,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [_lightGreen, Color.fromARGB(255, 54, 160, 57)], // Green gradient
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildPageIndicator(),
                    const SizedBox(height: 25),
                    _buildNavigationButtons(),
                    SizedBox(height: screenHeight * 0.06),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Builds the content (Image + Text) for the top white area
  Widget _buildOnboardingPageContent(OnboardingInfo info) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 2),
          // Updated Image Placeholder
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            width: MediaQuery.of(context).size.width * 0.6,
            decoration: BoxDecoration(
              color: Colors.grey[200], // Lighter grey placeholder color
              borderRadius: BorderRadius.circular(15.0), // Rounded corners
            ),
            child: Icon(
              Icons.image_outlined, // Use outline icon
              size: MediaQuery.of(context).size.height * 0.1, // Adjust icon size
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 45),
          Text(
            info.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
          ),
          const SizedBox(height: 15),
          Text(
            info.description,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.black54,
                  height: 1.4, // Adjust line height if needed
                ),
          ),
          const Spacer(flex: 1),
        ],
      ),
    );
  }

  // Builds the page indicator dots (adjust color for contrast)
  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_onboardingPages.length, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          width: 8.0,
          height: 8.0,
          decoration: BoxDecoration(
            color: _currentPage == index ? Colors.white : Colors.white.withOpacity(0.5),
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }

  // Update button styles to match the screenshot
  Widget _buildNavigationButtons() {
    // Green theme button styles - Adjusted for contrast
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
          AnimatedOpacity(
            opacity: _currentPage != _onboardingPages.length - 1 ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: _currentPage != _onboardingPages.length - 1
              ? OutlinedButton(
                  onPressed: () => _finishOnboarding(context),
                  style: skipButtonStyle,
                  child: const Text('تخطي'), // Arabic text
                )
              : SizedBox(width: (skipButtonStyle.fixedSize?.resolve({})?.width) ?? (skipButtonStyle.minimumSize?.resolve({})?.width) ?? 120),
          ),
          ElevatedButton(
            onPressed: () {
              if (_currentPage == _onboardingPages.length - 1) {
                _finishOnboarding(context);
              } else {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                );
              }
            },
            style: nextButtonStyle,
            child: Text(
              _currentPage == _onboardingPages.length - 1 ? 'إنهاء' : 'التالي', // Arabic text
            ),
          ),
        ],
      ),
    );
  }
}

// Renamed clipper with the final adjusted curve
class BottomDynamicWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height * 0.01);

    path.cubicTo(
      size.width * 0.10, size.height * 0.60,
      size.width * 0.99, size.height * 0.08,
      size.width, size.height * 0.60
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