import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/screens/loading_screen.dart'; // Import LoadingScreen
import 'features/screens/home_screen.dart'; // Re-import HomeScreen
// Remove CategoryScreen import if no longer needed
// import 'features/home/presentation/screens/category_screen.dart'; 

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
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF77A69D)), // Use primary green as seed
        fontFamily: 'Cairo', // Apply default font globally
        textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Cairo'),
        // Set text theme for Arabic font support if needed
        // textTheme: GoogleFonts.cairoTextTheme( // Example using google_fonts
        //   Theme.of(context).textTheme,
        // ),
        useMaterial3: true,
      ),
      // Change initial route back to /home
      initialRoute: seenOnboarding ? '/home' : '/onboarding',
      routes: {
        '/onboarding': (context) => const LoadingScreen(),
        // Change route back to HomeScreen
        '/home': (context) => const HomeScreen(), 
        // Remove /categories route definition
        // '/categories': (context) => const CategoryScreen(), 
        // Keep /home route definition only if HomeScreen is still used for something else
        // '/home': (context) => const HomeScreen(),
        // Add other routes here (e.g., '/login', '/settings')
        
      },
      // Remove the default home property
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
