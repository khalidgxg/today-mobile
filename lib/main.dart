import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/splash/presentation/screens/loading_screen.dart'; // Import LoadingScreen
import 'features/home/presentation/screens/home_screen.dart';    // Import HomeScreen

Future<void> main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Check if onboarding has been seen
  final prefs = await SharedPreferences.getInstance();
  final bool seenOnboarding = prefs.getBool('seenOnboarding') ?? false;

  runApp(MyApp(seenOnboarding: seenOnboarding));
}

class MyApp extends StatelessWidget {
  final bool seenOnboarding;

  const MyApp({super.key, required this.seenOnboarding});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'سحر اليوم', // Updated App Title
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        // Set text theme for Arabic font support if needed
        // textTheme: GoogleFonts.cairoTextTheme( // Example using google_fonts
        //   Theme.of(context).textTheme,
        // ),
        useMaterial3: true,
      ),
      // Set initial route based on seenOnboarding status
      initialRoute: seenOnboarding ? '/home' : '/onboarding',
      routes: {
        '/onboarding': (context) => const LoadingScreen(),
        '/home': (context) => const HomeScreen(),
        // Add other routes here (e.g., '/login', '/settings')
      },
      // Remove the default home property
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
