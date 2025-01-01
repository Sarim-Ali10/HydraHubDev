import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skindiseasedetector/constants/size_config.dart';
import 'package:skindiseasedetector/firebase_options.dart';
import 'package:skindiseasedetector/views/home_screen.dart';
import 'package:skindiseasedetector/views/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Gemini.init(apiKey: 'AIzaSyBQ6pT1grNc1SUs5RmiPOF0d2u3TVezEJY', enableDebugging: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return  MaterialApp(
      home:  SplashScreen(),
      title: 'Skin Disease Detector',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme()
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

