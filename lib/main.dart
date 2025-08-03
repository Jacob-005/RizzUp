import 'package:dating_app/pages/homepage/homepage.dart';
import 'package:dating_app/pages/splash%20screen/animated_splash_screen.dart';
import 'package:dating_app/pages/onboarding%20and%20landing/onboarding_pages.dart';
// import 'package:dating_app/pages/user%20signup/details_form.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dating App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.pink,
          brightness: Brightness.light,
        ),
      ),
      // Define initial route
      initialRoute: '/',
      // Define all routes
      routes: {
        '/': (context) => const SplashScreenWrapper(),
        '/onboarding': (context) => const OnboardingPages(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}

class SplashScreenWrapper extends StatefulWidget {
  const SplashScreenWrapper({super.key});

  @override
  State<SplashScreenWrapper> createState() => _SplashScreenWrapperState();
}

class _SplashScreenWrapperState extends State<SplashScreenWrapper> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      onAnimationComplete: () {
        Navigator.pushReplacementNamed(context, '/onboarding');
      },
    );
  }
}
