import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../src/screens/home/ui/home_screen.dart';
import '../src/theme/colors.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Password Generator',
      home: const HomeScreen(),
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: AppColors.veryDarkGrey,
        fontFamily: GoogleFonts.jetBrainsMono().fontFamily,
        textTheme: const TextTheme(
          headlineLarge:
              TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold, color: AppColors.almostWhite),
          headlineMedium:
              TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: AppColors.almostWhite),
          bodyMedium:
              TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: AppColors.almostWhite),
        ),
      ),
    );
  }
}
