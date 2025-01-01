import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skindiseasedetector/constants/size_config.dart';
import 'package:skindiseasedetector/views/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return  MaterialApp(
      home: const SplashScreen(),
      title: 'Skin Disease Detector',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme()
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

