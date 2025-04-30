import 'package:flutter/material.dart';

class SecondOnboardingPage extends StatelessWidget {
  const SecondOnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            flex: 4,
            child: Image.asset('assets/images/L2.png', fit: BoxFit.contain),
          ),
          const SizedBox(height: 30),
          Flexible(
            flex: 2,
            child: Text(
              'اكتشف الإلهام اليومي معنا.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    fontFamily: 'Cairo',
                  ),
            ),
          ),
          const SizedBox(height: 15),
          Flexible(
            flex: 2,
            child: Text(
              'رسائل متنوعة لكل يوم.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.black54,
                    height: 1.4,
                    fontFamily: 'Cairo',
                  ),
            ),
          ),
        ],
      ),
    );
  }
} 