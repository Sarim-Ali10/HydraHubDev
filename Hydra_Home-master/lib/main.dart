import 'package:flutter/material.dart';
import 'package:hydrahub/HomeScreens/HomeScreen.dart';
import 'package:hydrahub/OnBoarding/SplashScreen.dart';
import 'package:hydrahub/pageview/PageView.dart';

import 'UserAuthentication/LoginScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
