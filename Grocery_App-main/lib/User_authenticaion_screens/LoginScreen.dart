import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/User_authenticaion_screens/SignUpScreen.dart';
import 'package:grocery_app/Utlis/Utlis.dart';
import '../HomeScreens/HomeScreen.dart';
import '../custom_text/Custom_color.dart';
import '../custom_text/Custom_text.dart';
import '../custom_text/custom_textform.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey _key = GlobalKey<FormState>();
  bool ispassword = true;
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  void signin()async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: emailcontroller.text.toString(),
          password: passwordcontroller.text.toString());
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
    }on FirebaseAuthException
    catch(ex){
       Utilis().toastmessage(ex.code.toString());
    }
  }
  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey.shade200,
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              flex:1,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            'assets/imgs/applogo.png'
                        )
                    )
                ),
              ),
            ),
            Expanded(
                flex: 4,
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: 20, vertical: 20),
                  padding: EdgeInsets.symmetric(
                      vertical: 20, horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(16)
                  ),
                  width: double.infinity,
                  height: 800,
                  child: Column(
                    children: [
                      Form(
                        key: _key,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(text: 'Welcome\nBack!',
                                size: 28,
                                fontWeight: FontWeight.w600,
                                color: MyColors.primarycolor,
                                letterspacing:1.2 ),
                            CustomText(text: 'Good to see you again',
                                size: 14,
                                fontWeight: FontWeight.w400,
                                color:Colors.black38),
                            SizedBox(height: 50,),
                            CustomText(text: 'Sign in',
                                size: 28,
                                fontWeight: FontWeight.w600,
                                color: MyColors.primarycolor),
                            SizedBox(height: 15,),
                            CustomTextForm(hinttext: 'Email',
                              controller: emailcontroller,
                              prefixicon: Icon(Icons.email_outlined),),
                            SizedBox(height: 10,),
                            CustomTextForm(hinttext: 'Password',
                              controller: passwordcontroller,
                              prefixicon: Icon(Icons.lock_outline),
                              ispassword: ispassword == false ? false : true,
                              suffixicon: IconButton(onPressed: () {
                                setState(() {
                                  ispassword = !ispassword;
                                  print(ispassword);
                                });
                              },
                                  icon: ispassword == true ? Icon(
                                      Icons.visibility_off_outlined) : Icon(
                                      Icons.visibility_outlined)),),
                            SizedBox(height: 5,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CustomText(text: 'Don\'t Have an Account? ',
                                  size: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => SignUpScreen(),));
                                    },
                                    child: CustomText(text: 'Sign Up',
                                      size: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey,)),
                              ],
                            ),
                            SizedBox(height: 10,),

                            SizedBox(height: 10,),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: MyColors.primarycolor,
                                  side: BorderSide(
                                      width: 1,
                                      color: Colors.grey.shade500
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10)
                                  )
                              ),
                              onPressed: () {
                                  signin();
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: CustomText(text: 'Sign In',
                                  size: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,),
                              )),
                        ],
                      ),
                    ],
                  ),

                ))
          ],


        ),
      ),
    );
  }
}
