import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class TextImageWidget extends StatelessWidget {
  final String text;
  final ImageProvider? backgroundImageProvider;
  final Color outerBackgroundColor; // Fallback if no image is provided
  final Color cardBackgroundColor;
  final Color textColor;
  final Color iconColor;
  final Color headerIconsBackgroundColor;
  final double fontSize;
  final String? fontFamily;
  final bool applyBlurEffect; // Will be set to false for no blur
  final double blurSigmaX;
  final double blurSigmaY;
  final Color glassOverlayColor;

  const TextImageWidget({
    Key? key,
    required this.text,
    this.backgroundImageProvider,
    this.outerBackgroundColor = const Color(0xFFB0BEC5), // A neutral grey for fallback blur
    this.cardBackgroundColor = const Color(0xFFF0F0F0),
    this.textColor = Colors.black,
    this.iconColor = Colors.red,
    this.headerIconsBackgroundColor = Colors.black54,
    this.fontSize = 20.0,
    this.fontFamily,
    this.applyBlurEffect = false, // Default to false for the new requirement
    this.blurSigmaX = 10.0,
    this.blurSigmaY = 10.0,
    this.glassOverlayColor = Colors.white10, // Subtle white overlay for glass effect
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget cardContent = Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _buildHeaderIcon(Icons.remove, headerIconsBackgroundColor.withOpacity(0.7)),
                  const SizedBox(width: 8),
                  _buildHeaderIcon(Icons.close, Colors.red.withOpacity(0.8)),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 5),
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: cardBackgroundColor,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Text(
                  text,
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    color: textColor,
                    fontSize: fontSize,
                    fontWeight: FontWeight.w500,
                    fontFamily: fontFamily,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: iconColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: 22.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return Container(
      width: 400,
      height: 500,
      color: Colors.transparent, // Root container for screenshot is transparent
      child: Stack(
        children: [
          // Layer 1: The background image or fallback color
          Positioned.fill(
            child: backgroundImageProvider != null
                ? Image(image: backgroundImageProvider!, fit: BoxFit.cover)
                : Container(color: outerBackgroundColor),
          ),
          // Layer 2: The blur effect (OPTIONAL)
          if (applyBlurEffect) // This will be false, so this layer is skipped
            Positioned.fill(
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: blurSigmaX, sigmaY: blurSigmaY),
                child: Container(
                  color: glassOverlayColor,
                ),
              ),
            ),
          // Layer 3: The main card content, padded from the edges
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: cardContent,
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderIcon(IconData icon, Color bgColor) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 12.0,
      ),
    );
  }
} 