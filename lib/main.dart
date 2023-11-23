import 'package:edu_assignment/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          titleLarge:
              GoogleFonts.palanquin(fontSize: 40, fontWeight: FontWeight.bold),
        ),
      ),
      home: HomeScreen(),
    );
  }
}
