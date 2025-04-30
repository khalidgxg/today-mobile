import 'package:flutter/material.dart';

/// A custom clipper that creates a wave-like effect for the bottom section
/// of the onboarding screens.
///
/// This clipper creates a curved path that:
/// * Starts from the top-left (0, 20% of height)
/// * Creates a wave using quadratic bezier curve
/// * Ends at the bottom-right corner
class BottomDynamicWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    // Start from top-left
    path.lineTo(0, size.height * 0.20);
    
    // Create the wave curve using quadratic bezier
    path.quadraticBezierTo(
      size.width / 2,    // Control point X (middle of width)
      size.height * 0.0, // Control point Y (top of container)
      size.width,        // End point X
      size.height * 0.20 // End point Y (20% from top)
    );
    
    // Complete the path by drawing lines to bottom-right and bottom-left
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
} 