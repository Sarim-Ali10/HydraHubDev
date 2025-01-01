import 'dart:async';

import 'package:flutter/material.dart';
import 'package:skindiseasedetector/views/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    Timer(const Duration(milliseconds: 1000), () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen(),)),);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Splash Screen'),),
    );
  }
}
