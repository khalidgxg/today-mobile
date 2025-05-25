import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import '../widgets/text_image_widget.dart'; // Import the new widget

class ImageGenerator {
  // Create a ScreenshotController
  static final ScreenshotController _screenshotController = ScreenshotController();

  static Future<Uint8List?> generateImageFromText({
    required String text,
    required BuildContext context, // Still needed for theming/font access if desired later
    ImageProvider? backgroundImage, // New parameter for background image
    Color fallbackBackgroundColor = const Color(0xFFB0BEC5), // Restored default
    Color cardBackgroundColor = const Color(0xFFF0F0F0), // Added for card's background
    Color textColor = Colors.black,
    double textFontSize = 20.0, // Matched with TextImageWidget default
    String? fontFamily,
    bool applyBlur = false, // Defaulting to false for no blur
    double blurSigma = 10.0, // Kept for optional use if applyBlur is true
    Color glassEffectColor = Colors.white10, // Kept for optional use
  }) async {
    try {
      // Capture the TextImageWidget as an image
      // We pass a unique key to ensure the widget rebuilds if parameters change,
      // though for this simple case it might not be strictly necessary.
      final Uint8List? imageBytes = await _screenshotController.captureFromWidget(
        TextImageWidget(
          key: UniqueKey(), // Ensures widget rebuilds if needed
          text: text,
          backgroundImageProvider: backgroundImage,
          outerBackgroundColor: fallbackBackgroundColor,
          cardBackgroundColor: cardBackgroundColor,
          textColor: textColor,
          fontSize: textFontSize,
          fontFamily: fontFamily,
          applyBlurEffect: applyBlur, // This will pass false
          blurSigmaX: blurSigma,
          blurSigmaY: blurSigma, // Assuming symmetrical blur
          glassOverlayColor: glassEffectColor,
        ),
        delay: const Duration(milliseconds: 100), // Add a small delay for rendering
        pixelRatio: MediaQuery.of(context).devicePixelRatio, // Use device pixel ratio for clarity
        context: context, // Pass context for theming
        targetSize: const Size(400, 500), // Adjusted to match TextImageWidget
      );
      return imageBytes;
    } catch (e) {
      print('Error generating image: $e');
      return null;
    }
  }
} 