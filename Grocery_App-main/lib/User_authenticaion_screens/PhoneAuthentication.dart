import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/custom_text/Custom_color.dart';

import '../custom_text/Custom_text.dart';
import 'Phoneotp.dart';

class PhoneAuthentication extends StatefulWidget {
  static String verificationid="";


  @override
  State<PhoneAuthentication> createState() => _PhoneAuthenticationState();
}

class _PhoneAuthenticationState extends State<PhoneAuthentication> {
  final countrycodecontroller=TextEditingController();
  var phonenumber="";
  @override
  void initState() {
    countrycodecontroller.text='+92';
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/imgs/phoneauthimg.png',width: 150,height: 150,),
                  SizedBox(height: 25,),
                  CustomText(text: 'Phone Verification',size:
                    24,fontWeight: FontWeight.w600,letterspacing: 1,color: MyColors.primarycolor,),
                  SizedBox(height: 8,),
                  CustomText(text: 'We need to register your phone before \n                     getting started!',size:
                  14,fontWeight: FontWeight.w400,),
                  SizedBox(height: 15,),
                  Container(
                    height: 55,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1,color: Colors.grey),
                      borderRadius: BorderRadius.circular(11)
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 10,),
                          SizedBox(width:40 ,
                          child: TextField(
                            controller: countrycodecontroller,
                              decoration: InputDecoration(
                                border: InputBorder.none
                              ),
                          ),
                          ),
                        SizedBox(width: 10,),
                        CustomText(text: '|', size: 33, fontWeight: FontWeight.w100,color: Colors.grey,),
                        SizedBox(width: 10,),
                        Expanded(child: TextField(
                          onChanged: (value){
                            phonenumber=value;
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Phone'
                          ),
                        ))
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
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
                      onPressed: () async{
                        await FirebaseAuth.instance.verifyPhoneNumber(
                          phoneNumber: '${countrycodecontroller.text + phonenumber}',
                          verificationCompleted: (PhoneAuthCredential credential) {},
                          verificationFailed: (FirebaseAuthException e) {},
                          codeSent: (String verificationId, int? resendToken) {
                            PhoneAuthentication.verificationid=verificationId;
                            Navigator.push(context, MaterialPageRoute(builder: (context) => PhoneOtp(),));
                          },
                          codeAutoRetrievalTimeout: (String verificationId) {},

                        );

                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: CustomText(text: 'Send Code',
                          size: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,),
                      )),
                ],
              ) ,
            ),
          ) ,
    ));
  }
}
