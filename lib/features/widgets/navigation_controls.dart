import 'package:flutter/material.dart';

const Color _primaryGreen = Color(0xFF4CAF50);

class NavigationControls extends StatelessWidget {
  final PageController pageController;
  final int pageCount;
  final VoidCallback onNextPressed;
  final VoidCallback onSkipPressed;

  const NavigationControls({
    super.key,
    required this.pageController,
    required this.pageCount,
    required this.onNextPressed,
    required this.onSkipPressed,
  });

  @override
  Widget build(BuildContext context) {
    final buttonShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    );
    final nextButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: const Color(0xFF77A69D),
      backgroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 14),
      shape: buttonShape,
      textStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: 'Cairo',
      )
    );
    final skipButtonStyle = OutlinedButton.styleFrom(
      foregroundColor: Colors.white,
      side: const BorderSide(color: Colors.white, width: 1.5),
      padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 14),
      shape: buttonShape,
      textStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: 'Cairo',
      )
    );

    return ListenableBuilder(
      listenable: pageController,
      builder: (context, child) {
        final currentPage = pageController.page?.round() ?? 0;
        final isLastPage = currentPage >= pageCount - 1;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AnimatedOpacity(
                opacity: !isLastPage ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: !isLastPage
                  ? OutlinedButton(
                      onPressed: onSkipPressed,
                      style: skipButtonStyle,
                      child: const Text('تخطي'),
                    )
                  : SizedBox(width: (skipButtonStyle.fixedSize?.resolve({})?.width) ?? (skipButtonStyle.minimumSize?.resolve({})?.width) ?? 120),
              ),
              ElevatedButton(
                onPressed: onNextPressed,
                style: nextButtonStyle,
                child: Text(isLastPage ? 'إنهاء' : 'التالي'),
              ),
            ],
          ),
        );
      },
    );
  }
} 