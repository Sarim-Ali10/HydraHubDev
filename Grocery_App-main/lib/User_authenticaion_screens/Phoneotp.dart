import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/Utlis/Utlis.dart';
import 'package:pinput/pinput.dart';
import '../HomeScreens/HomeScreen.dart';
import '../custom_text/Custom_color.dart';
import '../custom_text/Custom_text.dart';
import 'PhoneAuthentication.dart';

class PhoneOtp extends StatefulWidget {
  const PhoneOtp({super.key});

  @override
  State<PhoneOtp> createState() => _PhoneOtpState();
}

class _PhoneOtpState extends State<PhoneOtp> {
  final auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    var smscode="";
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            }, icon: Icon(Icons.arrow_back_ios_new_rounded),
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
                  CustomText(text: 'We need to register your phone before \n                     getting started !',size:
                  14,fontWeight: FontWeight.w400,),
                  SizedBox(height: 15,),
                  Pinput(
                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    showCursor: true,
                    length: 6,
                    keyboardType: TextInputType.number,
                    onChanged: (value){
                      smscode=value;
                    },
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
                        try{
                          PhoneAuthCredential credential = PhoneAuthProvider.credential(
                              verificationId: PhoneAuthentication.verificationid,
                              smsCode: smscode);

                          // Sign the user in (or link) with the credential
                          await auth.signInWithCredential(credential);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
                        }
                        catch(ex){
                          // Utilis().toastmessage
                        }

                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: CustomText(text: 'Verify Phone Number',
                          size: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(onPressed: (){
                          Navigator.pop(context);
                      }, child: CustomText(text: 'Edit phone number ?',size: 16,fontWeight: FontWeight.w400,color: Colors.black,)),
                    ],
                  )
                ],
              ) ,
            ),
          ) ,
        ));
  }
}
