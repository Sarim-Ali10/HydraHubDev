import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skindiseasedetector/Model/ModelSchema.dart';
import 'package:skindiseasedetector/UserAuthentication/FirebaseService.dart';

import '../custom_text/Custom_text.dart';
import '../custom_text/my_textfield.dart';
import '../custom_text/square_tile.dart';
import 'LoginScreen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  UserServices userServices = UserServices();
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:Scaffold(
      backgroundColor: Color(0xFFf6f6f6),
      body: SafeArea(
        child: Center(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  width: 200, // Width of the circle
                  height: 200, // Height of the circle
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('Assets/Images/hydrahublogopng.png'),
                      fit: BoxFit.contain, // Ensures the image fits the circle
                    ),
                  ),
                ),),
              Expanded(
                  flex:1,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: const Text(
                            'Create Account!',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Zolina',
                                letterSpacing: 2

                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        MyTextField(
                          controller: _nameController,
                          hintText: 'Username',
                          obscureText: false,
                        ),
                        SizedBox(height: 10,),
                        MyTextField(
                          controller: _emailController,
                          hintText: 'Email',
                          obscureText: false,
                        ),
                        const SizedBox(height: 10),
                        MyTextField(
                          controller: _passwordController,
                          hintText: 'Password',
                          obscureText: true,
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: CustomText(text: 'Forget Password?', size: 12, fontWeight: FontWeight.normal,color: Colors.grey.shade600,),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    side: BorderSide(
                                        width: 1,
                                        color: Colors.grey.shade900
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            10)
                                    )
                                ),
                                onPressed: () {
                                  userServices.userRegister(UserModel(userPassword: _passwordController.text.toString(),userName: _nameController.text.toString(),userEmail: _emailController.text.toString()), context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  child: CustomText(text: 'Sign Up',
                                    size: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,),
                                )),
                          ],
                        ),
                        SizedBox(height: 20,),
                        const Divider(),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(text: 'Or continue with', size: 14, fontWeight: FontWeight.normal,color: Colors.black,)
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Divider(),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            SquareTile(imagePath: 'Assets/Images/googlelogo.png'),
                            SizedBox(width: 10),
                            SquareTile(imagePath: 'Assets/Images/phonelogo.png'),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an Account?',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                            const SizedBox(width: 4),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                              },
                              child: const Text(
                                'Sign in',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ))

            ],
          ),
        ),
      ),
    ));
  }
}
