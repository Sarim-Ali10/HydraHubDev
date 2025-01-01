import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/HomeScreens/HomeScreen.dart';
import 'package:grocery_app/User_authenticaion_screens/LoginScreen.dart';

import '../pageview/PageView.dart';

class CheckingUserExists{
  void islogin(BuildContext context){
    final auth=FirebaseAuth.instance;
    final user= auth.currentUser;
    if(user!=null){
      Timer(Duration(seconds: 4),
            ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),)),
      );
    }
    else{
      Timer(Duration(seconds: 4),
            ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Page_View(),)),
      );
    }
  }

}