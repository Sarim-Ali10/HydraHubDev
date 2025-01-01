import 'dart:async';
import 'package:flutter/material.dart';
import 'package:grocery_app/custom_text/Custom_text.dart';
import 'package:grocery_app/splash_services/Checkinguserlogin.dart';
import '../pageview/PageView.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  CheckingUserExists checkingUserExists=CheckingUserExists();
  @override
  void initState() {
    super.initState();
    checkingUserExists.islogin(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
        children: [
        Container(
          height: 300,
            width: 300,
            child: Image(
              fit: BoxFit.contain,
                image: AssetImage('assets/imgs/logo.png'))),
        ],
    ),
      )
    );
  }
}
