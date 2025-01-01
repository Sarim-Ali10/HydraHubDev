import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/User_authenticaion_screens/LoginScreen.dart';
import 'package:grocery_app/custom_text/Custom_color.dart';
import 'package:grocery_app/custom_text/Custom_text.dart';

import '../Utlis/Utlis.dart';

class ProfileScreen extends StatefulWidget {


  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //VARIABLE
  final fullnamecontroller=TextEditingController();
  var currentuser=FirebaseAuth.instance.currentUser!.uid;


  //SIGN OUT FUNCTION
  void signout() async {
    await FirebaseAuth.instance.signOut().then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
    });
  }
  void deleteaccount()async{
    await FirebaseAuth.instance.currentUser!.delete();
  }

   CollectionReference ref=FirebaseFirestore.instance.collection('Users');
   Future<DocumentSnapshot> getcurrentuserinfo()async{
     var currentuser=FirebaseAuth.instance.currentUser;
     return await FirebaseFirestore.instance.collection("Users").doc(currentuser!.uid).get();
   }

  // CUSTOM WIDGET

  Widget textformfield({required String hintText}){
    return Container(
          padding: EdgeInsets.all(15),
          margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11),
            color: Colors.grey.shade300
          ),
          child: CustomText(text: hintText,size: 16,fontWeight: FontWeight.w400),
        );
  }

  // SCREEN

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: getcurrentuserinfo(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if(snapshot.hasData){
              final fullname=snapshot.data!['full-name'];
              fullnamecontroller.text=fullname;
              return  Column(
                children: <Widget>[
                  Stack(
                      children:[
                        Positioned(
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                                color: MyColors.primarycolor,
                                borderRadius: BorderRadius.vertical(bottom: Radius.circular(300))
                            ),
                          ),

                        ),
                        Positioned(
                            top: 5,
                            left: 5,
                            child:IconButton(onPressed: (){
                              Navigator.pop(context);
                            },icon: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.black),) )
                      ]
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Stack(
                    children:[
                      Positioned(
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey.shade200,
                          child: IconButton(
                            onPressed: (){

                            },
                            icon: Icon(Icons.person_outline,size: 54,color: Colors.black12,),
                          ),
                        ),

                      ),
                      Positioned(
                        bottom: 0,
                          right: 15,
                          child:CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.white70,
                            child: IconButton(
                              onPressed: (){
                                showDialog(context: context, builder: (context){
                                  return AlertDialog(
                                    title: Text("Update"),
                                    content: Container(
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          hintText: "Edit Data",
                                        ),
                                        controller: fullnamecontroller,
                                      ),
                                    ),
                                    actions: [
                                      TextButton(onPressed: (){
                                        Navigator.pop(context);
                                      }, child: Text("Cancel")),
                                      TextButton(onPressed: (){
                                        Navigator.pop(context);
                                        ref.doc(snapshot.data!['userid'].toString()).update({
                                          'full-name':fullnamecontroller.text.toLowerCase(),
                                        }).then((value) {
                                          Utilis().toastmessage("Updated");
                                        }).onError((error, stackTrace) {
                                          Utilis().toastmessage(error.toString());
                                        });
                                      }, child: Text("Update")),
                                    ],

                                  );
                                });
                              },
                              icon: Icon(Icons.edit,size: 15,color: Colors.black,),
                            ),
                          ), ),
                     ]
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left:15.0),
                        child: CustomText(text: 'Username', size: 18, fontWeight: FontWeight.w600),
                      ),
                      textformfield(hintText: (fullname)),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: CustomText(text: 'Email', size: 18, fontWeight: FontWeight.w600),
                      ),
                      textformfield(hintText: (snapshot.data!['email'])),
                      SizedBox(height: 60,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
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
                                      signout();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                      child: CustomText(text: 'Log Out',
                                        size: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,),
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child: Column(
                              children: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFF790001),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                10)
                                        )
                                    ),
                                    onPressed: () {
                                      deleteaccount();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                      child: CustomText(text: 'Delete Account',
                                        size: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,),
                                    )),
                              ],
                            ),
                          )
                        ],
                      )


                    ],
            )
                ] ,
              );
            }
            if(snapshot.hasError){
              return Center(child: Icon(Icons.error_outline),);
            }
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }
            return Container();
          },
        ),
        )
      );
  }
}
