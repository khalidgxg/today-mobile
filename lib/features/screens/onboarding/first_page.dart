import 'package:flutter/material.dart';

class FirstOnboardingPage extends StatelessWidget {
  const FirstOnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            flex: 60,
            child: Image.asset('assets/images/L1.png', fit: BoxFit.contain),
          ),
          const SizedBox(height: 20),
          Flexible(
            flex: 12,
            child: Text(
              'مرحباً بك في سحر اليوم!',
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
            flex: 10,
            child: Text(
              'احصل على جرعتك اليومية من الإيجابية.',
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