import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:grocery_app/User_authenticaion_screens/Authentication.dart';
import 'package:grocery_app/custom_text/Custom_color.dart';
import 'package:grocery_app/custom_text/Custom_text.dart';
import 'package:grocery_app/custom_text/custom_textform.dart';
import '../HomeScreens/HomeScreen.dart';
import '../Utlis/Utlis.dart';
import 'Facebookscreen.dart';
import 'LoginScreen.dart';
import 'PhoneAuthentication.dart';

class SignUpScreen extends StatefulWidget {
  static String username=TextEditingController() as String;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey _key = GlobalKey<FormState>();
  bool loading=false;
  bool ispassword = true;
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  String useremail="";
  // REGISTER USER BY EMAIL AND PASSWORD

  void registerUser() async {
    String username=usernamecontroller.text.toString();
    String email= emailcontroller.text.toString();
    String password=passwordcontroller.text.toString();
    try {
      setState(() {
        loading=true;
      });
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: email,
          password: password);
        setState(() {
          loading=true;
        });
      FirebaseFirestore.instance.collection("Users")
      .doc(userCredential!.user!.uid)
      .set({
        "email":email,
        "full-name":username,
        "password":password,
        "userid":userCredential!.user!.uid,
      }).then((value){
        setState(() {
          loading=false;
        });
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen(),));
      });

    } on FirebaseAuthException
    catch (ex) {
      setState(() {
        loading=false;
      });
      if(ex.code == "weak-password"){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Weak-Password"))
        );
      }
      else if(ex.code == "email-already-in-use"){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Email-Already-in-Use"))
        );
      }
      Utilis().toastmessage(ex.code.toString());
    }
  }
  @override
  void dispose() {
    usernamecontroller.dispose();
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
                        vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(16)
                    ),
                    width: double.infinity,
                    height: 800,
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Form(
                          key: _key,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(text: 'Create Account',
                                  size: 24,
                                  fontWeight: FontWeight.w600,
                                  color: MyColors.primarycolor),
                              SizedBox(height: 20,),
                              CustomTextForm(hinttext: 'Username',
                                  controller: usernamecontroller,
                                  prefixicon: Icon(Icons.person_outline),
                                  errormsg: 'Please Enter Username'),
                              SizedBox(height: 10,),
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
                              SizedBox(height: 25,),
                              //SIGN UP BUTTON
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  loading == false ?
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
                                        setState(() {
                                          loading=true;
                                        });
                                        registerUser();
                                        setState(() {
                                          loading=false;
                                        });
                                        usernamecontroller.clear();
                                        emailcontroller.clear();
                                        passwordcontroller.clear();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 20),
                                        child: CustomText(text: 'Sign Up',
                                          size: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,),
                                      ))
                                      : Center(child: CircularProgressIndicator(),)

                                ],
                              ),

                            ],
                          ),
                        ),
                        SizedBox(height: 20,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             CustomText(text: 'OR',
                                size: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,),

                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(text: 'Sign In with',
                              size: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,),

                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                border: Border.all(width: 1,color:Colors.grey.shade400),
                                color: Colors.white70,
                                shape: BoxShape.circle
                              ),
                              child: Center(
                                child: IconButton(
                                  onPressed: (){

                                  },
                                  icon: Icon(Icons.facebook_outlined,size: 32,color: Colors.blue,),
                                ),
                              ),
                            ),
                            SizedBox(width: 20,),
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  border: Border.all(width: 1,color:Colors.grey.shade400),
                                  color: Colors.white70,
                                  shape: BoxShape.circle
                              ),
                              child: Center(
                                child: IconButton(
                                  onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder:(context) =>PhoneAuthentication(),));
                                  },
                                  icon: Icon(Icons.numbers_outlined,size: 30,color: Colors.black,),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(text: 'Have an Account? ',
                              size: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => LoginScreen(),));
                                },
                                child: CustomText(text: 'Sign In',
                                  size: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey,)),
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


// REGISTER USER BY FACEBOOK
//    Future<UserCredential> signInWithFacebook() async {
//      // Trigger the sign-in flow
//      final LoginResult loginResult = await FacebookAuth.instance.login(
//        permissions: [
//          'email',
//          'public_profile',
//          'user_birthday'
//        ]
//      );
//
//      // Create a credential from the access token
//      final OAuthCredential facebookAuthCredential = FacebookAuthProvider
//          .credential(loginResult.accessToken!.token);
//      final userData= await FacebookAuth.instance.getUserData();
//
//      // useremail=userData['email'];
//
//      // Once signed in, return the UserCredential
//      return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
//  }

// Container(
// padding: EdgeInsets.symmetric(
// horizontal: 10, vertical: 8),
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(21),
// border: Border.all(
// color: Colors.grey.shade300)
// ),
// child: Row(
// children: [
// Column(
// children: [
// Icon(Icons.facebook_outlined, size: 28,
// color: Colors.blue,)
// ],
// ),
// SizedBox(width: 5,),
// Column(
// children: [
// GestureDetector(
// onTap: (){
// // signInWithFacebook();
// },
// child: CustomText(
// text: 'Sign In with Facebook',
// size: 15,
// fontWeight: FontWeight.w400,
// color: Colors.blue,),
// )
// ],
// )
// ],
// ),
// ),


// Container(
// padding: EdgeInsets.symmetric(
// horizontal: 10, vertical: 8),
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(21),
// border: Border.all(
// color: Colors.grey.shade300)
// ),
// child: Row(
// children: [
// Column(
// children: [
// Icon(Icons.numbers_outlined, size: 28,
// color: Colors.black,)
// ],
// ),
// SizedBox(width: 8,),
// Column(
// children: [
// CustomText(
// text: 'Sign In with Mobile Number',
// size: 15,
// fontWeight: FontWeight.w400,
// color: Colors.black,)
// ],
// )
// ],
// ),
// ),
